`timescale 1ns / 1ps

module penc_2b(
    output [1:0] out,
    input [2:0] in
    );
    
    assign out[0] = in[2] | in[0];
    assign out[1] = in[2] | in[1];
    
endmodule
