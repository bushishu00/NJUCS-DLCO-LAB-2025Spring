`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/29 13:59:21
// Design Name: 
// Module Name: mul_32u
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


module mul_32u(
     input clk, rst,
     input [31:0] x, y,
     input in_valid,
     output [63:0] p,
     output out_valid
);
     reg [63:0] mul_r;//高位部分和，低位乘数
     reg [5:0] cnt_r;
     wire cout;
     wire [31:0] add_res;

     always @(posedge clk or posedge rst) begin
          if (rst) 
               cnt_r <= 0;
          else if (in_valid) 
               cnt_r <= 32;
          else if (cnt_r != 0)
               cnt_r <= cnt_r - 1;
     end

     
     Adder32 my_adder(.f(add_res),
                      .cout(cout),
                      .x(mul_r[63:32]),
                      .y(mul_r[0]?x:0),
                      .sub(1'b0));

     always @(posedge clk or posedge rst) begin
          if (rst) 
               mul_r <= 0;
          else if (in_valid) 
               mul_r <= {32'b0, y};
          else if (cnt_r != 0) begin
               mul_r <= {cout, add_res, mul_r[31:1]};
          end    
     end
     assign out_valid = (cnt_r == 0);
     assign p = mul_r;
endmodule

