`timescale 1ns / 1ps

module InstructionRegister(
    output reg[5:0] OPC,
    output reg[4:0] RS_RS1,
    output reg[4:0] RD_RS2,
    output reg[4:0] RD,
    output reg[25:0] Imm_J,     // immediate value for jump
    output reg[15:0] Imm_AB,    // immediate value for ALU or branch
    input [31:0] Data,
    input clk
    );
    always@(posedge clk)
    begin
        OPC <= Data[31:26];
        RS_RS1 <= Data[25:21];
        RD_RS2 <= Data[20:16];
        RD <= Data[15:11];
        Imm_J <= Data[25:0];
        Imm_AB <= Data[15:0];
    end
endmodule
