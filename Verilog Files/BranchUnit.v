`timescale 1ns / 1ps
module BranchUnit(
    output check,
    input [1:0] ALUB,
    input Unsig,
    input msba,
    input msbb,
    input msbout,
    input cout,
    input zero
    );
    
    wire overflow,blt,set0,set1;
    
    assign overflow = (~msba | msbb | cout) | (msba | ~msbb | ~cout);
    assign blt = overflow ^ msbout;
    
    assign set0 = Unsig ? cout : blt;
    assign set1 = ALUB[1] ? set0 : zero;
    assign check = ALUB[0] ^ set1;
    
endmodule
