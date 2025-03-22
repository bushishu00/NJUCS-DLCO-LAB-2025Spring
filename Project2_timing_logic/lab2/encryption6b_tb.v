`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/17 16:34:51
// Design Name: 
// Module Name: encryption6b_tb
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


module encryption6b_tb(    );
// add your code
    reg clk;
    reg load;
    reg [7:0] datain;
    wire [7:0] dataout;
    wire ready;
    wire [5:0] key;
    integer i;

    // 实例�?
    encryption6b uut (
        .dataout(dataout),
        .ready(ready),
        .key(key),
        .clk(clk),
        .load(load),
        .datain(datain)
    );

    // 生成时钟信号
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10个时间单位的周期，即50%占空�?
    end

    // 测试过程
    initial begin
        // 初始化信�?
        load = 0;
        datain = 8'b01000000; // '@' 的ASCII�?
        
        // 应用复位并等待一段时�?
        #20 load = 1; // 加载初始种子
        #10 load = 0; // 停止加载
        
        // 输入�?系列数据进行加密
        for (i = 0; i < 8; i = i + 1) begin
            datain = 8'b01000000 + i; // '@' �? 'G'
            #100; // 等待6个时钟周期以确保加密完成
        end
        
        // 结束仿真
        $stop;
    end
    
    // 监控输出
    always @(posedge clk) begin
        if (ready) begin
            $display("At time %0t, Encrypted dataout = %b, Key = %b", $time, dataout, key);
        end
    end
endmodule

