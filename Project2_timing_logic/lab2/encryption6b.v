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
    output [7:0] dataout,    //输出加密或解密后的8比特ASCII数据。
    output reg ready,       //输出有效标识，高电平说明输出有效，第6周期高电平
    output [5:0] key,       //输出6位加密码
    input clk,             // 时钟信号，上升沿有效
    input load,            //载入seed指示，高电平有效
    input [7:0] datain       //输入数据的8比特ASCII码。从8b'0100 0000到8'b0111 1111,只对低6位加密
);

//计数
//考虑写一个模块
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

//生成密钥
wire  [63:0] seed = 64'ha845fd7183ad75c4;       //初始64比特seed=64'ha845fd7183ad75c4
wire  [63:0] dout;
lfsr lfsr_u1(.dout(dout), .seed(seed), .clk(clk), .load(load)); 

//加密
assign key = dout[63:58];
assign dataout = ready ? {datain[7:6],datain[5:0]^key} : 8'bxxxxxxxx;
endmodule


module lfsr(              //64位线性移位寄存器
	output reg [63:0] dout,
    input  [63:0]  seed,
	input  clk,
	input  load
	);
//移位并赋予新的高位
always @(posedge clk) begin
    dout <= load ? seed : {dout[0]^dout[1]^dout[3]^dout[4], dout[63:1]};
end
endmodule
