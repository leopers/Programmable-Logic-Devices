`include "mux_8_1_logic.v"

module alu (
    input [3:0] src_a,
    input [3:0] src_b,
    input [2:0] operation,
    output [3:0] alu_result,
    output zero_flag
);

    wire [3:0] w0, w1, w2, w3, w4, w5, w6, w7;

    assign w0 = src_a & src_b;
    assign w1 = src_a | src_b;
    assign w2 = src_a + src_b;
    assign w3 = src_a << 1;
    assign w4 = src_a - src_b;
    assign w5 = src_a >> 1;
    assign w6 = (src_a < src_b) ? 4'b0001 : 4'b0000;
    assign w7 = src_a ^ src_b;

    mux_8_1_logic mux (
        .i0(w0),
        .i1(w1),
        .i2(w2),
        .i3(w3),
        .i4(w4),
        .i5(w5),
        .i6(w6),
        .i7(w7),
        .s(operation),
        .y(alu_result)
    );

    assign zero_flag = (alu_result == 4'b0000);

endmodule