`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/05 10:13:11
// Design Name: 
// Module Name: rv32m_top
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


module rv32m_top(
    output  [15:0] rd_l,        //�������ĵ�16λ
    output out_valid,         //�������ʱ�����Ϊ1
    output in_error,          //�������ʱ�����Ϊ1
    output [6:0] segs,        // 7����ֵ
    output [7:0] AN,         //�����ѡ��
    input clk,               //ʱ�� 
    input rst,               //��λ�źţ�����Ч
    input [3:0] x,           //������1���ظ�8�κ���Ϊrs1
    input [3:0] y,           //������2���ظ�8�κ���Ϊrs2
    input [2:0] funct3,        //3λ����ѡ����
    input in_valid          //����Ϊ1ʱ����ʾ���ݾ�������ʼ����
    );
    //add your code here
endmodule
