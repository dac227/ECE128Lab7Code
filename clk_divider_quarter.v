module clk_divider_quarter (
    input  wire clk_in,
    input  wire rst_n,
    output wire clk_out
);

    wire q0, q1, q2;

    // 4 cascaded T flip-flops (divides frequency by 2^4 = 16)
    t_ff ff0 (.clk(clk_in), .rst_n(rst_n), .t(1'b1), .q(q0));
    t_ff ff1 (.clk(q0),     .rst_n(rst_n), .t(1'b1), .q(q1));
    t_ff ff2 (.clk(q1),     .rst_n(rst_n), .t(1'b1), .q(q2));
    t_ff ff3 (.clk(q2),     .rst_n(rst_n), .t(1'b1), .q(clk_out));

endmodule
