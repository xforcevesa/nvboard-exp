module ps2_keyboard(clk,resetn,ps2_clk,ps2_data,keycode,tapped);
    input clk,resetn,ps2_clk,ps2_data;
    output reg [7:0] keycode;
    output reg tapped;

    reg [9:0] buffer;        // ps2_data bits
    reg [3:0] count;  // count ps2_data bits
    reg [2:0] ps2_clk_sync;

    reg [9:0] last_buffer;

    always @(posedge clk) begin
        ps2_clk_sync <=  {ps2_clk_sync[1:0],ps2_clk};
    end

    wire sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1]; // negative edge of ps2_clk

    always @(posedge clk) begin
        if (resetn == 0) begin // reset
            count <= 0;
        end
        else begin
            if (sampling) begin
              if (count == 4'd10) begin
                if ((buffer[0] == 0) &&  // start bit
                    (ps2_data)       &&  // stop bit
                    (^buffer[9:1])) begin      // odd  parity
                    $display("receive %x", buffer[8:1]);
                    keycode = buffer[8:1];
                    tapped <= 1;
                end
                count <= 0;     // for next
              end else begin
                if (count == 0) begin
                  last_buffer <= buffer;
                end
                buffer[count] <= ps2_data;  // store ps2_data
                count <= count + 3'b1;
              end
            end
            if (last_buffer[8:1] == 8'hf0) tapped <= 0; // tapped
        end
    end

endmodule