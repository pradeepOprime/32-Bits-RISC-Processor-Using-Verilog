`timescale 1ns / 1ps

module FloatAdder(
input [31:0] num1, num2,
output [31:0] sum);

wire sign, s, zero;
wire [7:0] dexp, baseexp;
wire [22:0] preshiftlower, higher;
wire [23:0] shiftedlower, prenormsum;
wire [5:0] shift;

floatcmp FC(.num1(num1), .num2(num2),
.sign(sign), .s(s),
.dexp(dexp));

floatmux #8 MUXEXP (.in0(num1[30:23]), .in1(num2[30:23]), .out(baseexp), .sel(s));
floatmux #23 LOWER (.in0(num2[22:0]), .in1(num1[22:0]), .out(preshiftlower), .sel(s));
floatmux #23 UPPER (.in0(num2[22:0]), .in1(num1[22:0]), .out(higher), .sel(~s));
floatmux #1 SIGN (.in0(num1[31]), .in1(num2[31]), .out(sum[31]), .sel(s));

floatshift FS (.in ({1'b1, preshiftlower}), .shift(dexp), .out(shiftedlower));
floatcalcadd FCA (.larger({1'b1, higher}), .smaller(shiftedlower), .parity(~(num1[31]^num2[31])), .sum(prenormsum));
//XNOR to check to see if they're equal in positive/negative

normalizeadd NA(.in(prenormsum), .shift(shift), .out(sum[22:0]), .zero(zero));
expaddadjust EA(.exp(baseexp), .adjust(shift), .zero(zero), .finalexp(sum[30:23]));



/*floatcmp F1 (.num1(num1 [30:23]), .num2(num2 [30:23]), .sign(sign), .dexp(dexp)); 
floatmux8 M81 (.in0(num1 [30:23]), .in1(num1 [30:23]), .sel(sign), .out(mux8out));
floatmux24 M241 (.in0({num1[31], num1[22:0]}), .in1({num2[31], num2[22:0]}), .sel(sign), .out(preshiftsmall));
floatmux24 M242 (.in0({num1[31], num1[22:0]}), .in1({num2[31], num2[22:0]}), .sel(~sign), .out(bigfrac));
floatshift FS1 (.in(preshiftsmall), .shift(dexp), .out(smallfrac));
floatcalcadd FCA (.larger(bigfrac[22:0]), .smaller(smallfrac[22:0]), .lsign(bigfrac[23]), .ssign(smallfrac[23]), .sign(prenormsign), .sum(prenormsum));
normalizeadd NA (.in(prenormsum), .shift(shift), .out(sum[22:0]), .zero(zero), .sign(sum[31]));
expaddadjust EAA (.exp(mux8out), .adjust(shift), .zero(zero), .finalexp(sum[30:23]));*/

endmodule
