module mul_32su(
    output [63:0] p,         // �˻�
    output out_valid,        // �˷�������ź�
    input clk,               // ʱ�� 
    input rst_n,             // ��λ�źţ�����Ч
    input [31:0] x,          // ������
    input [31:0] y,          // ����
    input in_valid           // �˷������ź�
); 
     wire out_valid_tmp;
     wire [64:0] mul_r;             
     wire [31:0] y_in;       //��λ����
     wire y_h;
     assign y_in = {1'b0, y[30:0]};   
     assign y_h = y[31];

     mul_32b mul_32b_inst(
         .p(mul_r),
         .out_valid(out_valid_tmp),
         .clk(clk),
         .rst_n(rst_n),
         .x(x),
         .y(y_in),
         .in_valid(in_valid)
     );

     reg [63:0] psum;
     reg out_valid_r;
     always@(posedge clk) begin
           if (!rst_n) begin
                psum <= 0;
                out_valid_r <= 0;
           end
           else if (in_valid) begin
                psum <= 0;
                out_valid_r <= 0;
           end
           else if (out_valid_tmp) begin
                psum <= mul_r[64:1] + (y_h ? x<<31 : 0);
                out_valid_r <= 1;
           end
     end

     assign p = psum;
     assign out_valid = out_valid_r;

endmodule
