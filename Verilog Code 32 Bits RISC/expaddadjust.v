`timescale 1ns / 1ps

module expaddadjust(
input [7:0] exp,
input [5:0] adjust,
input zero,
output reg [7:0] finalexp
    );
always @ (*)
    begin
        if (zero)
            begin
                finalexp <= 8'b0;
            end
        else
            begin
                if(adjust[5])
                    begin
                    finalexp <= exp - {4'b0,adjust[4:0]};
                    end
                else
                    begin
                    finalexp <= exp + {4'b0,adjust[4:0]};    
                    end
            end    
    end
endmodule
