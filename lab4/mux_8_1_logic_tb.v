`include "mux_8_1_logic.v"

module mux_8_1_logic_tb;

    reg [3:0] i0, i1, i2, i3, i4, i5, i6, i7;
    reg [2:0] s;
    wire [3:0] y;

    mux_8_1_logic uut (
        .i0(i0),
        .i1(i1),
        .i2(i2),
        .i3(i3),
        .i4(i4),
        .i5(i5),
        .i6(i6),
        .i7(i7),
        .s(s),
        .y(y)
    );

    initial begin
        $dumpfile("mux_8_1_logic_tb.vcd");
        $dumpvars(0, mux_8_1_logic_tb);
    end

    initial begin
        i0 = 4'b0001;
        i1 = 4'b0010;
        i2 = 4'b0011;
        i3 = 4'b0100;
        i4 = 4'b0101;
        i5 = 4'b0110;
        i6 = 4'b0111;
        i7 = 4'b1000;

        s = 3'b000; #1;
        s = 3'b001; #1;
        s = 3'b010; #1;
        s = 3'b011; #1;
        s = 3'b100; #1;
        s = 3'b101; #1;
        s = 3'b110; #1;
        s = 3'b111; #1;

    end

endmodule