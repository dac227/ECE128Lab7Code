
module counter_12bit (input  wire clk, input  wire rst_n, output wire [11:0] q);

    wire [11:0] t;

    // Toggle logic equations
    assign t[0]  = 1'b1;
    assign t[1]  = q[0];
    assign t[2]  = t[1]  & q[1];
    assign t[3]  = t[2]  & q[2];
    assign t[4]  = t[3]  & q[3];
    assign t[5]  = t[4]  & q[4];
    assign t[6]  = t[5]  & q[5];
    assign t[7]  = t[6]  & q[6];
    assign t[8]  = t[7]  & q[7];
    assign t[9]  = t[8]  & q[8];
    assign t[10] = t[9]  & q[9];
    assign t[11] = t[10] & q[10];
    
    t_ff ff0 (.clk(clk), .rst_n(rst_n), .t(t[0]), .q(q[0]));
    t_ff ff1 (.clk(clk), .rst_n(rst_n), .t(t[1]), .q(q[1]));
    t_ff ff2 (.clk(clk), .rst_n(rst_n), .t(t[2]), .q(q[2]));
    t_ff ff3 (.clk(clk), .rst_n(rst_n), .t(t[3]), .q(q[3]));
    t_ff ff4 (.clk(clk), .rst_n(rst_n), .t(t[4]), .q(q[4]));
    t_ff ff5 (.clk(clk), .rst_n(rst_n), .t(t[5]), .q(q[5]));
    t_ff ff6 (.clk(clk), .rst_n(rst_n), .t(t[6]), .q(q[6]));
    t_ff ff7 (.clk(clk), .rst_n(rst_n), .t(t[7]), .q(q[7]));
    t_ff ff8 (.clk(clk), .rst_n(rst_n), .t(t[8]), .q(q[8]));
    t_ff ff9 (.clk(clk), .rst_n(rst_n), .t(t[9]), .q(q[9]));
    t_ff ff10 (.clk(clk), .rst_n(rst_n), .t(t[10]), .q(q[10]));
    t_ff ff11 (.clk(clk), .rst_n(rst_n), .t(t[11]), .q(q[11]));

endmodule
