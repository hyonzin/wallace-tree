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
  for (i=0; i<WIDTH; i=i+1) begin
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
  for (i=0; i<WIDTH; i=i+1) begin
    if (i == 0)
      half_adder ha (W[i], S[i], X[i], Y[i]);
    else if (i < WIDTH-1)
      full_adder fa (W[i], S[i], X[i], Y[i], W[i-1]);
    else
      full_adder fa (S[i+1], S[i], X[i], Y[i], W[i-1]);
  end
  endgenerate

endmodule // carry_save_adder
