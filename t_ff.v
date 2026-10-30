
module t_ff (input  wire clk, input  wire rst_n, wire t, output reg  q);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 1'b0;
        end else begin
            if (t)
                q <= ~q;
            else
                q <= q;
        end
    end

endmodule
