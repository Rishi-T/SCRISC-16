`timescale 1ns / 1ps

module RegisterFile(
    output [15:0] Rd_dat_1,
    output [15:0] Rd_dat_2,
    input [31:0] WriteData,
    input [1:0] Rd_1,
    input [1:0] Rd_2,
    input [1:0] Wr,
    input RegWrite,
    input clk,
    input reset
    );
    
    reg [15:0] Register [3:0];
    
    always@(posedge reset)
    begin
        $readmemh("RegisterValues.mem",Register);
    end
    
    always@(negedge clk)
    begin
    if (RegWrite)
        Register[Wr] <= WriteData;
    end
    
    assign Rd_dat_1 = Register[Rd_1];
    assign Rd_dat_2 = Register[Rd_2];
endmodule
