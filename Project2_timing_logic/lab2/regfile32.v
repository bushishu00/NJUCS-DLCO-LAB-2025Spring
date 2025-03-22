`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 20:17:44
// Design Name: 
// Module Name: regfile32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module regfile32(
   output  [31:0] busa,
   output  [31:0] busb,
   input [31:0] busw,
   input [4:0] ra,
   input [4:0] rb,
   input [4:0] rw,
   input clk, we
);
//ra和rb为读地址（寄存器编号），busa和busb时读出数据
//读为组合逻辑，不受clk控制
//rw为写地址（寄存器编号），busw为写数据
//写为时序逻辑，we写使能（高有效），clk下降沿写有效

reg [31:0] GRPs [31:0];

//读
assign busa = GRPs[ra];
assign busb = GRPs[rb];

//写
always @(negedge clk) begin
   GRPs[rw] <= we ? busw : GRPs[rw];
end

endmodule
