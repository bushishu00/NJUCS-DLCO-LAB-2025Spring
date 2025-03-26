`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/05 10:12:50
// Design Name: 
// Module Name: rv32m
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


module rv32m(
    output  [31:0] rd,        //运算结果
    output out_valid,         //运算结束时，输出为1
    output in_error,          //运算出错时，输出为1
    input clk,               //时钟 
    input rst,               //复位信号，低有效
    input [31:0] rs1,          //操作数rs1
    input [31:0] rs2,          //操作数rs2
    input [2:0] funct3,        //3位功能选择码
    input in_valid           //输入为1时，表示数据就绪，开始除法运算
    );
    wire [31:0] res_div_u_r, res_div_u_q, res_div_s_r, res_div_s_q;
    wire [63:0] p_uu, p_ss, p_su;
    wire out_valid_divu, out_valid_divs, out_valid_mulu, out_valid_muls, out_valid_mulsu;
    wire in_error_1, in_error_2;

    mul_32u mul_u(.p(p_uu),
                  .out_valid(out_valid_mulu),
                  .clk(clk),
                  .rst(!rst),
                  .x(rs1),
                  .y(rs2),
                  .in_valid(in_valid));
    mul_32b mul_s(.p(p_ss),
                  .out_valid(out_valid_muls),
                  .clk(clk),
                  .rst_n(rst),
                  .x(rs1),
                  .y(rs2),
                  .in_valid(in_valid));
    mul_32su mul_su(.p(p_su),
                    .out_valid(out_valid_mulsu),
                    .clk(clk),
                    .rst_n(rst),
                    .x(rs1),
                    .y(rs2),
                    .in_valid(in_valid));
    div_32u div_u(.Q(res_div_u_q),
                  .R(res_div_u_r),
                  .out_valid(out_valid_divu),
                  .in_error(in_error_1),
                  .clk(clk),
                  .rst(!rst),
                  .X(rs1),
                  .Y(rs2),
                  .in_valid(in_valid));
    div_32b div_s(.Q(res_div_s_q),
                  .R(res_div_s_r),
                  .out_valid(out_valid_divs),
                  .in_error(in_error_2),
                  .clk(clk),
                  .rst(!rst),
                  .X(rs1),
                  .Y(rs2),
                  .in_valid(in_valid));
    assign in_error = (funct3 > 4) && (in_error_1 || in_error_2);
    assign out_valid = (funct3==3'b000 && out_valid_muls) || 
                       (funct3==3'b001 && out_valid_muls) || 
                       (funct3==3'b010 && out_valid_mulsu)|| 
                       (funct3==3'b011 && out_valid_mulu) || 
                       (funct3==3'b100 && out_valid_divs) || 
                       (funct3==3'b101 && out_valid_divu) || 
                       (funct3==3'b110 && out_valid_divs) || 
                       (funct3==3'b111 && out_valid_divu);
    assign rd = (funct3==3'b000) ? p_su[31:0] : 
                (funct3==3'b001) ? p_ss[63:32] : 
                (funct3==3'b010) ? p_su[63:32] : 
                (funct3==3'b011) ? p_uu[63:32] : 
                (funct3==3'b100) ? res_div_s_q : 
                (funct3==3'b101) ? res_div_u_q : 
                (funct3==3'b110) ? res_div_s_r : 
                (funct3==3'b111) ? res_div_u_r : 0;



endmodule
