`timescale 1ns / 1ps



module IMemory(AIn, DOut);
input [31:0] AIn;
output reg [31:0] DOut;
reg [31:0] instrMemory [31:0];

initial
    begin
    instrMemory[0] = 32'h10010064; //load r0, r1, 100
    instrMemory[1] = 32'h4c1e0001; //addi r0, r30, 1
    instrMemory[2] = 32'h00000000; //nop
    instrMemory[3] = 32'h00000000; //nop
    instrMemory[4] = 32'h44220001; //sli r1, r2, 1
    instrMemory[5] = 32'h00000000; //nop
    instrMemory[6] = 32'h00000000; //nop
    instrMemory[7] = 32'h00000000; //nop
    instrMemory[8] = 32'h04221800; //add r1, r2, r3
    instrMemory[9] = 32'h48240001; //sri r1, r4, 1
    instrMemory[10] = 32'h583e0005; //bra r1, r30, 5
    instrMemory[11] = 32'h6001d000; //mulf r0, r1, r26
    instrMemory[12] = 32'h0c4000c8; //store r2, r0, 200
    instrMemory[13] = 32'h4c650001; //addi r3, r5, 1
    instrMemory[14] = 32'h50860001; //subi r4, r6, 1
    instrMemory[15] = 32'h54000015; //jump 21
    instrMemory[16] = 32'h00000000; //nop
    instrMemory[17] = 32'h50650001; //store r2, r0, 200
    instrMemory[18] = 32'h46860001; //addi r3, r5, 1
    instrMemory[19] = 32'h00000000; //subi r4, r6, 1
    instrMemory[20] = 32'h00000000; //nop
    instrMemory[21] = 32'h0ca000c9; //store r5, r0, 201
    instrMemory[22] = 32'h0cc000ca; //store r6, r0, 202
    instrMemory[23] = 32'h00000000; //nop
    instrMemory[24] = 32'h00000000; //nop
    instrMemory[25] = 32'h00000000; //nop
    instrMemory[26] = 32'h00000000; //nop
    end
always @ (*)
begin   
    DOut = instrMemory [AIn];
end
endmodule
