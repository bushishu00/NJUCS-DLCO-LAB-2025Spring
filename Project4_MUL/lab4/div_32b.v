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
    output  [31:0] Q,          //商
    output  [31:0] R,          //余数
    output out_valid,        //除法运算结束时，输出为1
    output in_error,         //被除数或除数为0时，输出为1
    input clk,               //时钟 
    input rst,             //复位信号
    input [31:0] X,           //被除数
    input [31:0] Y,           //除数
    input in_valid          //输入为1时，表示数据就绪，开始除法运算
);
    reg [5:0] cnt;
    reg out_valid_rem;//r代表余数完成
    reg out_valid_quo;//q代表商完成
    always @(posedge clk) begin
        if (rst) begin
            cnt <= 0;
            out_valid_rem <= 0;
        end
        else if (in_valid) begin
            cnt <= 32;
            out_valid_rem <= 0;
        end
        else if (cnt != 0) begin
            cnt <= cnt - 1;
        end
        else begin
            out_valid_rem <= 1;
        end
    end
    //商比余数慢一拍
    always @(posedge clk) begin
        if (rst) begin
            out_valid_quo <= 0;
        end
        else if (in_valid) begin
            out_valid_quo <= 0;
        end
        else begin
            out_valid_quo <= out_valid_rem;
        end
    end

    reg [64:0] div_r;//高32位补0，低32位为被除数
    reg [31:0] quote_r;
    wire [31:0] diff_res;
    wire [31:0] y_in;
    wire sign_x, sign_y, sign_r;

    assign sign_x = X[31];
    assign sign_y = Y[31];
    assign sign_r = div_r[64];//最初，余数的符号位与被除数的符号位相同
    assign y_in = sign_r == sign_y ? ~Y + 1 : Y; //同号相减，异号相加

    Adder32 my_adder(.f(diff_res),
                    .cout(),
                    .x(div_r[63:32]),
                    .y(y_in),
                    .sub(1'b0));

    always @(posedge clk) begin
        if (rst) begin
            div_r <= 0;
            quote_r <= 0;
        end
        else if (in_valid) begin
            div_r <= {{33{sign_x}}, X};//符号扩展
            quote_r <= 0;
        end
        else if (!out_valid_rem) begin
            div_r <= {diff_res[31:0], div_r[31:0], sign_r == sign_y ? 1'b1 : 1'b0};
        end
        else if (!out_valid_quo) begin
            quote_r <= {div_r[30:0], sign_r == sign_y ? 1'b1 : 1'b0};
        end
    end
    
    assign in_error = ((X == 0) || (Y == 0));
    assign out_valid = in_error || (out_valid_rem&&out_valid_quo);
    assign Q = (sign_x == sign_y) ? quote_r : quote_r + 1'b1;
    assign R = (sign_r == sign_x) ? div_r[64:33] :
               (sign_x == sign_y) ? div_r[64:33] + Y : div_r[64:33] - Y;


endmodule
