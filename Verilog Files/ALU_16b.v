`timescale 1ns / 1ps

module ALU_16b(
    output [15:0] out,
    output check,
    input [15:0] a,
    input [15:0] b,
    input [3:0] ALUC,
    input [2:0] ALUB
    );
    
    wire [15:0] dA0,dA1,dB0,dB1,A0,A1,A2,A3,B0,B1,B2,B3,m1,m2;
    wire [15:0] o0,o1,o2,o3;
    wire [15:0] binp;
    wire cout,zero;
    
    assign binp = B3 ^ {16{ALUC[0]}};
    
    demux_1x2_16b dmux1(dA0,dA1,a,ALUC[3]);
    demux_1x2_16b dmux2(A0,A1,dA0,ALUC[2]);
    demux_1x2_16b dmux3(A2,A3,dA1,ALUC[2]);
    
    demux_1x2_16b dmux4(dB0,dB1,b,ALUC[3]);
    demux_1x2_16b dmux5(B0,B1,dB0,ALUC[2]);
    demux_1x2_16b dmux6(B2,B3,dB1,ALUC[2]);
    
    assign o0 = 16'h0000;
    bar_shift_16b bsh(o1,A1,B1,ALUC[1],ALUC[0]);
    bitwise_16b bw(o2,A2,B2,ALUC[1:0]);
    CCLA_16b cla(o3,cout,A3,B3,ALUC[0]);
    
    assign zero = ~|(a ^ b);
    BranchUnit branch(check,ALUB,a[15],b[15],o3[15],cout,zero);
    
    mux_2x1_16b mux1(m1,o0,o1,ALUC[2]);
    mux_2x1_16b mux2(m2,o2,o3,ALUC[2]);
    mux_2x1_16b mux3(out,m1,m2,ALUC[3]);
    
endmodule