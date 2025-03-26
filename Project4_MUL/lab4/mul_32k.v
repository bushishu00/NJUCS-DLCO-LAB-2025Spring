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

  
module mul_32k(
  input [31:0] a, b,
  output [63:0] product       // output variable for assignment
  );
    assign product = a*b  ;
    /*wire [31:0] partial_products [31:0];
    wire [63:0] sum [30:0];
    wire [63:0] carry [30:0];
    
    genvar i, j;
    generate
        for (i = 0; i < 32; i = i + 1) begin
            for (j = 0; j < 32; j = j + 1) begin
                assign partial_products[i][j] = a[j] & b[i];
            end
            assign partial_products[i][31:0] = {partial_products[i], i*{1'b0}};
        end
        
        // 第一层加法（初始化）
        assign sum[0] = {32'b0, partial_products[0]};
        assign carry[0] = 64'b0;
        
        for (i = 1; i < 31; i = i + 1) begin : csa_stage
            CSA32 CSA (
                .a(sum[i-1][31:0]),
                .b(partial_products[i]),
                .c(carry[i-1][31:0]),
                .sum(sum[i][31:0]),
                .carry(carry[i][31:0])
            );
            assign sum[i][63:32] = sum[i-1][63:32] + carry[i-1][32:1];
            assign carry[i][63:32] = {1'b0, carry[i-1][63:33]};
        end
        
        assign product = sum[30] + carry[30];
    endgenerate*/


endmodule

