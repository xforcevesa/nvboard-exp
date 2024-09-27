module rnd_seg(
    input clk,
    input rst,
    input en,
    input in,
    input [7:0] seed,
    output [7:0] seg1,
    output [7:0] seg2
);

wire [7:0] segs [15:0];
assign segs[0] = 8'b11111101;
assign segs[1] = 8'b01100000;
assign segs[2] = 8'b11011010;
assign segs[3] = 8'b11110010;
assign segs[4] = 8'b01100110;
assign segs[5] = 8'b10110110;
assign segs[6] = 8'b10111110;
assign segs[7] = 8'b11100000;
assign segs[8] = 8'b11111111;
assign segs[9] = 8'b11110111;
assign segs[10] = 8'b11101111;
assign segs[11] = 8'b00111111;
assign segs[12] = 8'b10011101;
assign segs[13] = 8'b01111011;
assign segs[14] = 8'b10011111;
assign segs[15] = 8'b10001111;

reg [7:0] counter;

rnd my_rnd (
    .clk(clk),
    .rst(rst),
    .en(en),
    .in(in),
    .seed(seed),
    .out(counter)
);

assign seg1 = ~segs[counter[3:0]];

// assign seg1 = ~seed;

assign seg2 = ~segs[counter[7:4]];

endmodule
