module top(
    input clk,
    input rst,
    input [4:0] btn,
    input [11:0] sw,
    input ps2_clk,
    input ps2_data,
    input uart_rx,
    output uart_tx,
    output [15:0] ledr,
    output VGA_CLK,
    output VGA_HSYNC,
    output VGA_VSYNC,
    output VGA_BLANK_N,
    output [7:0] VGA_R,
    output [7:0] VGA_G,
    output [7:0] VGA_B,
    output [7:0] seg0,
    output [7:0] seg1,
    output [7:0] seg2,
    output [7:0] seg3,
    output [7:0] seg4,
    output [7:0] seg5,
    output [7:0] seg6,
    output [7:0] seg7
);

mux41 my_mux41(
    .idx(sw[1:0]),
    .sel(sw[9:2]),
    .out(ledr[1:0])
);

// led my_led(
//     .clk(clk),
//     .rst(rst),
//     .btn(btn),
//     .sw(sw),
//     .ledr(ledr)
// );

assign VGA_CLK = clk;

wire [9:0] h_addr;
wire [9:0] v_addr;
wire [23:0] vga_data;

vga_ctrl my_vga_ctrl(
    .pclk(clk),
    .reset(rst),
    .vga_data(vga_data),
    .h_addr(h_addr),
    .v_addr(v_addr),
    .hsync(VGA_HSYNC),
    .vsync(VGA_VSYNC),
    .valid(VGA_BLANK_N),
    .vga_r(VGA_R),
    .vga_g(VGA_G),
    .vga_b(VGA_B)
);

reg [7:0] keycode;
reg tapped;

ps2_keyboard my_keyboard(
    .clk(clk),
    .resetn(~rst),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .keycode(keycode),
    .tapped(tapped)
);

// seg my_seg(
//     .clk(clk),
//     .rst(rst),
//     .o_seg0(seg0),
//     .o_seg1(seg1),
//     .o_seg2(seg2),
//     .o_seg3(seg3),
//     .o_seg4(seg4),
//     .o_seg5(seg5),
//     .o_seg6(seg6),
//     .o_seg7(seg7)
// );
// enc_seg my_enc_seg(
//     .data(sw[7:0]),
//     .en(sw[8]),
//     .seg(seg0)
// );
// alu_seg my_alu_seg(
//     .opa(sw[3:0]),
//     .opb(sw[7:4]),
//     .code(sw[10:8]),
//     .en(sw[11]),
//     .seg1(seg0),
//     .seg2(seg1)
// );
// rnd_seg my_rnd_seg(
//     .clk(clk),
//     .seed(sw[7:0]),
//     .rst(rst),
//     .en(sw[8]),
//     .in(sw[9]),
//     .seg1(seg0),
//     .seg2(seg1)
// );
key_seg my_key_seg(
    .clk(clk),
    .rst(rst),
    .keycode(keycode),
    .en(sw[0]),
    .seg1(seg0),
    .seg2(seg1),
    .seg3(seg4),
    .seg4(seg5),
    .seg5(seg6),
    .seg6(seg7),
    .tapped(tapped)
);


vmem my_vmem(
    .h_addr(h_addr),
    .v_addr(v_addr[8:0]),
    .vga_data(vga_data)
);

uart my_uart(
  .tx(uart_tx),
  .rx(uart_rx)
);

endmodule

module vmem(
    input [9:0] h_addr,
    input [8:0] v_addr,
    output [23:0] vga_data
);

reg [23:0] vga_mem [524287:0];

initial begin
    $readmemh("resource/picture.hex", vga_mem);
end

assign vga_data = vga_mem[{h_addr, v_addr}];

endmodule
