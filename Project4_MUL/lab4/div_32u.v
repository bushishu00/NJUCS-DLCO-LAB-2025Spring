`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/02 12:05:22
// Design Name: 
// Module Name: div_32u
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


module div_32u(
    output  [31:0] Q,          //商
    output  [31:0] R,          //余数
    output out_valid,        //除法运算结束时，输出为1
    output in_error,         //被除数或除数为0时，输出为1
    input clk,               //时钟 
    input rst,             //复位信号，高有效
    input [31:0] X,           //被除数
    input [31:0] Y,           //除数
    input in_valid          //脉冲置数信号，代表开始
);
    reg [5:0] cnt_r;
    reg [64:0] div_r;//高32位补0，低32位为被除数
    reg out_valid_r;
    wire [31:0] diff_res;
    wire cout;

    //计数器，32周期完成
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
        else begin
            out_valid_r <= 1;
        end
    end

    Adder32 my_adder(.f(diff_res),
                    .cout(cout),
                    .x(div_r[63:32]),
                    .y(Y),
                    .sub(1'b1));

    always @(posedge clk or posedge rst) begin
        if (rst) 
            div_r <= 0;
        else if (in_valid) begin
            div_r <= {1'b0, 32'b0, X};
        end
        else if (!out_valid_r) begin
            if (cout) begin
                div_r <= {diff_res[31:0], div_r[31:0], 1'b1};
            end
            //若没有进位，说明不够减，那么不减，直接移位
            else begin
                div_r <= {div_r[63:0], 1'b0};
            end
        end
    end

    assign in_error = ((X == 0) || (Y == 0));
    assign out_valid = in_error || out_valid_r;
    assign Q = div_r[31:0];
    assign R = div_r[64:33];

endmodule
