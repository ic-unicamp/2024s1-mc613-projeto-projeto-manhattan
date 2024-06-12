module screen (       
    input clk,
	input reset,         
    input VGA_CLK,  
    input ativo,  
	input interword,
    input interchar,
    input [6:0] code,  
    input [10:0] sx,
    input [10:0] sy,
    output [7:0] VGA_R,
    output [7:0] VGA_G,
    output [7:0] VGA_B,
    output reg [4:0] area_index,
    output reg [0:255] data
);

parameter LA = 256'b0_0_0_0_0_0_0_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_1_1_1_1_1_1_0_0_1_1_1_1_1_1_0_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1;
parameter LB = 256'b1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_0_1_1_1_0_0_0_0_0_0_0_0_1_1_1_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_1_1_1_0_0_0_0_0_0_0_0_1_1_1_0_0_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_0_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0;
parameter LC = 256'b1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1;
parameter LD = 256'b1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_1_1_1_1_0_0_0_0_0_0_0_1_1_1_1_0_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_0_1_1_1_1_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_1_1_1_1_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0;
parameter LE = 256'b1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1;
parameter LF = 256'b1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0;
parameter LG = 256'b1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1;
parameter LH = 256'b1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1;
parameter LI = 256'b1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1;
parameter LJ = 256'b1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_1_1_1_0_0_0_1_1_1_1_0_0_0_0_0_0_1_1_1_0_0_0_1_1_1_1_0_0_0_0_0_0_1_1_1_0_0_0_1_1_1_1_0_0_0_0_0_0_1_1_1_0_0_0_1_1_1_1_0_0_0_0_0_0_1_1_1_0_0_0_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0;
parameter LK = 256'b1_1_1_1_1_0_0_0_0_0_1_0_0_0_0_0_1_1_1_1_1_0_0_0_0_1_1_0_0_0_0_0_1_1_1_1_1_0_0_0_1_1_1_0_0_0_0_0_1_1_1_1_1_0_0_1_1_1_1_0_0_0_0_0_1_1_1_1_1_0_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_0_0_1_1_1_1_0_0_0_0_0_1_1_1_1_1_0_0_0_1_1_1_1_0_0_0_0_1_1_1_1_1_0_0_0_0_1_1_1_1_0_0_0_1_1_1_1_1_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1;
parameter LL = 256'b1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1;
parameter LM = 256'b1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_1_1_1_1_1_1_0_1_1_1_1_1_1_1_1_0_0_1_1_1_1_0_0_1_1_1_1_1_1_1_1_0_0_0_1_1_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1;
parameter LN = 256'b1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_1_1_1_1_1_1_1_0_1_1_1_1_0_0_0_0_1_1_1_1_1_1_1_0_0_1_1_1_1_0_0_0_1_1_1_1_1_1_1_0_0_0_1_1_1_1_0_0_1_1_1_1_1_1_1_0_0_0_1_1_1_1_0_0_1_1_1_1_1_1_1_0_0_0_0_1_1_1_1_0_1_1_1_1_1_1_1_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_1_1_1;
parameter LO = 256'b0_0_0_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_1_1_1_1_1_1_1_1_0_0_0_0;
parameter LP = 256'b1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0;
parameter LQ = 256'b0011111111111000011111111111110011111111111111101111100000011110111100000000011011100000000001101110000000000110111000000000011011100000000001101110000001100110111000000111011011100000001111101110000000001110111100000001111001111111111111110011111111110011;
parameter LR = 256'b1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_1_1_1_1_1_0_0_1_1_1_0_0_0_0_0_0_1_1_1_1_1_0_0_0_1_1_1_0_0_0_0_0_1_1_1_1_1_0_0_0_0_1_1_1_0_0_0_0_1_1_1_1_1_0_0_0_0_0_1_1_1_0_0_0_1_1_1_1_1_0_0_0_0_0_0_1_1_1_0_0_1_1_1_1_1_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_1_1_1;
parameter LS = 256'b0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_0_0_0_0_0_0_0_0_0_0_0_0_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_1_1_1_1_1_1_1_1_1_1_1_1_1_1_0_0;
parameter LT = 256'b1111111111111111111111111111111111111111111111111111111111111111000000111100000000000011110000000000001111000000000000111100000000000011110000000000001111000000000000111100000000000011110000000000001111000000000000111100000000000011110000000000001111000000;
parameter LU = 256'b1111000000001111111100000000111111110000000011111111000000001111111100000000111111110000000011111111000000001111111100000000111111110000000011111111000000001111111110000001111111111100001111111111111111111111111111111111111101111111111111100011111111111100;
parameter LV = 256'b1000000000000001100000000000000110000000000000011100000000000011110000000000001111100000000001111111000000001111111111000001111101111110001111110011111111111110000111111111110000001111111110000000011111110000000000111110000000000001110000000000000010000000;
parameter LW = 256'b1110000000000111111000000000011111100000000001111110000000000111111000000000011111100000000001111110000000000111111000011000011111100011110001111110011111100111111011111111011111111110011111111111110000111111111110000001111111110000000011111110000000000111;
parameter LX = 256'b1110000000000111111100000000111111111000000111110111110000111110001111100111110000011111111110000000111111110000000001111110000000000111111000000000111111110000000111111111100000111110011111000111110000111110111110000001111111110000000011111110000000000111;
parameter LY = 256'b1110000000000111111100000000111111111000000111110111110000111110001111100111110000011111111110000000111111110000000001111110000000000011110000000000001111000000000000111100000000000011110000000000001111000000000000111100000000000011110000000000000110000000;
parameter LZ = 256'b0111111111111111111111111111111111111111111111110000000000111110000000000111110000000000111110000000000111110000000000111110000000000111110000000000111110000000000111110000000000111110000000000111110000000000111111111111111111111111111111111111111111111110;
parameter N0 = 256'b0011111111111100011110000000011011110000000000111111000000000011111100000000001110110000000000111011000000000011101100000000001110110000000000111011000000000011101110000000001110011000000000111101100000000111111111000000111101111111111111100011111111111100;
parameter N1 = 256'b0000001111000000000001111100000000001111110000000001111111000000001110111100000001110011110000001110001111000000110000111100000000000011110000000000001111000000000000111100000000000011110000000000001111000000000111111111100001111111111111101111111111111111;
parameter N2 = 256'b0000111111110000000111111111100000111100001111000111100000011110111100000001101011100000001100100100000001100010000000001110010000000001110111000000001111110000000001111100000000001111100000000001111000000000001111000000000001111111111111110111111111111111;
parameter N3 = 256'b0111111111111100111111111111111011000000000011110000000000000111000000000000111000000000000111000000000000111000000000000111000001100000011110000110000000111100111000000001111011100000000011101111000000001110011110000001111001111111111111000001111111111000;
parameter N4 = 256'b1110000000000111111000000000011111100000000001111110000000000111111000000000011111100000000001111110000000000111111000000000011111111111111111111111111111111111011111111111111100000000000001110000000000000111000000000000011100000000000001110000000000000111;
parameter N5 = 256'b1111111111111111111111111111111111111111111111111110000000000000111000000000000011100000000000001110000000000000111111111111100001111111111111000000000000011110000000000000111111000000000001111110000000000111111111111111111111111111111111100011111111111100;
parameter N6 = 256'b0111111111111110111111111111111111111111111111101111000000000000111000000000000011100000000000001110000000000000111000000000000011111111111111101111111111111111111111111111111111110000000001111110000000000011111100000000011111111111111111110111111111111110;
parameter N7 = 256'b1111111111111111111111111111110111111111111110010000000000010001000000000001011000011100011111000001111011111000000111111111000000001111111000000000011111000000000011111110000000011111111100000011111001111000011111100011100011111000000000001110000000000000;
parameter N8 = 256'b0011111111111110011111111111111111110000000001111110000000000011111000000000001111110000000000111111111111111111111111111111111111111111111111111111000000000111111000000000001111100000000000111110000000000011111100000000011101111111111111110011111111111110;
parameter N9 = 256'b0001111111111110011111111111111111111000000111111111000000000111111000000000001111100000000000111110000011111111111110111111111101111111100001110111111000000011000000000000001100000000000000110111000000000011010110000000111101101111111110110011111111111111;



always @(posedge clk) begin
    if (reset) begin
        data = 0;
    end else begin
        case (code)
            1: begin // E
                data = LE;
            end
            2: begin // T
                data = LT;
            end
            3: begin // I
                data = LI;
            end
            4: begin // A
                data = LA;
            end
            5: begin // N
                data = LN;
            end
            6: begin // M
                data = LM;
            end
            7: begin // S
                data = LS;
            end
            8: begin // U
                data = LU;
            end
            9: begin // R
                data = LR;
            end
            10: begin // W
                data = LW;
            end
            11: begin // D
                data = LD;
            end
            12: begin // K
                data = LK;
            end
            13: begin // G
                data = LG;
            end
            14: begin // O
                data = LO;
            end
            15: begin // H
                data = LH;
            end
            16: begin // V
                data = LV;
            end
            17: begin // F
                data = LF;
            end
            19: begin // L
                data = LL;
            end
            21: begin // P
                data = LP;
            end
            22: begin // J
                data = LJ;
            end
            23: begin // B
                data = LB;
            end
            24: begin // X
                data = LX;
            end
            25: begin // C
                data = LC;
            end
            26: begin // Y
                data = LY;
            end
            27: begin // Z
                data = LZ;
            end
            28: begin // Q
                data = LQ;
            end
            31: begin // 5
                data = N5;
            end
            32: begin // 4
                data = N4;
            end
            34: begin // 3
                data = N3;
            end
            38: begin // 2
                data = N2;
            end
            46: begin // 1
                data = N1;
            end
            47: begin // 6
                data = N6;
            end
            55: begin // 7
                data = N7;
            end
            59: begin // 8
                data = N8;
            end
            61: begin // 9
                data = N9;
            end
            62: begin // 0
                data = N0;
            end
            default: begin
                data = 0;
            end
        endcase
    end
end

reg space;
always @(posedge clk) begin
    if (reset) begin
        area_index = 1;
        space = 0;
        area1 = 0;
        area2 = 0;
        area3 = 0;
        area4 = 0;
        area5 = 0;
        area6 = 0;
        area7 = 0;
        area8 = 0;
        area9 = 0;
        area10 = 0;
        area11 = 0;
        area12 = 0;
        area13 = 0;
        area14 = 0;
        area15 = 0;
        area16 = 0;
        area17 = 0;
        area18 = 0;
        area19 = 0;
        area20 = 0;
        area21 = 0;
        area22 = 0;
        area23 = 0;
        area24 = 0;
        area25 = 0;
        area26 = 0;
        area27 = 0;
        area28 = 0;
        area29 = 0;
        area30 = 0;
    end else begin
        if (area_index == 1) begin
            if (data != 0) begin
                area1 = data;
                if (space) begin
                    area_index = 3; // area_index + 2
                    area2 = 0;
                end else begin
                    area_index = 2; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 2) begin
            if (data != 0) begin
                area2 = data;
                if (space) begin
                    area_index = 4; // area_index + 2
                    area3 = 0;
                end else begin
                    area_index = 3; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 3) begin
            if (data != 0) begin
                area3 = data;
                if (space) begin
                    area_index = 5; // area_index + 2
                    area4 = 0;
                end else begin
                    area_index = 4; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 4) begin
            if (data != 0) begin
                area4 = data;
                if (space) begin
                    area_index = 6; // area_index + 2
                    area5 = 0;
                end else begin
                    area_index = 5; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 5) begin
            if (data != 0) begin
                area5 = data;
                if (space) begin
                    area_index = 7; // area_index + 2
                    area6 = 0;
                end else begin
                    area_index = 6; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 6) begin
            if (data != 0) begin
                area6 = data;
                if (space) begin
                    area_index = 8; // area_index + 2
                    area7 = 0;
                end else begin
                    area_index = 7; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 7) begin
            if (data != 0) begin
                area7 = data;
                if (space) begin
                    area_index = 9; // area_index + 2
                    area8 = 0;
                end else begin
                    area_index = 8; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 8) begin
            if (data != 0) begin
                area8 = data;
                if (space) begin
                    area_index = 10; // area_index + 2
                    area9 = 0;
                end else begin
                    area_index = 9; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 9) begin
            if (data != 0) begin
                area9 = data;
                if (space) begin
                    area_index = 11; // area_index + 2
                    area10 = 0;
                end else begin
                    area_index = 10; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 10) begin
            if (data != 0) begin
                area10 = data;
                if (space) begin
                    area_index = 12; // area_index + 2
                    area11 = 0;
                end else begin
                    area_index = 11; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 11) begin
            if (data != 0) begin
                area11 = data;
                if (space) begin
                    area_index = 13; // area_index + 2
                    area12 = 0;
                end else begin
                    area_index = 12; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 12) begin
            if (data != 0) begin
                area12 = data;
                if (space) begin
                    area_index = 14; // area_index + 2
                    area13 = 0;
                end else begin
                    area_index = 13; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 13) begin
            if (data != 0) begin
                area13 = data;
                if (space) begin
                    area_index = 15; // area_index + 2
                    area14 = 0;
                end else begin
                    area_index = 14; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 14) begin
            if (data != 0) begin
                area14 = data;
                if (space) begin
                    area_index = 16; // area_index + 2
                    area15 = 0;
                end else begin
                    area_index = 15; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 15) begin
            if (data != 0) begin
                area15 = data;
                if (space) begin
                    area_index = 17; // area_index + 2
                    area16 = 0;
                end else begin
                    area_index = 16; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 16) begin
            if (data != 0) begin
                area16 = data;
                if (space) begin
                    area_index = 18; // area_index + 2
                    area17 = 0;
                end else begin
                    area_index = 17; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 17) begin
            if (data != 0) begin
                area17 = data;
                if (space) begin
                    area_index = 19; // area_index + 2
                    area18 = 0;
                end else begin
                    area_index = 18; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 18) begin
            if (data != 0) begin
                area18 = data;
                if (space) begin
                    area_index = 20; // area_index + 2
                    area19 = 0;
                end else begin
                    area_index = 19; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 19) begin
            if (data != 0) begin
                area19 = data;
                if (space) begin
                    area_index = 21; // area_index + 2
                    area20 = 0;
                end else begin
                    area_index = 20; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 20) begin
            if (data != 0) begin
                area20 = data;
                if (space) begin
                    area_index = 22; // area_index + 2
                    area21 = 0;
                end else begin
                    area_index = 21; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 21) begin
            if (data != 0) begin
                area21 = data;
                if (space) begin
                    area_index = 23; // area_index + 2
                    area22 = 0;
                end else begin
                    area_index = 22; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 22) begin
            if (data != 0) begin
                area22 = data;
                if (space) begin
                    area_index = 24; // area_index + 2
                    area23 = 0;
                end else begin
                    area_index = 23; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 23) begin
            if (data != 0) begin
                area23 = data;
                if (space) begin
                    area_index = 25; // area_index + 2
                    area24 = 0;
                end else begin
                    area_index = 24; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 24) begin
            if (data != 0) begin
                area24 = data;
                if (space) begin
                    area_index = 26; // area_index + 2
                    area25 = 0;
                end else begin
                    area_index = 25; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 25) begin
            if (data != 0) begin
                area25 = data;
                if (space) begin
                    area_index = 27; // area_index + 2
                    area26 = 0;
                end else begin
                    area_index = 26; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 26) begin
            if (data != 0) begin
                area26 = data;
                if (space) begin
                    area_index = 28; // area_index + 2
                    area27 = 0;
                end else begin
                    area_index = 27; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 27) begin
            if (data != 0) begin
                area27 = data;
                if (space) begin
                    area_index = 29; // area_index + 2
                    area28 = 0;
                end else begin
                    area_index = 28; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 28) begin
            if (data != 0) begin
                area28 = data;
                if (space) begin
                    area_index = 30; // area_index + 2
                    area29 = 0;
                end else begin
                    area_index = 29; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 29) begin
            if (data != 0) begin
                area29 = data;
                if (space) begin
                    area_index = 1; // area_index + 2
                    area30 = 0;
                end else begin
                    area_index = 30; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end else if (area_index == 30) begin
            if (data != 0) begin
                area30 = data;
                if (space) begin
                    area_index = 2; // area_index + 2
                    area1 = 0;
                end else begin
                    area_index = 1; // area_index + 1
                end
            end else if (interword) begin
                space = 1;
            end else if (interchar) begin
                space = 0;
            end
        end
    end
end




reg [0:255] area1;
wire [7:0] VGA_R1;
wire [7:0] VGA_G1;
wire [7:0] VGA_B1;
assign printable_area1 = (ativo && (sx < 36) && (sx >= 20) && (sy >= 232) && (sy < 248));
image inst_area1(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area1),
    .printable(printable_area1),
    .VGA_R(VGA_R1),
    .VGA_G(VGA_G1),
    .VGA_B(VGA_B1)
);

reg [0:255] area2;
wire [7:0] VGA_R2;
wire [7:0] VGA_G2;
wire [7:0] VGA_B2;
assign printable_area2 = (ativo && (sx < 56) && (sx >= 40) && (sy >= 232) && (sy < 248));
image inst_area2(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area2),
    .printable(printable_area2),
    .VGA_R(VGA_R2),
    .VGA_G(VGA_G2),
    .VGA_B(VGA_B2)
);

reg [0:255] area3;
wire [7:0] VGA_R3;
wire [7:0] VGA_G3;
wire [7:0] VGA_B3;
assign printable_area3 = (ativo && (sx < 76) && (sx >= 60) && (sy >= 232) && (sy < 248));
image inst_area3(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area3),
    .printable(printable_area3),
    .VGA_R(VGA_R3),
    .VGA_G(VGA_G3),
    .VGA_B(VGA_B3)
);

reg [0:255] area4;
wire [7:0] VGA_R4;
wire [7:0] VGA_G4;
wire [7:0] VGA_B4;
assign printable_area4 = (ativo && (sx < 96) && (sx >= 80) && (sy >= 232) && (sy < 248));
image inst_area4(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area4),
    .printable(printable_area4),
    .VGA_R(VGA_R4),
    .VGA_G(VGA_G4),
    .VGA_B(VGA_B4)
);

reg [0:255] area5;
wire [7:0] VGA_R5;
wire [7:0] VGA_G5;
wire [7:0] VGA_B5;
assign printable_area5 = (ativo && (sx < 116) && (sx >= 100) && (sy >= 232) && (sy < 248));
image inst_area5(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area5),
    .printable(printable_area5),
    .VGA_R(VGA_R5),
    .VGA_G(VGA_G5),
    .VGA_B(VGA_B5)
);

reg [0:255] area6;
wire [7:0] VGA_R6;
wire [7:0] VGA_G6;
wire [7:0] VGA_B6;
assign printable_area6 = (ativo && (sx < 136) && (sx >= 120) && (sy >= 232) && (sy < 248));
image inst_area6(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area6),
    .printable(printable_area6),
    .VGA_R(VGA_R6),
    .VGA_G(VGA_G6),
    .VGA_B(VGA_B6)
);

reg [0:255] area7;
wire [7:0] VGA_R7;
wire [7:0] VGA_G7;
wire [7:0] VGA_B7;
assign printable_area7 = (ativo && (sx < 156) && (sx >= 140) && (sy >= 232) && (sy < 248));
image inst_area7(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area7),
    .printable(printable_area7),
    .VGA_R(VGA_R7),
    .VGA_G(VGA_G7),
    .VGA_B(VGA_B7)
);

reg [0:255] area8;
wire [7:0] VGA_R8;
wire [7:0] VGA_G8;
wire [7:0] VGA_B8;
assign printable_area8 = (ativo && (sx < 176) && (sx >= 160) && (sy >= 232) && (sy < 248));
image inst_area8(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area8),
    .printable(printable_area8),
    .VGA_R(VGA_R8),
    .VGA_G(VGA_G8),
    .VGA_B(VGA_B8)
);

reg [0:255] area9;
wire [7:0] VGA_R9;
wire [7:0] VGA_G9;
wire [7:0] VGA_B9;
assign printable_area9 = (ativo && (sx < 196) && (sx >= 180) && (sy >= 232) && (sy < 248));
image inst_area9(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area9),
    .printable(printable_area9),
    .VGA_R(VGA_R9),
    .VGA_G(VGA_G9),
    .VGA_B(VGA_B9)
);

reg [0:255] area10;
wire [7:0] VGA_R10;
wire [7:0] VGA_G10;
wire [7:0] VGA_B10;
assign printable_area10 = (ativo && (sx < 216) && (sx >= 200) && (sy >= 232) && (sy < 248));
image inst_area10(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area10),
    .printable(printable_area10),
    .VGA_R(VGA_R10),
    .VGA_G(VGA_G10),
    .VGA_B(VGA_B10)
);

reg [0:255] area11;
wire [7:0] VGA_R11;
wire [7:0] VGA_G11;
wire [7:0] VGA_B11;
assign printable_area11 = (ativo && (sx < 236) && (sx >= 220) && (sy >= 232) && (sy < 248));
image inst_area11(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area11),
    .printable(printable_area11),
    .VGA_R(VGA_R11),
    .VGA_G(VGA_G11),
    .VGA_B(VGA_B11)
);

reg [0:255] area12;
wire [7:0] VGA_R12;
wire [7:0] VGA_G12;
wire [7:0] VGA_B12;
assign printable_area12 = (ativo && (sx < 256) && (sx >= 240) && (sy >= 232) && (sy < 248));
image inst_area12(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area12),
    .printable(printable_area12),
    .VGA_R(VGA_R12),
    .VGA_G(VGA_G12),
    .VGA_B(VGA_B12)
);

reg [0:255] area13;
wire [7:0] VGA_R13;
wire [7:0] VGA_G13;
wire [7:0] VGA_B13;
assign printable_area13 = (ativo && (sx < 276) && (sx >= 260) && (sy >= 232) && (sy < 248));
image inst_area13(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area13),
    .printable(printable_area13),
    .VGA_R(VGA_R13),
    .VGA_G(VGA_G13),
    .VGA_B(VGA_B13)
);

reg [0:255] area14;
wire [7:0] VGA_R14;
wire [7:0] VGA_G14;
wire [7:0] VGA_B14;
assign printable_area14 = (ativo && (sx < 296) && (sx >= 280) && (sy >= 232) && (sy < 248));
image inst_area14(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area14),
    .printable(printable_area14),
    .VGA_R(VGA_R14),
    .VGA_G(VGA_G14),
    .VGA_B(VGA_B14)
);

reg [0:255] area15;
wire [7:0] VGA_R15;
wire [7:0] VGA_G15;
wire [7:0] VGA_B15;
assign printable_area15 = (ativo && (sx < 316) && (sx >= 300) && (sy >= 232) && (sy < 248));
image inst_area15(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area15),
    .printable(printable_area15),
    .VGA_R(VGA_R15),
    .VGA_G(VGA_G15),
    .VGA_B(VGA_B15)
);

reg [0:255] area16;
wire [7:0] VGA_R16;
wire [7:0] VGA_G16;
wire [7:0] VGA_B16;
assign printable_area16 = (ativo && (sx < 336) && (sx >= 320) && (sy >= 232) && (sy < 248));
image inst_area16(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area16),
    .printable(printable_area16),
    .VGA_R(VGA_R16),
    .VGA_G(VGA_G16),
    .VGA_B(VGA_B16)
);

reg [0:255] area17;
wire [7:0] VGA_R17;
wire [7:0] VGA_G17;
wire [7:0] VGA_B17;
assign printable_area17 = (ativo && (sx < 356) && (sx >= 340) && (sy >= 232) && (sy < 248));
image inst_area17(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area17),
    .printable(printable_area17),
    .VGA_R(VGA_R17),
    .VGA_G(VGA_G17),
    .VGA_B(VGA_B17)
);

reg [0:255] area18;
wire [7:0] VGA_R18;
wire [7:0] VGA_G18;
wire [7:0] VGA_B18;
assign printable_area18 = (ativo && (sx < 376) && (sx >= 360) && (sy >= 232) && (sy < 248));
image inst_area18(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area18),
    .printable(printable_area18),
    .VGA_R(VGA_R18),
    .VGA_G(VGA_G18),
    .VGA_B(VGA_B18)
);

reg [0:255] area19;
wire [7:0] VGA_R19;
wire [7:0] VGA_G19;
wire [7:0] VGA_B19;
assign printable_area19 = (ativo && (sx < 396) && (sx >= 380) && (sy >= 232) && (sy < 248));
image inst_area19(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area19),
    .printable(printable_area19),
    .VGA_R(VGA_R19),
    .VGA_G(VGA_G19),
    .VGA_B(VGA_B19)
);

reg [0:255] area20;
wire [7:0] VGA_R20;
wire [7:0] VGA_G20;
wire [7:0] VGA_B20;
assign printable_area20 = (ativo && (sx < 416) && (sx >= 400) && (sy >= 232) && (sy < 248));
image inst_area20(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area20),
    .printable(printable_area20),
    .VGA_R(VGA_R20),
    .VGA_G(VGA_G20),
    .VGA_B(VGA_B20)
);

reg [0:255] area21;
wire [7:0] VGA_R21;
wire [7:0] VGA_G21;
wire [7:0] VGA_B21;
assign printable_area21 = (ativo && (sx < 436) && (sx >= 420) && (sy >= 232) && (sy < 248));
image inst_area21(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area21),
    .printable(printable_area21),
    .VGA_R(VGA_R21),
    .VGA_G(VGA_G21),
    .VGA_B(VGA_B21)
);

reg [0:255] area22;
wire [7:0] VGA_R22;
wire [7:0] VGA_G22;
wire [7:0] VGA_B22;
assign printable_area22 = (ativo && (sx < 456) && (sx >= 440) && (sy >= 232) && (sy < 248));
image inst_area22(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area22),
    .printable(printable_area22),
    .VGA_R(VGA_R22),
    .VGA_G(VGA_G22),
    .VGA_B(VGA_B22)
);

reg [0:255] area23;
wire [7:0] VGA_R23;
wire [7:0] VGA_G23;
wire [7:0] VGA_B23;
assign printable_area23 = (ativo && (sx < 476) && (sx >= 460) && (sy >= 232) && (sy < 248));
image inst_area23(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area23),
    .printable(printable_area23),
    .VGA_R(VGA_R23),
    .VGA_G(VGA_G23),
    .VGA_B(VGA_B23)
);

reg [0:255] area24;
wire [7:0] VGA_R24;
wire [7:0] VGA_G24;
wire [7:0] VGA_B24;
assign printable_area24 = (ativo && (sx < 496) && (sx >= 480) && (sy >= 232) && (sy < 248));
image inst_area24(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area24),
    .printable(printable_area24),
    .VGA_R(VGA_R24),
    .VGA_G(VGA_G24),
    .VGA_B(VGA_B24)
);

reg [0:255] area25;
wire [7:0] VGA_R25;
wire [7:0] VGA_G25;
wire [7:0] VGA_B25;
assign printable_area25 = (ativo && (sx < 516) && (sx >= 500) && (sy >= 232) && (sy < 248));
image inst_area25(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area25),
    .printable(printable_area25),
    .VGA_R(VGA_R25),
    .VGA_G(VGA_G25),
    .VGA_B(VGA_B25)
);

reg [0:255] area26;
wire [7:0] VGA_R26;
wire [7:0] VGA_G26;
wire [7:0] VGA_B26;
assign printable_area26 = (ativo && (sx < 536) && (sx >= 520) && (sy >= 232) && (sy < 248));
image inst_area26(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area26),
    .printable(printable_area26),
    .VGA_R(VGA_R26),
    .VGA_G(VGA_G26),
    .VGA_B(VGA_B26)
);

reg [0:255] area27;
wire [7:0] VGA_R27;
wire [7:0] VGA_G27;
wire [7:0] VGA_B27;
assign printable_area27 = (ativo && (sx < 556) && (sx >= 540) && (sy >= 232) && (sy < 248));
image inst_area27(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area27),
    .printable(printable_area27),
    .VGA_R(VGA_R27),
    .VGA_G(VGA_G27),
    .VGA_B(VGA_B27)
);

reg [0:255] area28;
wire [7:0] VGA_R28;
wire [7:0] VGA_G28;
wire [7:0] VGA_B28;
assign printable_area28 = (ativo && (sx < 576) && (sx >= 560) && (sy >= 232) && (sy < 248));
image inst_area28(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area28),
    .printable(printable_area28),
    .VGA_R(VGA_R28),
    .VGA_G(VGA_G28),
    .VGA_B(VGA_B28)
);

reg [0:255] area29;
wire [7:0] VGA_R29;
wire [7:0] VGA_G29;
wire [7:0] VGA_B29;
assign printable_area29 = (ativo && (sx < 596) && (sx >= 580) && (sy >= 232) && (sy < 248));
image inst_area29(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area29),
    .printable(printable_area29),
    .VGA_R(VGA_R29),
    .VGA_G(VGA_G29),
    .VGA_B(VGA_B29)
);

reg [0:255] area30;
wire [7:0] VGA_R30;
wire [7:0] VGA_G30;
wire [7:0] VGA_B30;
assign printable_area30 = (ativo && (sx < 616) && (sx >= 600) && (sy >= 232) && (sy < 248));
image inst_area30(
    .clk(VGA_CLK),
    .reset(reset),
    .char(area30),
    .printable(printable_area30),
    .VGA_R(VGA_R30),
    .VGA_G(VGA_G30),
    .VGA_B(VGA_B30)
);

assign VGA_R = (ativo) ? (VGA_R1 + VGA_R2 + VGA_R3 + VGA_R4 + VGA_R5 + VGA_R6 + VGA_R7 + VGA_R8 + VGA_R9 + VGA_R10 + VGA_R11 + VGA_R12 + VGA_R13 + VGA_R14 + VGA_R15 + VGA_R16 + VGA_R17 + VGA_R18 + VGA_R19 + VGA_R20 + VGA_R21 + VGA_R22 + VGA_R23 + VGA_R24 + VGA_R25 + VGA_R26 + VGA_R27 + VGA_R28 + VGA_R29 + VGA_R30) : 0;
assign VGA_G = (ativo) ? (VGA_G1 + VGA_G2 + VGA_G3 + VGA_G4 + VGA_G5 + VGA_G6 + VGA_G7 + VGA_G8 + VGA_G9 + VGA_G10 + VGA_G11 + VGA_G12 + VGA_G13 + VGA_G14 + VGA_G15 + VGA_G16 + VGA_G17 + VGA_G18 + VGA_G19 + VGA_G20 + VGA_G21 + VGA_G22 + VGA_G23 + VGA_G24 + VGA_G25 + VGA_G26 + VGA_G27 + VGA_G28 + VGA_G29 + VGA_G30) : 0;
assign VGA_B = (ativo) ? (VGA_B1 + VGA_B2 + VGA_B3 + VGA_B4 + VGA_B5 + VGA_B6 + VGA_B7 + VGA_B8 + VGA_B9 + VGA_B10 + VGA_B11 + VGA_B12 + VGA_B13 + VGA_B14 + VGA_B15 + VGA_B16 + VGA_B17 + VGA_B18 + VGA_B19 + VGA_B20 + VGA_B21 + VGA_B22 + VGA_B23 + VGA_B24 + VGA_B25 + VGA_B26 + VGA_B27 + VGA_B28 + VGA_B29 + VGA_B30) : 0;


endmodule
