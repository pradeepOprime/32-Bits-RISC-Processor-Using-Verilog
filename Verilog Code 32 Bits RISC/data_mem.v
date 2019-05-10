`timescale 1ns / 1ps

module dataMemory(
    output reg [31:0] DOut,
    input [31:0] AIn,
    input [31:0] DIn,
    input WE);
    reg[31:0] dmemory [255:0];
    
    initial
        begin
        dmemory[100] = 32'h00000008; // Initial value 8
        end
    always@(WE, AIn)
    begin   
            if (WE == 1)
                dmemory[AIn] <= DIn;
            else
                DOut <= dmemory[AIn];
    end
endmodule
