`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2017 05:33:32 PM
// Design Name: 
// Module Name: mux2to1_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux2to1_test;
    reg[31:0] D0, D1, D2;
    reg sel;
    reg [1:0] select;
    wire[31:0] Data0, Data1;
    mux2to1 mux(.Data(Data0),
                .D0(D1),
                .D1(D2),
                .sel(sel));
    mux3to1 Mux(.Data(Data1),
                .D0(D0),
                .D1(D1),
                .D2(D2),
                .sel(select));
    initial
    begin
        D0 = 32'h5678; D1 = 32'h1234; D2 = 32'hcdef; sel = 0; select = 2'b00;
    #1                                               sel = 1; select = 2'b01;
    #2                                               sel = 0; select = 2'b10;
    #1                                                        select = 2'b11;
    end
endmodule
