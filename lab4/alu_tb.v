`include "alu.v"

module alu_tb ();

    parameter DATA_WIDTH = 4;
    parameter OPCODE_LENGTH = 3;

    reg [DATA_WIDTH - 1:0] A;
    reg [DATA_WIDTH - 1:0] B;
    reg [OPCODE_LENGTH - 1:0] OP;

    wire [DATA_WIDTH - 1:0] RESULT;
    wire F_ZERO;

    alu uut (
        .src_a(A),
        .src_b(B),
        .operation(OP),
        .alu_result(RESULT),
        .zero_flag(F_ZERO)
    );

    initial
        begin
            A = 1; B = 2; OP = 3'b000;
            #1 A = 2; B = 3; OP = 3'b001;
            #1 A = 1; B = 3; OP = 3'b010;
            #1 A = 2; B = 1; OP = 3'b011;
            #1 A = 4; B = 1; OP = 3'b100;
            #1 A = 4; B = 1; OP = 3'b101;
            #1 A = 6; B = 2; OP = 3'b110;
            #1 A = 3; B = 2; OP = 3'b111;
        end

    initial begin
        $monitor($time, " A = %d, B = %d, OP = %b, RESULT = %b, Z_FLAG = %b", 
                 A, B, OP, RESULT, F_ZERO);
        #20 $finish;
    end

    initial
        begin
            $dumpfile("alu_tb.vcd");
            $dumpvars(0, alu_tb);
        end

endmodule