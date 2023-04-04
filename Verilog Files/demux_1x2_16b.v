`timescale 1ns / 1ps

module demux_1x2_16b#(parameter N=16)(
    output [N-1:0] out0,
    output [N-1:0] out1,
    input [N-1:0] in,
    input sel
    );
    
    assign out0 = in & {N{~sel}};
    assign out1 = in & {N{sel}};
endmodule
