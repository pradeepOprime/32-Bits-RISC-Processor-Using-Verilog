`timescale 1ns / 1ps

module mux3to1(
    output reg[31:0] Data,
    input [31:0] D0,
    input [31:0] D1,
    input [31:0] D2,
    input [1:0] sel
    );
    always@(*)
    begin
    case(sel)
    2'b00: Data <= D0;
    2'b01: Data <= D1;
    2'b10: Data <= D2;
    2'b11: Data <= 32'b0;
    endcase
    end
endmodule
