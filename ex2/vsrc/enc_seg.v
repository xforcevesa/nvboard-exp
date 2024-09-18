module enc_seg(
    input [7:0] data,
    input en,
    output [7:0] seg
);

wire [7:0] segs [7:0];
assign segs[0] = 8'b11111101;
assign segs[1] = 8'b01100000;
assign segs[2] = 8'b11011010;
assign segs[3] = 8'b11110010;
assign segs[4] = 8'b01100110;
assign segs[5] = 8'b10110110;
assign segs[6] = 8'b10111110;
assign segs[7] = 8'b11100000;

reg [2:0] counter;

encode83 my_enc (
    .x(data),
    .en(en),
    .y(counter)
);

assign seg = ~segs[counter];

endmodule
