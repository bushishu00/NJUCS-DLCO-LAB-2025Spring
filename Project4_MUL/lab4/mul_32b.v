module mul_32b(
    output [63:0] p,         // �˻�
    output out_valid,        // �˷�������ź�
    input clk,               // ʱ�� 
    input rst_n,             // ��λ�źţ�����Ч
    input [31:0] x,          // ������
    input [31:0] y,          // ����
    input in_valid           // �˷������ź�
); 

     reg [64:0] mul_r;       // product
     reg [5:0] cnt_r;        
     wire [31:0] x_in;
     assign x_in = mul_r[1:0] == 2'b00 ? 0 :
                   mul_r[1:0] == 2'b01 ? x :
                   mul_r[1:0] == 2'b10 ? ~x+1 :
                   mul_r[1:0] == 2'b11 ? 0 : 0;
     always @(posedge clk) begin
          if (!rst_n) 
               cnt_r <= 0;
          else if (in_valid) 
               cnt_r <= 32;
          else if (cnt_r != 0)
               cnt_r <= cnt_r - 1;
     end

     wire [31:0] add_res;
     Adder32 my_adder(
         .f(add_res),
         .cout(),
         .x(mul_r[64:33]),
         .y(x_in),
         .sub(1'b0)  // 10 ʱ�����01 ʱ��ӣ��������������ν
     );

     always @(posedge clk) begin
          if (!rst_n) begin
               mul_r <= 0;
          end
          else if (in_valid) begin
               mul_r <= {32'b0, y, 1'b0};
          end
          else if (cnt_r != 0) begin
               mul_r <= {add_res[31], add_res, mul_r[32:1]};  
          end    
     end

     assign out_valid = (cnt_r == 0);
     assign p = mul_r[64:1];

endmodule
