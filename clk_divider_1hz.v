
module clk_divider_1hz (input  wire clk_in, input  wire rst_n, output wire clk_out);

    wire q0, q1, q2, q3, q4;

    
    clk_divider_quarter cd0 (.clk_in(clk_in), .rst_n(rst_n), .clk_out(q0));
    clk_divider_quarter cd1 (.clk_in(q0),     .rst_n(rst_n), .clk_out(q1));
    clk_divider_quarter cd2 (.clk_in(q1),     .rst_n(rst_n), .clk_out(q2));
    clk_divider_quarter cd3 (.clk_in(q2),     .rst_n(rst_n), .clk_out(q3));
    clk_divider_quarter cd4 (.clk_in(q3),     .rst_n(rst_n), .clk_out(q4));
    clk_divider_quarter cd5 (.clk_in(q4),     .rst_n(rst_n), .clk_out(clk_out));
    

endmodule
