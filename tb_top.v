`timescale 1ns / 1ps

module tb_top;

    reg clk;
    reg rst;
    
    wire [6:0] seg;
    wire [3:0] an;

    // Instantiate Top Module
    top uut (
        .clk(clk),
        .rst(rst),
        .seg(seg),
        .an(an)
    );

    // 100 MHz System Clock (10 ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1; // Active-HIGH reset for SW0

        // Hold Reset for 100ns
        #100;
        rst = 0;

        // Monitor digit scanning in Vivado console
        $monitor("Time: %0t ns | rst: %b | an (Anodes): %b | seg (Cathodes): %b", 
                 $time, rst, an, seg);

        // Run simulation for 500,000 ns to observe anode multiplexing
        #500000;
        
        $display("Simulation finished. Check waveform for multiplexer toggling.");
        $finish;
    end

endmodule



