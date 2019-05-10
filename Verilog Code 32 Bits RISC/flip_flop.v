`timescale 1ns / 1ps

module flip_flop #(parameter WIDTH = 32)
    (input [WIDTH-1:0] d,
    input clk, reset,
    output reg [WIDTH-1:0] q);
    
    always @ (posedge clk, posedge reset)
        begin
        if (reset == 1)
            begin
            q <= 0;
            end
        else
            begin    
            q <= d;
            end
        end
endmodule
