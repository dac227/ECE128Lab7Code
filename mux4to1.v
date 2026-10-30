
module mux4to1(input [15:0] bdcInput, [3:0] decoderInput, output reg [3:0] anodeOutput);

    always @(*) begin
        case(decoderInput)
            4'b1110: anodeOutput = bdcInput[3:0];
            4'b1101: anodeOutput = bdcInput[7:4];
            4'b1011: anodeOutput = bdcInput [11:8];
            4'b0111: anodeOutput = bdcInput [15:12];
        endcase
    end
endmodule
