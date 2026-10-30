`timescale 1ns / 1ps

module bdc12to16bit(input  wire clk, input  wire rst, input wire en, input  wire [11:0] binary, output reg  [15:0] bcd, output reg rdy);

    // State Encoding
    localparam IDLE  = 3'd0;
    localparam SETUP = 3'd1;
    localparam ADD   = 3'd2;
    localparam SHIFT = 3'd3;
    localparam DONE  = 3'd4;

    reg [2:0]  state;
    reg [27:0] bcd_data;     // [27:24]=Thousands, [23:20]=Hundreds, [19:16]=Tens, [15:12]=Ones, [11:0]=Binary
    reg [3:0]  sh_counter;   // Counts up to 12 shifts
    reg [1:0]  add_counter;  // Cycles through 4 BCD digits (0 to 3)

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state       <= IDLE;
            bcd_data    <= 28'b0;
            sh_counter  <= 4'd0;
            add_counter <= 2'd0;
            rdy         <= 1'b0;
            bcd         <= 16'b0;
        end else begin
            case (state)
                IDLE: begin
                    rdy <= 1'b0;
                    if (en) begin
                        state <= SETUP;
                    end
                end

                SETUP: begin
                    bcd_data    <= {16'b0, binary};
                    sh_counter  <= 4'd0;
                    add_counter <= 2'd0;
                    rdy         <= 1'b0;
                    state       <= ADD;
                end

                ADD: begin
                    // Check each BCD digit sequentially; if > 4, add 3
                    case (add_counter)
                        2'd0: begin
                            if (bcd_data[15:12] > 4)
                                bcd_data[15:12] <= bcd_data[15:12] + 4'd3;
                            add_counter <= add_counter + 1'b1;
                        end
                        2'd1: begin
                            if (bcd_data[19:16] > 4)
                                bcd_data[19:16] <= bcd_data[19:16] + 4'd3;
                            add_counter <= add_counter + 1'b1;
                        end
                        2'd2: begin
                            if (bcd_data[23:20] > 4)
                                bcd_data[23:20] <= bcd_data[23:20] + 4'd3;
                            add_counter <= add_counter + 1'b1;
                        end
                        2'd3: begin
                            if (bcd_data[27:24] > 4)
                                bcd_data[27:24] <= bcd_data[27:24] + 4'd3;
                            add_counter <= 2'd0;
                            state       <= SHIFT;
                        end
                    endcase
                end

                SHIFT: begin
                    bcd_data   <= bcd_data << 1;     // Shift entire register left by 1
                    sh_counter <= sh_counter + 1'b1;

                    if (sh_counter == 4'd11) begin   // 12 shifts complete (0 through 11)
                        state <= DONE;
                    end else begin
                        state <= ADD;
                    end
                end

                DONE: begin
                    rdy   <= 1'b1;
                    bcd   <= bcd_data[27:12];        // Extract final 16-bit BCD result
                    state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
