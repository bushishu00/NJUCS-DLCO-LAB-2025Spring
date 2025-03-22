`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/09 21:27:45
// Design Name: 
// Module Name: hamming7check
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


module hamming7check(
   output reg [7:1] DC,    //�������7λ��ȷ�Ľ��
   output reg  NOERROR,    //У������ȷ��־λ
   output  reg  [6:0] O_seg,  //7λ��ʾ�����
   output  reg  [7:0] O_led,  //8��������������(ԭ������ӿ���Ϊan)
   input  [7:1] DU         //����7λ������
);
   // ʶ�����λ
   wire [2:0] S;            //У��λ
   assign S = { DU[4]^DU[5]^DU[6]^DU[7], DU[2]^DU[3]^DU[6]^DU[7], DU[1]^DU[3]^DU[5]^DU[7]};

   // ����
   always@(*)begin
      DC = DU;
      NOERROR = (S == 3'b000);
      DC[S] = (S == 3'b000)? DC[S]: ~DC[S];
   end

   // 7���������ʾ
   wire [6:0] seg;
   wire [7:0] an;
   dec7seg u1(.I(S), .S(S), .O_seg(seg), .O_led(an));
   always @(*) begin
      O_seg = seg;
      O_led = an;
   end

endmodule


module dec7seg(
//�˿�����
output  reg  [6:0] O_seg,  //7λ��ʾ�����
output  reg  [7:0] O_led,  //8��������������
input   [3:0] I,           //4λ�������룬��Ҫ��ʾ������   
input   [2:0] S          //3λ����ѡ��ָ���������ʾ
); 
// add your code here
    wire [6:0] seg;
    hex2seg u1(.hex(I), .seg(seg));
    always @(*) begin
        O_led = (S == 3'b000) ? 8'b11111110 :
                (S == 3'b001) ? 8'b11111101 :
                (S == 3'b010) ? 8'b11111011 :
                (S == 3'b011) ? 8'b11110111 :
                (S == 3'b100) ? 8'b11101111 :
                (S == 3'b101) ? 8'b11011111 :
                (S == 3'b110) ? 8'b10111111 :
                (S == 3'b111) ? 8'b01111111 : 
                                8'b11111111 ;
        O_seg = seg;
    end
endmodule

module hex2seg(
input [3:0] hex,
output [6:0] seg
);
    assign seg = (hex == 4'b0000) ? 7'b1000000 :
                 (hex == 4'b0001) ? 7'b1111001 :
                 (hex == 4'b0010) ? 7'b0100100 :
                 (hex == 4'b0011) ? 7'b0110000 :
                 (hex == 4'b0100) ? 7'b0011001 :
                 (hex == 4'b0101) ? 7'b0010010 :
                 (hex == 4'b0110) ? 7'b0000010 :
                 (hex == 4'b0111) ? 7'b1111000 :
                 (hex == 4'b1000) ? 7'b0000000 :
                 (hex == 4'b1001) ? 7'b0010000 :
                 (hex == 4'b1010) ? 7'b0001000 :
                 (hex == 4'b1011) ? 7'b0000011 :
                 (hex == 4'b1100) ? 7'b1000110 :
                 (hex == 4'b1101) ? 7'b0100001 :
                 (hex == 4'b1110) ? 7'b0000110 :
                 (hex == 4'b1111) ? 7'b0001110 : 
                                    7'b1111111 ;
endmodule
