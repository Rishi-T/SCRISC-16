`timescale 1ns / 1ps

module mux_2x1_16b#(parameter N=16)(
    output [N-1 : 0] out,
    input [N-1 : 0] in0,
    input [N-1 : 0] in1,
    input sel
    );
    
    assign out  = sel ? in1 : in0;
    
endmodule
