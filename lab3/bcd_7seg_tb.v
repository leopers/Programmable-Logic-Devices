`include "bcd_7seg.v"

module bcd_7seg_tb;

    reg [3:0] bcd;
    wire [6:0] seg;

    bcd_7seg uut (
        .bcd(bcd),
        .seg(seg)
    );

    initial begin
        $dumpfile("bcd_7seg_tb.vcd");
        $dumpvars(0, bcd_7seg_tb);

        bcd = 4'b0000; #1;
        bcd = 4'b0001; #1;
        bcd = 4'b0010; #1;
        bcd = 4'b0011; #1;
        bcd = 4'b0100; #1;
        bcd = 4'b0101; #1;
        bcd = 4'b0110; #1;
        bcd = 4'b0111; #1;
        bcd = 4'b1000; #1;
        bcd = 4'b1001; #1;
        bcd = 4'b1010; #1;
        bcd = 4'b1011; #1;
        bcd = 4'b1100; #1;
        bcd = 4'b1101; #1;
        bcd = 4'b1110; #1;
        bcd = 4'b1111; #1;
    end

endmodule