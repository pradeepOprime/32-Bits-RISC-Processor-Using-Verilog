`timescale 1ns / 1ps


module normalizeadd(
input [24:0] in,
output reg [5:0] shift,
output reg [22:0] out,
output reg zero
    );

integer n = 0;
integer i = 0;
reg [24:0] preshift;
always @ (in)
begin
    if (in == 0)
        begin
            zero = 1;
            out = in [22:0];
        end
    
    else
        begin //need separate case to handle any needed shift right
        zero = 0;
        if (in[24])
            begin
                shift = -1;
                preshift = in >> 1;
                out = preshift[22:0];
            end
        else if (in[23])
            begin
                shift = 0;
                out = in [22:0];
            end    
        else
            begin
                for (i = 0; i <23; i = i + 1)
                    begin
                    if (in[i])
                        begin
                        shift = 23-i;
                        end
                    end
                    preshift = in << shift;
                    out = preshift[22:0];
            end    
        end    
end      
endmodule
