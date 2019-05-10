`timescale 1ns / 1ps
module PC(
    output reg[31:0] Count,
    input [31:0] Jump,
    input [31:0] Branch,
    input sel_j,
    input sel_b,
    input clk,
    input reset
    );
    wire [1:0] sel = {sel_j, sel_b};
    always@(posedge clk, posedge reset)
    begin
        if (reset)
            Count <= 0;  // start the program from the beginning
        else
            begin
                casex(sel)
                2'b00:  Count <= Count + 1; // regular proceed
                2'bx1:  Count <= Branch;    // next PC branch
                2'b10:  Count <= Jump;      // next PC jump
                default:    Count <= Count + 1;
                endcase
            end
    end
endmodule
