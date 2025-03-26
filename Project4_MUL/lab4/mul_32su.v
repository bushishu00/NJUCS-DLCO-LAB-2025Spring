module mul_32su(
    output [63:0] p,         // 乘积
    output out_valid,        // 乘法器完成信号
    input clk,               // 时钟 
    input rst_n,             // 复位信号，低有效
    input [31:0] x,          // 被乘数
    input [31:0] y,          // 乘数
    input in_valid           // 乘法启动信号
); 
     wire out_valid_tmp;
     wire [64:0] mul_r;             
     wire [31:0] y_in;       //高位置零
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
