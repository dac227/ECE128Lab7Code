`timescale 1ns / 1ps

module top (
    input  wire       clk,   // 100 MHz Basys 3 clock
    input  wire       rst,   // Active-HIGH reset from SW0
    output wire [6:0] seg,   // 7-segment cathodes
    output wire [3:0] an    // 4-digit active-LOW anodes (ADDED)
);

    // Invert active-HIGH switch input to active-LOW for submodules
    wire rst_n = ~rst;

    // Internal Wires
    wire        slowClock;
    wire        ready;
    wire [11:0] value;
    wire [15:0] convertedValue;
    wire [1:0]  smallCounterVal;
    wire [3:0]  muxOutput;

    // --- Display Refresh Clock Generator (~763 Hz) ---
    reg [16:0] refresh_counter;
    always @(posedge clk or posedge rst) begin
        if (rst) refresh_counter <= 17'd0;
        else     refresh_counter <= refresh_counter + 1'b1;
    end
    wire refresh_clk = refresh_counter[16];

    // 1. Clock Divider for Counter (1 Hz)
    clk_divider_1hz divider (
        .clk_in (clk),
        .rst_n  (rst_n),
        .clk_out(slowClock)
    );

    // 2. 12-Bit Binary Counter
    counter_12bit slowCounter (
        .clk  (slowClock),
        .rst_n(rst_n),
        .q    (value)
    );

    // 3. Binary-to-BCD Converter (Rename to 'Bin2BCD' if that is your module name)
    bdc12to16bit converter (
        .clk   (clk),
        .rst   (rst),
        .en    (1'b1),
        .binary(value),
        .bcd   (convertedValue),
        .rdy   (ready)
    );

    // 4. Fast Multiplexing Counter (Driven by ~763 Hz refresh clock)
    smallCounter fastCounter (
        .clk  (refresh_clk),
        .rst_n(rst_n),
        .q    (smallCounterVal)
    );

    // 5. 2-to-4 Anode Decoder (Drives top-level 'an' pins directly)
    decoder2to4 dec24 (
        .in (smallCounterVal),
        .out(an)
    );

    // 6. 4-to-1 Multiplexer (Selects active BCD digit using active-low anode state)
    mux4to1 mux (
        .bdcInput    (convertedValue),
        .decoderInput(an),
        .anodeOutput (muxOutput)
    );

    // 7. 7-Segment Decoder
    bcd_7seg_decoder decoder7seg (
        .bcd(muxOutput),
        .seg(seg)
    );

endmodule

