`timescale 1ns / 1ps

module flip_flop_5(
    output reg[4:0] Q,
    input [4:0] D,
    input clk
    );
    always@(posedge clk)
    begin
        Q = D;
    end
endmodule
