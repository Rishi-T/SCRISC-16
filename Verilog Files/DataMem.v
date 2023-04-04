`timescale 1ns / 1ps

module DataMem(
    output reg [15:0] ReadData,
    input [15:0] Address,
    input [15:0] WriteData,
    input MemRead,
    input MemWrite,
    input clk,
    input reset
    );
    
    reg [7:0] mem [63:0]; //byte addressable memory with 40 locations
    
    always@(MemRead, Address)
    begin
    if(MemRead)
        ReadData = {mem[Address+1], mem[Address]};
    end
    
    always@(negedge clk, posedge reset)
    begin
    if(reset)
        $readmemh("DataMemory.mem",mem);
    else if (MemWrite)
        begin
        mem[Address] <= WriteData[7:0];
        mem[Address+1] <= WriteData[15:8];
        $writememh("DataMemoryOut.mem", mem);
        end
    end
endmodule
