`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/03 09:09:44
// Design Name: 
// Module Name: div_32u_unres
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

//parameter N =32;
module div_32u_res(
    output  [31:0] Q,          //��
    output  [31:0] R,          //����
    output out_valid,        //�����������ʱ�����Ϊ1
    output in_error,         //�����������Ϊ0ʱ�����Ϊ1
    input clk,               //ʱ�� 
    input rst,             //��λ�ź�
    input [31:0] X,           //������
    input [31:0] Y,           //����
    input in_valid          //����Ϊ1ʱ����ʾ����׼�����ˣ���ʼ��������
   );
   // add your code here
endmodule
