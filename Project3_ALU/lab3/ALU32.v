`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/17 22:03:26
// Design Name: 
// Module Name: ALU32
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


module ALU32(
output  [31:0] result,      //32λ������
output  zero,               //���Ϊ0��־λ
input   [31:0] dataa,       //32λ�������룬�͵�ALU�˿�A   
input   [31:0] datab,       //32λ�������룬�͵�ALU�˿�B  
input   [3:0] aluctr        //4λALU���������ź�
); 
//����ALU�����ź�aluctr��ѡ���Ӧ�����������
wire SUBctr, SIGctr, ALctr, SFTctr;
assign SUBctr = (aluctr == 4'b0010) || (aluctr == 4'b0011) || (aluctr == 4'b1000);//�Ƚϣ�����
assign SIGctr = aluctr == 4'b0010;//�з������Ƚ�
assign ALctr = aluctr == 4'b1101;//�߼���λor������λ
assign SFTctr = aluctr == 4'b0001;//��λ����
assign LRctr = aluctr == 4'b0001;//�߼�����

wire [31:0] result_adder;
wire overflow, sign, carry;
wire zero_add;
Adder32 my_adder(.f(result_adder),      
                 .ZF(zero_add),
                 .OF(overflow),
                 .SF(sign),
                 .CF(carry),               
                 .x(dataa),
                 .y(datab),
                 .sub(SUBctr));        

wire [31:0] result_shift;
barrelsft32 my_barrel(.dout(result_shift),
                      .din(dataa),
                      .shamt(datab[4:0]),   //ע��ֻ����5λ��λ��  
                      .LR(SFTctr),           
                      .AL(ALctr));

wire [31:0] result_and, result_or, result_xor;
assign result_and = dataa & datab;
assign result_or = dataa | datab;
assign result_xor = dataa ^ datab;

wire [31:0] smaller;
assign smaller = {31'b0, SIGctr ? ~(overflow == sign) : carry};//�޷������������н�λ��˵��С�ڣ��з�������δ���ʱ������λ�����С�����ʱ�෴��
//�������ָ���ZF���ڼӼ�������λ
assign zero = ((aluctr == 4'b0000 || aluctr == 4'b0010 || aluctr == 4'b0011 || aluctr == 4'b1000) && zero_add) || 
              ((aluctr == 4'b1101 || aluctr == 4'b0001 || aluctr == 4'b0101) && result_shift == 32'b0)         || 
              ((aluctr == 4'b0111) && result_and == 32'b0)                                                     || 
              ((aluctr == 4'b0110) && result_or == 32'b0)                                                      || 
              ((aluctr == 4'b0100) && result_xor == 32'b0)                                                     || 
              ((aluctr == 4'b1111) && datab == 32'b0);

muxOP my_mux(.result(result),
             .aluctr(aluctr),
             .result_adder(result_adder),
             .result_shift(result_shift),
             .smaller(smaller),
             .result_and(result_and),
             .result_or(result_or),
             .result_xor(result_xor),
             .operand_b(datab));

endmodule

module muxOP(
output  [31:0] result,     
input   [3:0]  aluctr,
input   [31:0] result_adder,      
input   [31:0] result_shift,
input   [31:0] smaller,
input   [31:0] result_and,
input   [31:0] result_or,
input   [31:0] result_xor,
input   [31:0] operand_b
);
//����Lab3ָ����aluctr���룬�����Ӧ�Ĳ���������������������0
assign result = (aluctr == 4'b0000 || aluctr == 4'b1000) ? result_adder :
                (aluctr == 4'b0001 || aluctr == 4'b0101 || aluctr == 4'b1101) ? result_shift :
                (aluctr == 4'b0010 || aluctr == 4'b0011) ? smaller :
                (aluctr == 4'b0111) ? result_and :
                (aluctr == 4'b0110) ? result_or :
                (aluctr == 4'b0100) ? result_xor :
                (aluctr == 4'b1111) ? operand_b : 32'b0;

endmodule
