`timescale 1ns / 1ps

module tb_bdc12to16bit;

    reg clk;
    reg rst;
    reg en;
    reg [11:0] binary;
    
    wire [15:0] bcd;
    wire rdy;

    // Instantiate the converter
    bdc12to16bit uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .binary(binary),
        .bcd(bcd),
        .rdy(rdy)
    );

    // 100 MHz clock (10 ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        en = 0;
        binary = 0;

        // Hold reset, then release
        #20;
        rst = 0;
        #20;

        // --- Test 1: Convert 189 ---
        binary = 12'd189;
        en = 1;
        #10 en = 0;
        
        @(posedge rdy); // Wait for conversion to finish
        #10;
        $display("Time: %0t | Binary: %d -> BCD: %h (Expected: 0189)", $time, binary, bcd);

        // --- Test 2: Convert Maximum Value 4095 ---
        #50;
        binary = 12'd4095;
        en = 1;
        #10 en = 0;
        
        @(posedge rdy);
        #10;
        $display("Time: %0t | Binary: %d -> BCD: %h (Expected: 4095)", $time, binary, bcd);

        // --- Test 3: Convert 2026 ---
        #50;
        binary = 12'd2026;
        en = 1;
        #10 en = 0;
        
        @(posedge rdy);
        #10;
        $display("Time: %0t | Binary: %d -> BCD: %h (Expected: 2026)", $time, binary, bcd);

        #100;
        $finish;
    end

endmodule
