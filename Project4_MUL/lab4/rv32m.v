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
    output  [31:0] rd,        //������
    output out_valid,         //�������ʱ�����Ϊ1
    output in_error,          //�������ʱ�����Ϊ1
    input clk,               //ʱ�� 
    input rst,               //��λ�źţ�����Ч
    input [31:0] rs1,          //������rs1
    input [31:0] rs2,          //������rs2
    input [2:0] funct3,        //3λ����ѡ����
    input in_valid           //����Ϊ1ʱ����ʾ���ݾ�������ʼ��������
    );
    //add your code here
endmodule
