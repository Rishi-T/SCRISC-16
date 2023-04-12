`timescale 1ns / 1ps

module ALUControl(
    output [3:0] ALUC,
    input [1:0] ALUOp,
    input [4:0] funct5
    );
    
    wire [3:0] ALUC0, ALUC1, ALUCprev;
    
    assign ALUC0 = {ALUOp[1] | ALUOp[0], ALUC0[3], 1'b0, ~ALUOp[0]};
    
    penc_2b encoder(ALUC1[3:2],funct5[4:2]);
    assign ALUC1[1:0] = {funct5[1],funct5[0]};
    
    assign ALUCprev = &ALUOp ? ALUC1 : ALUC0;
    assign ALUC = ~|(ALUOp) ? 4'b0000 : ALUCprev;
     
endmodule