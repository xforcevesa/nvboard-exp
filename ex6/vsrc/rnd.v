module rnd (
    input clk,
    input rst,
    input en,
    input in,
    input [7:0] seed,
    output [7:0] out
);

reg [7:0] cur_rnd;

reg pass;

always @(posedge clk or posedge en or negedge rst) begin
    if (rst | en) begin
        cur_rnd = 8'b0;
        pass = 0;
    end
    else begin
        if (cur_rnd == 8'b0) cur_rnd = seed;
        else begin
            if (in & ~pass) begin
                cur_rnd = {|{cur_rnd[4:2], cur_rnd[0]}, cur_rnd[7:1]};
                pass = 1;
            end
            if (~in) pass = 0;
        end
    end
end

assign out = cur_rnd;

endmodule
