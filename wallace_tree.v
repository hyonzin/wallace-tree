/**
 * Half Adder
 */
module half_adder (C, S, A, B);

  output C, S;
  input  A, B;

  assign {C, S} = A + B;

endmodule // half_adder


/**
 * Full Adder
 */
module full_adder (Co, S, A, B, Ci);

  output Co, S;
  input  A, B, Ci;

  assign {Co, S} = A + B + Ci;

endmodule // full_adder


/**
 * Carry-save Adder with 8-bit input
 */
module carry_save_adder (C, S, X, Y, Z);

  parameter WIDTH = 8;

  output wire [WIDTH-1 : 0] C, S;
  input  wire [WIDTH-1 : 0] X, Y, Z;

  genvar i;
  generate
  for(i=0; i<WIDTH; i=i+1) begin
    full_adder fa2 (C[i], S[i], X[i], Y[i], Z[i]);
  end
  endgenerate

endmodule // carry_save_adder

/**
 * Carry-propagte Adder with 8-bit input
 */
module carry_propagate_adder (S, X, Y);

  parameter WIDTH = 8;

  output wire [WIDTH   : 0] S;
  input  wire [WIDTH-1 : 0] X, Y;
  wire        [WIDTH-1 : 0] W;

  genvar i;
  generate
  for(i=0; i<WIDTH; i=i+1) begin
    if (i == 0)
      half_adder ha (W[i], S[i], X[i], Y[i]);
    else if (i < WIDTH-1)
      full_adder fa (W[i], S[i], X[i], Y[i], W[i-1]);
    else
      full_adder fa (S[i+1], S[i], X[i], Y[i], W[i-1]);
  end
  endgenerate

endmodule // carry_save_adder


/**
 * A Part of Six-operand Wallace Tree with 8-bit input
 * for a bit
 */
module part_of_wallace_tree (Co, S1, S0, Ci, X);

  output wire [2:0] Co;
  output wire S1, S0;
  input wire [2:0] Ci;
  input wire [5:0] X;

  wire [2:0] W;

  full_adder fa1(Co[0], W[0], X[0], X[1],  X[2]);
  full_adder fa2(Co[1], W[1], X[3], X[4],  X[5]);
  full_adder fa3(Co[2], W[2], W[0], W[1],  Ci[0]);
  full_adder fa4(S1,    S0,   W[2], Ci[1], Ci[2]);

endmodule // part_of_wallace_tree


/**
 * Six-operand Wallace Tree with 8-bit input
 */
module wallace_tree (S, X);

  output wire [2:0] Co; //3?
  output wire [9:0] S; //10?
  input  wire [7:0][5:0] X;

  wire [2:0] W0;
  wire [6:0][2:0] W1;
  wire [8:0] W2;
  wire [8:0] W3;
  wire       W4, W5;

  genvar i;
  generate
  for(i=0; i<8; i=i+1) begin
    if (i == 0)
      part_of_wallace_tree p (W1[i], W2[i], W3[i], 3'b000, X[i]);
    else if (i == 7)
      part_of_wallace_tree p (W0, W2[i], W3[i], W1[i-1], X[i]);
    else
      part_of_wallace_tree p (W1[i], W2[i], W3[i], W1[i-1], X[i]);
  end
  endgenerate

  full_adder fa1 (W2[8], W3[8], W0[0], W0[1], W0[2]);

  assign S[0] = W3[0];
  carry_propagate_adder cpa ({W4, S[8:1]}, W2[7:0], W3[8:1]);
  half_adder ha (W5, S[9], W4, W2[8]);

endmodule // wallace_tree
