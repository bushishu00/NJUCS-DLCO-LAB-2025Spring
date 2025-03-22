`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/17 22:02:49
// Design Name: 
// Module Name: barrelsft32
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


module barrelsft32(
      output [31:0] dout,
      input [31:0] din,
      input [4:0] shamt,     //移动位数
      input LR,           // LR=1时左移，LR=0时右移
      input AL            // AL=1时算术右移，AR=0时逻辑右移
	);
      wire d_h;
      assign d_h = AL ? din[31] : 1'b0;//算数右移，高位补充符号位，逻辑右移，高位补0

      wire [31:0] dout_0;
      wire [31:0] dout_1;
      wire [31:0] dout_2;
      wire [31:0] dout_3;

      //强制使用数据流建模???
      //x1不移位
      //x2右移n位
      //x3不移位
      //x4左移n位

      //第一级：移1位否？
      mux4to1 mux4to1_0_00(.y(dout_0[ 0]),.x1(din[ 0]),.x2(din[ 1]),.x3(din[ 0]),.x4(0),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_01(.y(dout_0[ 1]),.x1(din[ 1]),.x2(din[ 2]),.x3(din[ 1]),.x4(din[ 0]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_02(.y(dout_0[ 2]),.x1(din[ 2]),.x2(din[ 3]),.x3(din[ 2]),.x4(din[ 1]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_03(.y(dout_0[ 3]),.x1(din[ 3]),.x2(din[ 4]),.x3(din[ 3]),.x4(din[ 2]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_04(.y(dout_0[ 4]),.x1(din[ 4]),.x2(din[ 5]),.x3(din[ 4]),.x4(din[ 3]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_05(.y(dout_0[ 5]),.x1(din[ 5]),.x2(din[ 6]),.x3(din[ 5]),.x4(din[ 4]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_06(.y(dout_0[ 6]),.x1(din[ 6]),.x2(din[ 7]),.x3(din[ 6]),.x4(din[ 5]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_07(.y(dout_0[ 7]),.x1(din[ 7]),.x2(din[ 8]),.x3(din[ 7]),.x4(din[ 6]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_08(.y(dout_0[ 8]),.x1(din[ 8]),.x2(din[ 9]),.x3(din[ 8]),.x4(din[ 7]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_09(.y(dout_0[ 9]),.x1(din[ 9]),.x2(din[10]),.x3(din[ 9]),.x4(din[ 8]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_10(.y(dout_0[10]),.x1(din[10]),.x2(din[11]),.x3(din[10]),.x4(din[ 9]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_11(.y(dout_0[11]),.x1(din[11]),.x2(din[12]),.x3(din[11]),.x4(din[10]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_12(.y(dout_0[12]),.x1(din[12]),.x2(din[13]),.x3(din[12]),.x4(din[11]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_13(.y(dout_0[13]),.x1(din[13]),.x2(din[14]),.x3(din[13]),.x4(din[12]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_14(.y(dout_0[14]),.x1(din[14]),.x2(din[15]),.x3(din[14]),.x4(din[13]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_15(.y(dout_0[15]),.x1(din[15]),.x2(din[16]),.x3(din[15]),.x4(din[14]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_16(.y(dout_0[16]),.x1(din[16]),.x2(din[17]),.x3(din[16]),.x4(din[15]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_17(.y(dout_0[17]),.x1(din[17]),.x2(din[18]),.x3(din[17]),.x4(din[16]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_18(.y(dout_0[18]),.x1(din[18]),.x2(din[19]),.x3(din[18]),.x4(din[17]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_19(.y(dout_0[19]),.x1(din[19]),.x2(din[20]),.x3(din[19]),.x4(din[18]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_20(.y(dout_0[20]),.x1(din[20]),.x2(din[21]),.x3(din[20]),.x4(din[19]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_21(.y(dout_0[21]),.x1(din[21]),.x2(din[22]),.x3(din[21]),.x4(din[20]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_22(.y(dout_0[22]),.x1(din[22]),.x2(din[23]),.x3(din[22]),.x4(din[21]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_23(.y(dout_0[23]),.x1(din[23]),.x2(din[24]),.x3(din[23]),.x4(din[22]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_24(.y(dout_0[24]),.x1(din[24]),.x2(din[25]),.x3(din[24]),.x4(din[23]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_25(.y(dout_0[25]),.x1(din[25]),.x2(din[26]),.x3(din[25]),.x4(din[24]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_26(.y(dout_0[26]),.x1(din[26]),.x2(din[27]),.x3(din[26]),.x4(din[25]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_27(.y(dout_0[27]),.x1(din[27]),.x2(din[28]),.x3(din[27]),.x4(din[26]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_28(.y(dout_0[28]),.x1(din[28]),.x2(din[29]),.x3(din[28]),.x4(din[27]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_29(.y(dout_0[29]),.x1(din[29]),.x2(din[30]),.x3(din[29]),.x4(din[28]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_30(.y(dout_0[30]),.x1(din[30]),.x2(din[31]),.x3(din[30]),.x4(din[29]),.sel({LR,shamt[0]}));
      mux4to1 mux4to1_0_31(.y(dout_0[31]),.x1(din[31]),.x2(  d_h  ),.x3(din[31]),.x4(din[30]),.sel({LR,shamt[0]}));

      //第二级：移2位否？
      mux4to1 mux4to1_1_00(.y(dout_1[ 0]),.x1(dout_0[ 0]),.x2(dout_0[ 2]),.x3(dout_0[ 0]),.x4(0),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_01(.y(dout_1[ 1]),.x1(dout_0[ 1]),.x2(dout_0[ 3]),.x3(dout_0[ 1]),.x4(0),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_02(.y(dout_1[ 2]),.x1(dout_0[ 2]),.x2(dout_0[ 4]),.x3(dout_0[ 2]),.x4(dout_0[ 0]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_03(.y(dout_1[ 3]),.x1(dout_0[ 3]),.x2(dout_0[ 5]),.x3(dout_0[ 3]),.x4(dout_0[ 1]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_04(.y(dout_1[ 4]),.x1(dout_0[ 4]),.x2(dout_0[ 6]),.x3(dout_0[ 4]),.x4(dout_0[ 2]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_05(.y(dout_1[ 5]),.x1(dout_0[ 5]),.x2(dout_0[ 7]),.x3(dout_0[ 5]),.x4(dout_0[ 3]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_06(.y(dout_1[ 6]),.x1(dout_0[ 6]),.x2(dout_0[ 8]),.x3(dout_0[ 6]),.x4(dout_0[ 4]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_07(.y(dout_1[ 7]),.x1(dout_0[ 7]),.x2(dout_0[ 9]),.x3(dout_0[ 7]),.x4(dout_0[ 5]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_08(.y(dout_1[ 8]),.x1(dout_0[ 8]),.x2(dout_0[10]),.x3(dout_0[ 8]),.x4(dout_0[ 6]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_09(.y(dout_1[ 9]),.x1(dout_0[ 9]),.x2(dout_0[11]),.x3(dout_0[ 9]),.x4(dout_0[ 7]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_10(.y(dout_1[10]),.x1(dout_0[10]),.x2(dout_0[12]),.x3(dout_0[10]),.x4(dout_0[ 8]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_11(.y(dout_1[11]),.x1(dout_0[11]),.x2(dout_0[13]),.x3(dout_0[11]),.x4(dout_0[ 9]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_12(.y(dout_1[12]),.x1(dout_0[12]),.x2(dout_0[14]),.x3(dout_0[12]),.x4(dout_0[10]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_13(.y(dout_1[13]),.x1(dout_0[13]),.x2(dout_0[15]),.x3(dout_0[13]),.x4(dout_0[11]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_14(.y(dout_1[14]),.x1(dout_0[14]),.x2(dout_0[16]),.x3(dout_0[14]),.x4(dout_0[12]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_15(.y(dout_1[15]),.x1(dout_0[15]),.x2(dout_0[17]),.x3(dout_0[15]),.x4(dout_0[13]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_16(.y(dout_1[16]),.x1(dout_0[16]),.x2(dout_0[18]),.x3(dout_0[16]),.x4(dout_0[14]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_17(.y(dout_1[17]),.x1(dout_0[17]),.x2(dout_0[19]),.x3(dout_0[17]),.x4(dout_0[15]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_18(.y(dout_1[18]),.x1(dout_0[18]),.x2(dout_0[20]),.x3(dout_0[18]),.x4(dout_0[16]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_19(.y(dout_1[19]),.x1(dout_0[19]),.x2(dout_0[21]),.x3(dout_0[19]),.x4(dout_0[17]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_20(.y(dout_1[20]),.x1(dout_0[20]),.x2(dout_0[22]),.x3(dout_0[20]),.x4(dout_0[18]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_21(.y(dout_1[21]),.x1(dout_0[21]),.x2(dout_0[23]),.x3(dout_0[21]),.x4(dout_0[19]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_22(.y(dout_1[22]),.x1(dout_0[22]),.x2(dout_0[24]),.x3(dout_0[22]),.x4(dout_0[20]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_23(.y(dout_1[23]),.x1(dout_0[23]),.x2(dout_0[25]),.x3(dout_0[23]),.x4(dout_0[21]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_24(.y(dout_1[24]),.x1(dout_0[24]),.x2(dout_0[26]),.x3(dout_0[24]),.x4(dout_0[22]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_25(.y(dout_1[25]),.x1(dout_0[25]),.x2(dout_0[27]),.x3(dout_0[25]),.x4(dout_0[23]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_26(.y(dout_1[26]),.x1(dout_0[26]),.x2(dout_0[28]),.x3(dout_0[26]),.x4(dout_0[24]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_27(.y(dout_1[27]),.x1(dout_0[27]),.x2(dout_0[29]),.x3(dout_0[27]),.x4(dout_0[25]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_28(.y(dout_1[28]),.x1(dout_0[28]),.x2(dout_0[30]),.x3(dout_0[28]),.x4(dout_0[26]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_29(.y(dout_1[29]),.x1(dout_0[29]),.x2(dout_0[31]),.x3(dout_0[29]),.x4(dout_0[27]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_30(.y(dout_1[30]),.x1(dout_0[30]),.x2(   d_h    ),.x3(dout_0[30]),.x4(dout_0[28]),.sel({LR,shamt[1]}));
      mux4to1 mux4to1_1_31(.y(dout_1[31]),.x1(dout_0[31]),.x2(   d_h    ),.x3(dout_0[31]),.x4(dout_0[29]),.sel({LR,shamt[1]}));

      //第三级：移4位否？
      mux4to1 mux4to1_2_00(.y(dout_2[ 0]),.x1(dout_1[ 0]),.x2(dout_1[ 4]),.x3(dout_1[ 0]),.x4(0),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_01(.y(dout_2[ 1]),.x1(dout_1[ 1]),.x2(dout_1[ 5]),.x3(dout_1[ 1]),.x4(0),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_02(.y(dout_2[ 2]),.x1(dout_1[ 2]),.x2(dout_1[ 6]),.x3(dout_1[ 2]),.x4(0),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_03(.y(dout_2[ 3]),.x1(dout_1[ 3]),.x2(dout_1[ 7]),.x3(dout_1[ 3]),.x4(0),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_04(.y(dout_2[ 4]),.x1(dout_1[ 4]),.x2(dout_1[ 8]),.x3(dout_1[ 4]),.x4(dout_1[ 0]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_05(.y(dout_2[ 5]),.x1(dout_1[ 5]),.x2(dout_1[ 9]),.x3(dout_1[ 5]),.x4(dout_1[ 1]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_06(.y(dout_2[ 6]),.x1(dout_1[ 6]),.x2(dout_1[10]),.x3(dout_1[ 6]),.x4(dout_1[ 2]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_07(.y(dout_2[ 7]),.x1(dout_1[ 7]),.x2(dout_1[11]),.x3(dout_1[ 7]),.x4(dout_1[ 3]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_08(.y(dout_2[ 8]),.x1(dout_1[ 8]),.x2(dout_1[12]),.x3(dout_1[ 8]),.x4(dout_1[ 4]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_09(.y(dout_2[ 9]),.x1(dout_1[ 9]),.x2(dout_1[13]),.x3(dout_1[ 9]),.x4(dout_1[ 5]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_10(.y(dout_2[10]),.x1(dout_1[10]),.x2(dout_1[14]),.x3(dout_1[10]),.x4(dout_1[ 6]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_11(.y(dout_2[11]),.x1(dout_1[11]),.x2(dout_1[15]),.x3(dout_1[11]),.x4(dout_1[ 7]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_12(.y(dout_2[12]),.x1(dout_1[12]),.x2(dout_1[16]),.x3(dout_1[12]),.x4(dout_1[ 8]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_13(.y(dout_2[13]),.x1(dout_1[13]),.x2(dout_1[17]),.x3(dout_1[13]),.x4(dout_1[ 9]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_14(.y(dout_2[14]),.x1(dout_1[14]),.x2(dout_1[18]),.x3(dout_1[14]),.x4(dout_1[10]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_15(.y(dout_2[15]),.x1(dout_1[15]),.x2(dout_1[19]),.x3(dout_1[15]),.x4(dout_1[11]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_16(.y(dout_2[16]),.x1(dout_1[16]),.x2(dout_1[20]),.x3(dout_1[16]),.x4(dout_1[12]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_17(.y(dout_2[17]),.x1(dout_1[17]),.x2(dout_1[21]),.x3(dout_1[17]),.x4(dout_1[13]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_18(.y(dout_2[18]),.x1(dout_1[18]),.x2(dout_1[22]),.x3(dout_1[18]),.x4(dout_1[14]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_19(.y(dout_2[19]),.x1(dout_1[19]),.x2(dout_1[23]),.x3(dout_1[19]),.x4(dout_1[15]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_20(.y(dout_2[20]),.x1(dout_1[20]),.x2(dout_1[24]),.x3(dout_1[20]),.x4(dout_1[16]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_21(.y(dout_2[21]),.x1(dout_1[21]),.x2(dout_1[25]),.x3(dout_1[21]),.x4(dout_1[17]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_22(.y(dout_2[22]),.x1(dout_1[22]),.x2(dout_1[26]),.x3(dout_1[22]),.x4(dout_1[18]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_23(.y(dout_2[23]),.x1(dout_1[23]),.x2(dout_1[27]),.x3(dout_1[23]),.x4(dout_1[19]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_24(.y(dout_2[24]),.x1(dout_1[24]),.x2(dout_1[28]),.x3(dout_1[24]),.x4(dout_1[20]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_25(.y(dout_2[25]),.x1(dout_1[25]),.x2(dout_1[29]),.x3(dout_1[25]),.x4(dout_1[21]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_26(.y(dout_2[26]),.x1(dout_1[26]),.x2(dout_1[30]),.x3(dout_1[26]),.x4(dout_1[22]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_27(.y(dout_2[27]),.x1(dout_1[27]),.x2(dout_1[31]),.x3(dout_1[27]),.x4(dout_1[23]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_28(.y(dout_2[28]),.x1(dout_1[28]),.x2(   d_h    ),.x3(dout_1[28]),.x4(dout_1[24]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_29(.y(dout_2[29]),.x1(dout_1[29]),.x2(   d_h    ),.x3(dout_1[29]),.x4(dout_1[25]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_30(.y(dout_2[30]),.x1(dout_1[30]),.x2(   d_h    ),.x3(dout_1[30]),.x4(dout_1[26]),.sel({LR,shamt[2]}));
      mux4to1 mux4to1_2_31(.y(dout_2[31]),.x1(dout_1[31]),.x2(   d_h    ),.x3(dout_1[31]),.x4(dout_1[27]),.sel({LR,shamt[2]}));

      //第四级：移8位否？
      mux4to1 mux4to1_3_00(.y(dout_3[ 0]),.x1(dout_2[ 0]),.x2(dout_2[ 8]),.x3(dout_2[ 0]),.x4(0),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_01(.y(dout_3[ 1]),.x1(dout_2[ 1]),.x2(dout_2[ 9]),.x3(dout_2[ 1]),.x4(0),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_02(.y(dout_3[ 2]),.x1(dout_2[ 2]),.x2(dout_2[10]),.x3(dout_2[ 2]),.x4(0),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_03(.y(dout_3[ 3]),.x1(dout_2[ 3]),.x2(dout_2[11]),.x3(dout_2[ 3]),.x4(0),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_04(.y(dout_3[ 4]),.x1(dout_2[ 4]),.x2(dout_2[12]),.x3(dout_2[ 4]),.x4(0),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_05(.y(dout_3[ 5]),.x1(dout_2[ 5]),.x2(dout_2[13]),.x3(dout_2[ 5]),.x4(0),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_06(.y(dout_3[ 6]),.x1(dout_2[ 6]),.x2(dout_2[14]),.x3(dout_2[ 6]),.x4(0),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_07(.y(dout_3[ 7]),.x1(dout_2[ 7]),.x2(dout_2[15]),.x3(dout_2[ 7]),.x4(0),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_08(.y(dout_3[ 8]),.x1(dout_2[ 8]),.x2(dout_2[16]),.x3(dout_2[ 8]),.x4(dout_2[ 0]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_09(.y(dout_3[ 9]),.x1(dout_2[ 9]),.x2(dout_2[17]),.x3(dout_2[ 9]),.x4(dout_2[ 1]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_10(.y(dout_3[10]),.x1(dout_2[10]),.x2(dout_2[18]),.x3(dout_2[10]),.x4(dout_2[ 2]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_11(.y(dout_3[11]),.x1(dout_2[11]),.x2(dout_2[19]),.x3(dout_2[11]),.x4(dout_2[ 3]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_12(.y(dout_3[12]),.x1(dout_2[12]),.x2(dout_2[20]),.x3(dout_2[12]),.x4(dout_2[ 4]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_13(.y(dout_3[13]),.x1(dout_2[13]),.x2(dout_2[21]),.x3(dout_2[13]),.x4(dout_2[ 5]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_14(.y(dout_3[14]),.x1(dout_2[14]),.x2(dout_2[22]),.x3(dout_2[14]),.x4(dout_2[ 6]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_15(.y(dout_3[15]),.x1(dout_2[15]),.x2(dout_2[23]),.x3(dout_2[15]),.x4(dout_2[ 7]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_16(.y(dout_3[16]),.x1(dout_2[16]),.x2(dout_2[24]),.x3(dout_2[16]),.x4(dout_2[ 8]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_17(.y(dout_3[17]),.x1(dout_2[17]),.x2(dout_2[25]),.x3(dout_2[17]),.x4(dout_2[ 9]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_18(.y(dout_3[18]),.x1(dout_2[18]),.x2(dout_2[26]),.x3(dout_2[18]),.x4(dout_2[10]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_19(.y(dout_3[19]),.x1(dout_2[19]),.x2(dout_2[27]),.x3(dout_2[19]),.x4(dout_2[11]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_20(.y(dout_3[20]),.x1(dout_2[20]),.x2(dout_2[28]),.x3(dout_2[20]),.x4(dout_2[12]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_21(.y(dout_3[21]),.x1(dout_2[21]),.x2(dout_2[29]),.x3(dout_2[21]),.x4(dout_2[13]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_22(.y(dout_3[22]),.x1(dout_2[22]),.x2(dout_2[30]),.x3(dout_2[22]),.x4(dout_2[14]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_23(.y(dout_3[23]),.x1(dout_2[23]),.x2(dout_2[31]),.x3(dout_2[23]),.x4(dout_2[15]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_24(.y(dout_3[24]),.x1(dout_2[24]),.x2(    d_h   ),.x3(dout_2[24]),.x4(dout_2[16]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_25(.y(dout_3[25]),.x1(dout_2[25]),.x2(    d_h   ),.x3(dout_2[25]),.x4(dout_2[17]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_26(.y(dout_3[26]),.x1(dout_2[26]),.x2(    d_h   ),.x3(dout_2[26]),.x4(dout_2[18]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_27(.y(dout_3[27]),.x1(dout_2[27]),.x2(    d_h   ),.x3(dout_2[27]),.x4(dout_2[19]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_28(.y(dout_3[28]),.x1(dout_2[28]),.x2(    d_h   ),.x3(dout_2[28]),.x4(dout_2[20]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_29(.y(dout_3[29]),.x1(dout_2[29]),.x2(    d_h   ),.x3(dout_2[29]),.x4(dout_2[21]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_30(.y(dout_3[30]),.x1(dout_2[30]),.x2(    d_h   ),.x3(dout_2[30]),.x4(dout_2[22]),.sel({LR,shamt[3]}));
      mux4to1 mux4to1_3_31(.y(dout_3[31]),.x1(dout_2[31]),.x2(    d_h   ),.x3(dout_2[31]),.x4(dout_2[23]),.sel({LR,shamt[3]}));

      //第五级：移16位否？
      mux4to1 mux4to1_4_00(.y(dout[ 0]),.x1(dout_3[ 0]),.x2(dout_3[16]),.x3(dout_3[ 0]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_01(.y(dout[ 1]),.x1(dout_3[ 1]),.x2(dout_3[17]),.x3(dout_3[ 1]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_02(.y(dout[ 2]),.x1(dout_3[ 2]),.x2(dout_3[18]),.x3(dout_3[ 2]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_03(.y(dout[ 3]),.x1(dout_3[ 3]),.x2(dout_3[19]),.x3(dout_3[ 3]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_04(.y(dout[ 4]),.x1(dout_3[ 4]),.x2(dout_3[20]),.x3(dout_3[ 4]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_05(.y(dout[ 5]),.x1(dout_3[ 5]),.x2(dout_3[21]),.x3(dout_3[ 5]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_06(.y(dout[ 6]),.x1(dout_3[ 6]),.x2(dout_3[22]),.x3(dout_3[ 6]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_07(.y(dout[ 7]),.x1(dout_3[ 7]),.x2(dout_3[23]),.x3(dout_3[ 7]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_08(.y(dout[ 8]),.x1(dout_3[ 8]),.x2(dout_3[24]),.x3(dout_3[ 8]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_09(.y(dout[ 9]),.x1(dout_3[ 9]),.x2(dout_3[25]),.x3(dout_3[ 9]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_10(.y(dout[10]),.x1(dout_3[10]),.x2(dout_3[26]),.x3(dout_3[10]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_11(.y(dout[11]),.x1(dout_3[11]),.x2(dout_3[27]),.x3(dout_3[11]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_12(.y(dout[12]),.x1(dout_3[12]),.x2(dout_3[28]),.x3(dout_3[12]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_13(.y(dout[13]),.x1(dout_3[13]),.x2(dout_3[29]),.x3(dout_3[13]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_14(.y(dout[14]),.x1(dout_3[14]),.x2(dout_3[30]),.x3(dout_3[14]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_15(.y(dout[15]),.x1(dout_3[15]),.x2(dout_3[31]),.x3(dout_3[15]),.x4(0),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_16(.y(dout[16]),.x1(dout_3[16]),.x2(   d_h   ),.x3(dout_3[16]),.x4(dout_3[ 0]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_17(.y(dout[17]),.x1(dout_3[17]),.x2(   d_h   ),.x3(dout_3[17]),.x4(dout_3[ 1]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_18(.y(dout[18]),.x1(dout_3[18]),.x2(   d_h   ),.x3(dout_3[18]),.x4(dout_3[ 2]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_19(.y(dout[19]),.x1(dout_3[19]),.x2(   d_h   ),.x3(dout_3[19]),.x4(dout_3[ 3]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_20(.y(dout[20]),.x1(dout_3[20]),.x2(   d_h   ),.x3(dout_3[20]),.x4(dout_3[ 4]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_21(.y(dout[21]),.x1(dout_3[21]),.x2(   d_h   ),.x3(dout_3[21]),.x4(dout_3[ 5]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_22(.y(dout[22]),.x1(dout_3[22]),.x2(   d_h   ),.x3(dout_3[22]),.x4(dout_3[ 6]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_23(.y(dout[23]),.x1(dout_3[23]),.x2(   d_h   ),.x3(dout_3[23]),.x4(dout_3[ 7]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_24(.y(dout[24]),.x1(dout_3[24]),.x2(   d_h   ),.x3(dout_3[24]),.x4(dout_3[ 8]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_25(.y(dout[25]),.x1(dout_3[25]),.x2(   d_h   ),.x3(dout_3[25]),.x4(dout_3[ 9]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_26(.y(dout[26]),.x1(dout_3[26]),.x2(   d_h   ),.x3(dout_3[26]),.x4(dout_3[10]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_27(.y(dout[27]),.x1(dout_3[27]),.x2(   d_h   ),.x3(dout_3[27]),.x4(dout_3[11]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_28(.y(dout[28]),.x1(dout_3[28]),.x2(   d_h   ),.x3(dout_3[28]),.x4(dout_3[12]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_29(.y(dout[29]),.x1(dout_3[29]),.x2(   d_h   ),.x3(dout_3[29]),.x4(dout_3[13]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_30(.y(dout[30]),.x1(dout_3[30]),.x2(   d_h   ),.x3(dout_3[30]),.x4(dout_3[14]),.sel({LR,shamt[4]}));
      mux4to1 mux4to1_4_31(.y(dout[31]),.x1(dout_3[31]),.x2(   d_h   ),.x3(dout_3[31]),.x4(dout_3[15]),.sel({LR,shamt[4]}));
endmodule


module mux4to1(
      output y,
      input x1,x2,x3,x4,
      input [1:0] sel
      );
      assign y = (sel==2'b00)?x1:((sel==2'b01)?x2:((sel==2'b10)?x3:x4));
endmodule