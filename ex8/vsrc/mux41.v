module mux41 (
    input [7:0] sel,
    input [1:0] idx,
    output [1:0] out
);

assign out = 
    ({2{idx == 2'b00}} & sel[1:0]) |
    ({2{idx == 2'b01}} & sel[3:2]) |
    ({2{idx == 2'b10}} & sel[5:4]) |
    ({2{idx == 2'b11}} & sel[7:6])
    ;

endmodule

