`timescale 1ns / 1ps
module BranchUnit(
    output check,
    input [2:0] ALUB,
    input msba,
    input msbb,
    input msbout,
    input cout,
    input zero
    );
    
    wire overflow,blt,set0,set1;
    
    assign overflow = (~msba | msbb | cout) | (msba | ~msbb | ~cout);
    assign blt = overflow ^ msbout;
    
    assign set0 = ALUB[0] ? cout : blt;
    assign set1 = ALUB[2] ? set0 : zero;
    assign check = ALUB[1] ^ set1;
    
endmodule
