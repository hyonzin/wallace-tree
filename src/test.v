// It's testbench code for modules in this project.
// Expected Output:

// ----------------
// Half Adder Test
// A:0, B:0 -> C: 0, S: 0
// A:0, B:1 -> C: 0, S: 1
// A:1, B:0 -> C: 0, S: 1
// A:1, B:1 -> C: 1, S: 0
// ----------------
// Full Adder Test
// A:0, B:0, Ci: 0 -> Co: 0, S: 0
// A:0, B:0, Ci: 1 -> Co: 0, S: 1
// A:0, B:1, Ci: 0 -> Co: 0, S: 1
// A:0, B:1, Ci: 1 -> Co: 1, S: 0
// A:1, B:0, Ci: 0 -> Co: 0, S: 1
// A:1, B:0, Ci: 1 -> Co: 1, S: 0
// A:1, B:1, Ci: 0 -> Co: 1, S: 0
// A:1, B:1, Ci: 1 -> Co: 1, S: 1
// ----------------
// Carry-save Adder Test
// X:00000001, Y:00000010, Z:00000100 -> C: 00000000, S: 00000111
// X:01010101, Y:00110011, Z:00001111 -> C: 00010111, S: 01101001
// X:11111111, Y:11111111, Z:11111111 -> C: 11111111, S: 11111111
// ----------------
// Six-operand Wallace Tree Test
// S: 1111110011

module testbench;
  // for half adder
  reg  A, B;
  wire S, C;

  // for full adder
  reg Ai, Bi, Ci;
  wire So, Co;

  // for carry save adder
  reg  [7:0] X;
  reg  [7:0] Y;
  reg  [7:0] Z;
  wire [7:0] S2;
  wire [7:0] C2;

  // for wallace tree
  reg  [7:0][5:0] I;
  wire [10:0] S3;

  // using modules
  half_adder ha(C, S, A, B);
  full_adder fa(Co, So, Ai, Bi, Ci);
  carry_save_adder csa(C2, S2, X, Y, Z);
  wallace_tree wt(S3, I);

  initial begin
    $display("----------------");
    $display("Half Adder Test");
    {A, B} = 2'b00;
    #1 $display("A:%b, B:%b -> C: %b, S: %b", A, B, C, S);
    {A, B} = 2'b01;
    #1 $display("A:%b, B:%b -> C: %b, S: %b", A, B, C, S);
    {A, B} = 2'b10;
    #1 $display("A:%b, B:%b -> C: %b, S: %b", A, B, C, S);
    {A, B} = 2'b11;
    #1 $display("A:%b, B:%b -> C: %b, S: %b", A, B, C, S);

    $display("----------------");
    $display("Full Adder Test");
    {Ai, Bi, Ci} = 3'b000;
    #1 $display("A:%b, B:%b, Ci: %b -> Co: %b, S: %b", Ai, Bi, Ci, Co, So);
    {Ai, Bi, Ci} = 3'b001;
    #1 $display("A:%b, B:%b, Ci: %b -> Co: %b, S: %b", Ai, Bi, Ci, Co, So);
    {Ai, Bi, Ci} = 3'b010;
    #1 $display("A:%b, B:%b, Ci: %b -> Co: %b, S: %b", Ai, Bi, Ci, Co, So);
    {Ai, Bi, Ci} = 3'b011;
    #1 $display("A:%b, B:%b, Ci: %b -> Co: %b, S: %b", Ai, Bi, Ci, Co, So);
    {Ai, Bi, Ci} = 3'b100;
    #1 $display("A:%b, B:%b, Ci: %b -> Co: %b, S: %b", Ai, Bi, Ci, Co, So);
    {Ai, Bi, Ci} = 3'b101;
    #1 $display("A:%b, B:%b, Ci: %b -> Co: %b, S: %b", Ai, Bi, Ci, Co, So);
    {Ai, Bi, Ci} = 3'b110;
    #1 $display("A:%b, B:%b, Ci: %b -> Co: %b, S: %b", Ai, Bi, Ci, Co, So);
    {Ai, Bi, Ci} = 3'b111;
    #1 $display("A:%b, B:%b, Ci: %b -> Co: %b, S: %b", Ai, Bi, Ci, Co, So);

    $display("----------------");
    $display("Carry-save Adder Test");
    X = 8'b00000001;
    Y = 8'b00000010;
    Z = 8'b00000100;
    #1 $display("X:%b, Y:%b, Z:%b -> C: %b, S: %b", X, Y, Z, C2, S2);
    X = 8'b01010101;
    Y = 8'b00110011;
    Z = 8'b00001111;
    #1 $display("X:%b, Y:%b, Z:%b -> C: %b, S: %b", X, Y, Z, C2, S2);
    X = 8'b11111111;
    Y = 8'b11111111;
    Z = 8'b11111111;
    #1 $display("X:%b, Y:%b, Z:%b -> C: %b, S: %b", X, Y, Z, C2, S2);

    $display("----------------");
    $display("Six-operand Wallace Tree Test");
    I[0] = 6'b010101;
    I[1] = 6'b110011;
    I[2] = 6'b001111;
    I[3] = 6'b010101;
    I[4] = 6'b110011;
    I[5] = 6'b001111;
    I[6] = 6'b001111;
    I[7] = 6'b001111;
    #1 $display("S: %b", S3);  // 18+27+228+237+246+255 = 1011
    I[0] = 6'b111111;
    I[1] = 6'b111111;
    I[2] = 6'b111111;
    I[3] = 6'b111111;
    I[4] = 6'b111111;
    I[5] = 6'b111111;
    I[6] = 6'b111111;
    I[7] = 6'b111111;
    #1 $display("S: %b", S3);  // 255*6 = 1530

    $finish;
  end

  initial begin
    $dumpfile("test.lxt");
    $dumpvars(0, C);  $dumpvars(0, S);
    $dumpvars(0, Co); $dumpvars(0, So);
    $dumpvars(0, C2); $dumpvars(0, S2);
    $dumpvars(0, I);  $dumpvars(0, S3);

  end
endmodule
