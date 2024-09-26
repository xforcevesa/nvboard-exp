module alu_seg(
    input [3:0] opa,
    input [3:0] opb,
    input [2:0] code,
    input en,
    output [7:0] seg1,
    output [7:0] seg2
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

reg [3:0] counter;

alu my_alu (
    .opa(opa),
    .opb(opb),
    .code(code),
    .res(counter)
);

assign seg1 = en? ~segs[counter % 8] : ~segs[0];

assign seg2 = en? ~segs[counter / 8] : ~segs[0];

endmodule
