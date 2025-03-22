`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/17 16:33:34
// Design Name: 
// Module Name: encryption6b
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


module encryption6b(
    output [7:0] dataout,    //������ܻ���ܺ��8����ASCII���ݡ�
    output reg ready,       //�����Ч��ʶ���ߵ�ƽ˵�������Ч����6���ڸߵ�ƽ
    output [5:0] key,       //���6λ������
    input clk,             // ʱ���źţ���������Ч
    input load,            //����seedָʾ���ߵ�ƽ��Ч
    input [7:0] datain       //�������ݵ�8����ASCII�롣��8b'0100 0000��8'b0111 1111,ֻ�Ե�6λ����
);

//����
//����дһ��ģ��
reg [2:0] cnt = 0;
always@(posedge clk) begin
    if (load) begin
        cnt <= 0;
        ready <= 0;
    end
    else begin
        if (cnt == 3'b101) begin
            cnt <= 0;
            ready <= 1;
        end
        else begin
            cnt <= cnt + 1;
            ready <= 0;
        end
    end
end

//������Կ
wire  [63:0] seed = 64'ha845fd7183ad75c4;       //��ʼ64����seed=64'ha845fd7183ad75c4
wire  [63:0] dout;
lfsr lfsr_u1(.dout(dout), .seed(seed), .clk(clk), .load(load)); 

//����
assign key = dout[63:58];
assign dataout = ready ? {datain[7:6],datain[5:0]^key} : 8'bxxxxxxxx;
endmodule


module lfsr(              //64λ������λ�Ĵ���
	output reg [63:0] dout,
    input  [63:0]  seed,
	input  clk,
	input  load
	);
//��λ�������µĸ�λ
always @(posedge clk) begin
    dout <= load ? seed : {dout[0]^dout[1]^dout[3]^dout[4], dout[63:1]};
end
endmodule
