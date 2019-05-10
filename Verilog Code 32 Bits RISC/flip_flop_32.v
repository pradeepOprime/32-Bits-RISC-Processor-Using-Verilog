`timescale 1ns / 1ps

module flip_flop_32(
    output reg[31:0] Q,
    input [31:0] D,
    input clk
    );
    always@(posedge clk)
    begin
        Q = D;
    end
endmodule
