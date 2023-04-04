`timescale 1ns / 1ps

module CLA_4b(
    output [3:0] s,
    output co,
    input [3:0] a,
    input [3:0] b,
    input cin
    );
    
    wire [3:0] p,g;
    wire [2:0] c;
    
    assign p = a ^ b;
    assign g = a & b;
    
    assign c[0] = g[0] | (p[0]&cin);
    assign c[1] = g[1] | (p[1]&g[0]) | (p[1]&p[0]&cin);
    assign c[2] = g[2] | (p[2]&g[1]) | (p[2]&p[1]&g[0]) | (p[2]&p[1]&p[0]&cin);
    assign co = g[3] | (p[3]&g[2]) | (p[3]&p[2]&g[1]) | (p[3]&p[2]&p[1]&g[0]) | (p[3]&p[2]&p[1]&p[0]&cin);
    
    xor x5(s[0],p[0],cin);
    xor x6(s[1],p[1],c[0]);
    xor x7(s[2],p[2],c[1]);
    xor x8(s[3],p[3],c[2]);
    
endmodule