`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/17 22:03:44
// Design Name: 
// Module Name: ALU32_top
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


module ALU32_top(
output [6:0] segs,           //七段数码管字形输出
output [7:0] AN,            //七段数码管显示32位运算结果 
output  [15:0] result_l,       //32位运算结果
output  zero,             //结果为0标志位
input   [3:0] data_a,           //4位数据输入，重复8次后送到ALU端口A   
input   [3:0] data_b,           //4位数据输入，重复8次后送到ALU端口B  
input   [3:0] aluctr,        //4位ALU操作控制信号
input   clk
); 
wire clk_10k;
freq_div div_u1(.clk_in(clk), .clk_out(clk_10k));
wire [31:0] dest, rsc;
wire [31:0] result;
assign dest = {8{data_a}};
assign rsc = {8{data_b}};
assign result = result_l[15:0];

ALU32 my_alu(.result(result), .zero(zero), .dataa(dest), .datab(rsc), .aluctr(aluctr));

reg [2:0] sel;
wire [6:0] seg_data [7:0];

    initial begin
        sel <= 0;
    end

    always @(posedge clk_10k) begin
        if (sel == 3'b111) begin
            sel <= 0;
        end
        else begin
            sel <= sel + 1;
        end
    end

    hex2seg seg_u1(.hex(result[3:0]), .seg(seg_data[7]));
    hex2seg seg_u2(.hex(result[7:4]), .seg(seg_data[6]));
    hex2seg seg_u3(.hex(result[11:8]), .seg(seg_data[5]));
    hex2seg seg_u4(.hex(result[15:12]), .seg(seg_data[4]));
    hex2seg seg_u5(.hex(result[19:16]), .seg(seg_data[3]));
    hex2seg seg_u6(.hex(result[23:20]), .seg(seg_data[2]));
    hex2seg seg_u7(.hex(result[27:24]), .seg(seg_data[1]));
    hex2seg seg_u8(.hex(result[31:28]), .seg(seg_data[0]));

    assign AN = (sel == 3'b000) ? 8'b11111110 :
                (sel == 3'b001) ? 8'b11111101 :
                (sel == 3'b010) ? 8'b11111011 :
                (sel == 3'b011) ? 8'b11110111 :
                (sel == 3'b100) ? 8'b11101111 :
                (sel == 3'b101) ? 8'b11011111 :
                (sel == 3'b110) ? 8'b10111111 :
                                  8'b01111111 ;
    assign segs = (sel == 3'b000) ?  seg_data[0]:
                  (sel == 3'b001) ?  seg_data[1]:
                  (sel == 3'b010) ?  seg_data[2]:
                  (sel == 3'b011) ?  seg_data[3]:
                  (sel == 3'b100) ?  seg_data[4]:
                  (sel == 3'b101) ?  seg_data[5]:
                  (sel == 3'b110) ?  seg_data[6]:
                                     seg_data[7];


endmodule


//hex转7段数码管表
module hex2seg(
    input [3:0] hex,
    output reg [6:0] seg
    );
    initial begin
        seg = 0;
    end
    always @(*) begin
        case (hex)
            4'b0000: seg = 7'b1000000; // 0
            4'b0001: seg = 7'b1111001; // 1
            4'b0010: seg = 7'b0100100; // 2
            4'b0011: seg = 7'b0110000; // 3
            4'b0100: seg = 7'b0011001; // 4
            4'b0101: seg = 7'b0010010; // 5
            4'b0110: seg = 7'b0000010; // 6
            4'b0111: seg = 7'b1111000; // 7
            4'b1000: seg = 7'b0000000; // 8
            4'b1001: seg = 7'b0010000; // 9
            4'b1010: seg = 7'b0001000; // A
            4'b1011: seg = 7'b0000011; // b
            4'b1100: seg = 7'b1000110; // C
            4'b1101: seg = 7'b0100001; // d
            4'b1110: seg = 7'b0000110; // E
            4'b1111: seg = 7'b0001110; // F
            default: seg = 7'b1111111;  // Unknown
        endcase
    end
endmodule

module freq_div 
    #(
        parameter FREQ_IN = 100000000,
        parameter FREQ_OUT = 10000
    )
    (
        input wire clk_in,
        output reg clk_out
    );
    localparam MAX_COUNT = FREQ_IN / FREQ_OUT;
    reg [31:0] cnt;

    initial begin
        cnt <= 0;
        clk_out <= 0;
    end

    always @(posedge clk_in) begin
        if (cnt == MAX_COUNT - 1) begin
            cnt <= 0;
            clk_out <= ~clk_out;
        end
        else begin
            cnt <= cnt + 1;
        end
    end
endmodule