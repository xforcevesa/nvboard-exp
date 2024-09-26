module alu(
    input [3:0] opa,
    input [3:0] opb,
    input [2:0] code,
    output [3:0] res
);

assign res = (code == 3'b000) ? opa + opb :
            (code == 3'b001) ? opa - opb :
            (code == 3'b010) ? ~opa :
            (code == 3'b011) ? opa & opb :
            (code == 3'b100) ? opa | opb :
            (code == 3'b101) ? opa ^ opb :
            (code == 3'b110) ? ((opa < opb) ? 4'b0001 : 4'b0000) :
            (code == 3'b111) ? ((opa == opb) ? 4'b0001 : 4'b0000) :
            4'b0000;

endmodule
