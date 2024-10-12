module key_seg(
    input clk,
    input rst,
    input en,
    input [7:0] keycode,
    output [7:0] seg1,
    output [7:0] seg2,
    output [7:0] seg3,
    output [7:0] seg4,
    output [7:0] seg5,
    output [7:0] seg6
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

reg [7:0] cnt;
reg [7:0] counter;
reg char_reg;
reg [2:0] cc;
reg [7:0] last_keycode;

always @(posedge clk or negedge rst) begin
    if (rst) begin
        counter <= 8'b00000000;
        cc <= 3'b000;
        cnt <= 8'b00000000;
        last_keycode <= 8'b00000000;
    end else if (en) begin
        case (keycode)
            8'h0e: counter <= "~";
            8'h16: counter <= "1";
            8'h1e: counter <= "2";
            8'h26: counter <= "3";
            8'h25: counter <= "4";
            8'h2e: counter <= "5";
            8'h36: counter <= "6";
            8'h3d: counter <= "7";
            8'h3e: counter <= "8";
            8'h46: counter <= "9";
            8'h45: counter <= "0";
            8'h4e: counter <= "-";
            8'h55: counter <= "=";
            8'h5d: counter <= "\\";
            8'h15: counter <= "q";
            8'h1d: counter <= "w";
            8'h24: counter <= "e";
            8'h2d: counter <= "r";
            8'h2c: counter <= "t";
            8'h35: counter <= "y";
            8'h3c: counter <= "u";
            8'h43: counter <= "i";
            8'h44: counter <= "o";
            8'h4d: counter <= "p";
            8'h54: counter <= "[";
            8'h5b: counter <= "]";
            8'h1c: counter <= "a";
            8'h1b: counter <= "s";
            8'h23: counter <= "d";
            8'h2b: counter <= "f";
            8'h34: counter <= "g";
            8'h33: counter <= "h";
            8'h3b: counter <= "j";
            8'h42: counter <= "k";
            8'h4b: counter <= "l";
            8'h4c: counter <= ";";
            8'h52: counter <= "'";
            8'h5a: counter <= "\r";
            8'h1a: counter <= "z";
            8'h22: counter <= "x";
            8'h21: counter <= "c";
            8'h2a: counter <= "v";
            8'h32: counter <= "b";
            8'h31: counter <= "n";
            8'h3a: counter <= "m";
            8'h41: counter <= ",";
            8'h49: counter <= ".";
            8'h4a: counter <= "/";
            8'h29: counter <= " ";
            default: counter <= 8'b00000000;
        endcase
    end
    if (| keycode) begin
        char_reg <= counter[cc];
        cc <= cc + 1;
    end
    if (keycode == 8'hf0 && last_keycode != keycode) cnt <= cnt + 1;
    last_keycode <= keycode;
end

assign seg1 = ~segs[keycode[3:0]];
assign seg2 = ~segs[keycode[7:4]];
assign seg3 = ~segs[counter[3:0]];
assign seg4 = ~segs[counter[7:4]];
assign seg5 = ~segs[cnt[3:0]];
assign seg6 = ~segs[cnt[7:4]];

endmodule
