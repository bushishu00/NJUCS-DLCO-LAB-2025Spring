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
    
    reg [31:0] res;
    reg signed [31:0] rs1_s;
    reg signed [31:0] rs2_s;
    reg [31:0] rs1_u;
    reg [31:0] rs2_u;

    reg out_valid_r;
    reg funct3_r;

    wire [31:0] res_mul_l, res_mul_uu_h, res_mul_ss_h, res_mul_su_h, res_div_u_r, res_div_u_q, res_div_s_r, res_div_s_q;
    wire out_valid_divu, out_valid_divs, out_valid_mulu, out_valid_muls, out_valid_mulsu;

    mul_32u mul_u(.p({res_mul_uu_h, res_mul_l}),
                  .out_valid(out_valid_mulu),
                  .clk(clk),
                  .rst(!rst),
                  .x(rs1),
                  .y(rs2),
                  .in_valid(in_valid));
    mul_32b mul_s(.p({res_mul_ss_h, res_mul_l}),
                  .out_valid(out_valid_muls),
                  .clk(clk),
                  .rst_n(rst),
                  .x(rs1),
                  .y(rs2),
                  .in_valid(in_valid));
    mul_32su mul_su(.p({res_mul_su_h, res_mul_l}),
                    .out_valid(out_valid_mulsu),
                    .clk(clk),
                    .rst_n(rst),
                    .x(rs1),
                    .y(rs2),
                    .in_valid(in_valid));
    div_32u div_u(.Q(res_div_u_q),
                  .R(res_div_u_r),
                  .out_valid(out_valid_divu),
                  .in_error(in_error),
                  .clk(clk),
                  .rst(!rst),
                  .X(rs1),
                  .Y(rs2),
                  .in_valid(in_valid));
    div_32b div_s(.Q(res_div_s_q),
                  .R(res_div_s_r),
                  .out_valid(out_valid_divs),
                  .in_error(in_error),
                  .clk(clk),
                  .rst(!rst),
                  .X(rs1),
                  .Y(rs2),
                  .in_valid(in_valid));
    assign out_valid = (funct3==3'b000 && out_valid_muls) || 
                       (funct3==3'b001 && out_valid_muls) || 
                       (funct3==3'b010 && out_valid_mulsu)|| 
                       (funct3==3'b011 && out_valid_mulu) || 
                       (funct3==3'b100 && out_valid_divs) || 
                       (funct3==3'b101 && out_valid_divu) || 
                       (funct3==3'b110 && out_valid_divs) || 
                       (funct3==3'b111 && out_valid_divu);
    assign rd = (funct3==3'b000) ? res_mul_l : 
                (funct3==3'b001) ? res_mul_ss_h : 
                (funct3==3'b010) ? res_mul_su_h : 
                (funct3==3'b011) ? res_mul_uu_h : 
                (funct3==3'b100) ? res_div_s_q : 
                (funct3==3'b101) ? res_div_u_q : 
                (funct3==3'b110) ? res_div_s_r : 
                (funct3==3'b111) ? res_div_u_r : 0;

    /*reg [5:0] cnt_r;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt_r <= 0;
        end
        else if (in_valid || funct3_r!= funct3) begin
            cnt_r <= 32;
        end
        else if (cnt_r != 0) begin
            cnt_r <= cnt_r - 1;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            res <= 0;
            out_valid_r <= 0;
        end
        else if (in_valid || funct3_r!= funct3) begin
            rs1_s <= rs1;
            rs2_s <= rs2;
            rs1_u <= rs1;
            rs2_u <= rs2;
            out_valid_r <= 0;
        end
        else if (cnt_r != 0) begin
            case (funct3)
            3'b000:begin//有符号*有符号低位
                res <= (rs1_s*rs2_s);
            end
            3'b001:begin//有符号*有符号高位
                res <= (rs1_s*rs2_s)[63:32];
            end
            3'b010:begin//有符号*无符号高位
                res <= (rs1_s*rs2_u)[63:32];
            end
            3'b011:begin//无符号*无符号高位
                res <= (rs1_u*rs2_u)[63:32];
            end
            3'b100:begin//有符号除法，写入商
                res <= (rs1_s/rs2_s);
            end
            3'b101:begin//无符号除法，写入商
                res <= (rs1_u/rs2_u);
            end
            3'b110:begin//有符号除法，写入余
                res <= (rs1_s%rs2_s);
            end
            3'b111:begin//无符号除法，写入余
                res <= (rs1_u%rs2_u);
            end
            endcase
        end
        else if (cnt_r == 0)
            out_valid_r <= 1;
    end*/


endmodule
