`timescale 1ns / 1ps

module btwnot_16b#(parameter N=16)(
    output [N-1:0] out,
    input [N-1:0] x
    );

assign out = ~x;
    
endmodule