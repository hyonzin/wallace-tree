module testbench;
  reg  A;
  reg  B;
  wire S;
  wire C;

  reg  [7:0] X;
  reg  [7:0] Y;
  reg  [7:0] Z;
  wire [7:0] S2;
  wire [7:0] C2;

  reg  [7:0][5:0] I;
  wire [9:0] S3;
  wire [7:0] C3;

  half_adder fa(C, S, A, B);
  carry_save_adder csa(C2, S2, X, Y, Z);
  wallace_tree wt(S3, I);

  initial begin
    $display("Half Adder Test");
    A = 0;
    B = 0;
    #10
    $display("C: %b, S: %b", C, S);
    A = 0;
    B = 1;
    #10
    $display("C: %b, S: %b", C, S);
    A = 1;
    B = 0;
    #10
    $display("C: %b, S: %b", C, S);
    A = 1;
    B = 1;
    #10
    $display("C: %b, S: %b", C, S);

    $display("Carry-save Adder Test");
    X = 8'b00000001;
    Y = 8'b00000010;
    Z = 8'b00000100;
    #10
    $display("C: %b, S: %b", C2, S2);
    X = 8'b01010101;
    Y = 8'b00110011;
    Z = 8'b00001111;
    #10
    $display("C: %b, S: %b", C2, S2);
    X = 8'b11111111;
    Y = 8'b11111111;
    Z = 8'b11111111;
    #10
    $display("C: %b, S: %b", C2, S2);

    $display("Six-operand Wallace Tree Test");
    I[0] = 6'b010101;
    I[1] = 6'b110011;
    I[2] = 6'b001111;
    I[3] = 6'b010101;
    I[4] = 6'b110011;
    I[5] = 6'b001111;
    I[6] = 6'b001111;
    I[7] = 6'b001111;
    #10
    $display("S: %b", S3);

  end

  initial begin
    #90 $finish;
  end
endmodule
