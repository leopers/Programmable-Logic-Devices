`include "mux_4_1_logic.v"

module mux_4_1_logic_tb;

    reg [3:0] i0, i1, i2, i3;
    reg [1:0] s;
    wire [3:0] y;

    mux_4_1_logic uut (
        .i0(i0),
        .i1(i1),
        .i2(i2),
        .i3(i3),
        .s(s),
        .y(y)
    );

    initial begin
        $dumpfile("mux_4_1_logic_tb.vcd");
        $dumpvars(0, mux_4_1_logic_tb);
    end

    initial begin
        i0 = 4'b0001;
        i1 = 4'b0010;
        i2 = 4'b0100;
        i3 = 4'b1000;

        s = 2'b00; #1;
        s = 2'b01; #1;
        s = 2'b10; #1;
        s = 2'b11; #1;
    end

endmodule