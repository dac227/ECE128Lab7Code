module smallCounter (input  wire clk, input  wire rst_n, output wire [1:0] q);

    wire [1:0] t;

    // Toggle logic equations
    assign t[0]  = 1'b1;
    assign t[1]  = q[0];
    
    t_ff ff0 (.clk(clk), .rst_n(rst_n), .t(t[0]), .q(q[0]));
    t_ff ff1 (.clk(clk), .rst_n(rst_n), .t(t[1]), .q(q[1]));

endmodule
