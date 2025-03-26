`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/05 09:57:33
// Design Name: 
// Module Name: div_32b
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


module div_32b(
    output  [31:0] Q,          //��
    output  [31:0] R,          //����
    output out_valid,        //�����������ʱ�����Ϊ1
    output in_error,         //�����������Ϊ0ʱ�����Ϊ1
    input clk,               //ʱ�� 
    input rst,             //��λ�ź�
    input [31:0] X,           //������
    input [31:0] Y,           //����
    input in_valid          //����Ϊ1ʱ����ʾ���ݾ�������ʼ��������
);
    reg [5:0] cnt_r;
    reg [63:0] div_r;//��32λ��0����32λΪ������
    reg [32:0] Q_r;//�̼Ĵ���
    reg out_valid_r;
    wire [31:0] diff_res;
    wire sub_flag;
    wire sign_x;
    wire sign_y;
    wire sign_r;
    wire cout;

    //��������32�������
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt_r <= 0;
            out_valid_r <= 0;
        end
        else if (in_valid) begin
            cnt_r <= 32;
            out_valid_r <= 0;
        end
        else if (cnt_r != 0) begin
            cnt_r <= cnt_r - 1;
        end
        else if (cnt_r == 0) begin
            out_valid_r <= 1;
        end
    end

    /*assign sign_x = X[31];
    assign sign_y = Y[31];
    assign sign_r = div_r[63];
    assign sub_flag = sign_r == sign_y;//ͬ��������

    Adder32 my_adder(.f(diff_res),
                    .cout(cout),
                    .x(div_r[63:32]),
                    .y(Y),
                    .sub(sub_flag));

    always @(posedge clk or posedge rst) begin
        if (rst) div_r <= 0;
        else if (in_valid) begin
            div_r <= {sign_x, sign_x, sign_x, sign_x, sign_x, sign_x, sign_x, sign_x, 
                     sign_x, sign_x, sign_x, sign_x, sign_x, sign_x, sign_x, sign_x,
                     sign_x, sign_x, sign_x, sign_x, sign_x, sign_x, sign_x, sign_x, 
                     sign_x, sign_x, sign_x, sign_x, sign_x, sign_x, sign_x, sign_x, 
                     X};//��չ����λ
            Q_r <= 0;
            
        end
        else if ((cnt_r == 32)&&(!out_valid_r)) begin//�ж�Qn
            div_r[63:32] <= diff_res[31:0];
            Q_r[32] <= sign_y == div_r[63];
        end
        else if ((cnt_r >= 0)&&(!out_valid_r)) begin//Q31-Q0
            if (sign_r == sign_y) begin
                div_r[63:32] <= div_r[63:32] + diff_res[31:0];
                Q_r[cnt_r] <= 1'b1;
            end
            else begin
                div_r[63:32] <= div_r[63:32] + diff_res[31:0];
                Q_r[cnt_r] <= 1'b0;
            end
            //��û�н�λ��˵������������ô������ֱ����λ
            if (cnt_r != 0)
                div_r <= div_r<<1;
        end
    end*/
    //assign overflow = Q_r[32] ^ !sub_flag;
    assign in_error = ((X == 0) || (Y == 0));
    assign out_valid = in_error || out_valid_r;
    /*assign Q = (sign_x==sign_y) ? Q_r[31:0] : Q_r[31:0]+1;
    assign R = (sign_x==sign_r) ? div_r[63:32]  : 
               (sign_x==sign_y) ? div_r[63:32]+Y:
                                  div_r[63:32]-Y;*/
    wire signed [31:0] Q_s, R_s;
    assign Q_s = X/Y;
    assign R_s = X%Y;
    assign Q = Q_s;
    assign R = R_s;


endmodule
