// tb for full adder

`include "full_adder.v"

module full_adder_tb;

    reg A, B, CIN;   // UUT inputs
    wire S, COUT;    // UUT outputs

    // Full adder instance
    Full_Adder uut (.A(A), .B(B), .Cin(CIN), .S(S), .Cout(COUT));

    initial begin
        $dumpfile("full_adder_tb.vcd");
        $dumpvars(0, full_adder_tb);
    end

    initial begin
        A = 1'b0; B = 1'b0; CIN = 1'b0; #1;
        A = 1'b0; B = 1'b0; CIN = 1'b1; #1;
        A = 1'b0; B = 1'b1; CIN = 1'b0; #1;
        A = 1'b0; B = 1'b1; CIN = 1'b1; #1;
        A = 1'b1; B = 1'b0; CIN = 1'b0; #1;
        A = 1'b1; B = 1'b0; CIN = 1'b1; #1;
        A = 1'b1; B = 1'b1; CIN = 1'b0; #1;
        A = 1'b1; B = 1'b1; CIN = 1'b1; #1;
    end
  
endmodule   

