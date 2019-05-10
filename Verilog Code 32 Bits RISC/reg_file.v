`timescale 1ns / 1ps

module registerFile(
    output reg[31:0] DOut1,
    output reg[31:0] DOut2,
    input [4:0] AIn1,
    input [4:0] AIn2,
    input [4:0] AIn3,
    input [31:0] DIn
    );
    reg [31:0] rf [31:0];
    
    always@(*)
    begin
        DOut1 <= rf[AIn1];
        DOut2 <= rf[AIn2];
        rf[AIn3] <= (AIn3) ? DIn : 0; //to handle rf[0] is always 0
    end
endmodule
