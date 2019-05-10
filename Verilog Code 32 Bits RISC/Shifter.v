`timescale 1ns / 1ps

module Shifter(
    output reg [31:0] DOut,
    input signed [31:0] D1,
    input [31:0] D2,
    input SLI,
    input SRI
    );
    wire [1:0] shift = {SLI, SRI};
    always@(*)
    begin
        case(shift)
        2'b01: DOut <= D1 >>> D2;
        2'b10: DOut <= D1 << D2;
        endcase
    end
endmodule
