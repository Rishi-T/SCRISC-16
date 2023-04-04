`timescale 1ns / 1ps

module btwor_16b#(parameter N=16)(
    output [N-1:0] out,
    input [N-1:0] x,
    input [N-1:0] y
    );

assign out = x | y;
    
endmodule