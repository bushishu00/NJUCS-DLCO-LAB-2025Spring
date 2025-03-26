`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/02 00:39:53
// Design Name: 
// Module Name: mul_32p
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

  
module array_multiplier_csa_32bit (
    input  [31:0] a, b,
    output [63:0] p
);
    reg [31:0] partial_products [31:0]; // 存储部分积
    reg [63:0] sum [31:0];              // 进位保留加法器的中间结果
    reg [63:0] carry [31:0];            // 进位信号
    
    integer i, j;
    
    // 生成部分积
    always @(*) begin
        for (i = 0; i < 32; i = i + 1) begin
            for (j = 0; j < 32; j = j + 1) begin
                partial_products[i][j] = a[j] & b[i];
            end
        end
    end
    
    // 初始化第一层
    assign sum[0] = {32'b0, partial_products[0]};
    assign carry[0] = 64'b0;
    
    // 逐层使用进位保留加法器进行累加
    always @(*) begin
        for (i = 1; i < 32; i = i + 1) begin
            {carry[i], sum[i]} = sum[i-1] + {32'b0, partial_products[i]} + carry[i-1];
        end
    end
    
    // 最终结果
    assign p = sum[31] + carry[31];
    
endmodule

