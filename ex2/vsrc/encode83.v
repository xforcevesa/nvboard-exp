module encode83(
    input [7:0] x,   // 8-bit input
    input en,        // Enable signal
    output reg [2:0] y  // 3-bit output for the selected one-hot encoded index
);

always @(x or en) begin
    if (en) begin
        casez (x)
            8'b00000001: y = 3'b000;  // Input 0
            8'b0000001z: y = 3'b001;  // Input 1
            8'b000001zz: y = 3'b010;  // Input 2
            8'b00001zzz: y = 3'b011;  // Input 3
            8'b0001zzzz: y = 3'b100;  // Input 4
            8'b001zzzzz: y = 3'b101;  // Input 5
            8'b01zzzzzz: y = 3'b110;  // Input 6
            8'b1zzzzzzz: y = 3'b111;  // Input 7
            default: y = 3'b000;      // Default case
        endcase
    end else begin
        y = 3'b000;
    end
end

endmodule
