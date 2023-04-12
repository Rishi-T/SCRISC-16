`timescale 1ns / 1ps

module CCLA_16b(
    output [15:0] s,
    output co,
    input [15:0] a,
    input [15:0] b,
    input cin
    );
    
    wire [3:0] c;
    
    CLA_4b u1(s[3:0],c[0],a[3:0],b[3:0],cin);
    CLA_4b u2(s[7:4],c[1],a[7:4],b[7:4],c[0]);
    CLA_4b u3(s[11:8],c[2],a[11:8],b[11:8],c[1]);
    CLA_4b u4(s[15:12],c[3],a[15:12],b[15:12],c[2]);
    
    assign co = c[3] ^ cin;
endmodule
