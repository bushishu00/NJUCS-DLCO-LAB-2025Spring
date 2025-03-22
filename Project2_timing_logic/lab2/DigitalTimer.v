module DigitalTimer (    //端口声明
        input clk,            //连接到时钟端口CLK100MHZ，引脚E3
        input RST,             //复位按钮，单击有效
        input StartOrPause,      //计时器开始或暂停，单击1次开始，再按1次暂停
        input ReadPara,         //读取参数，当参数设置结束后，单击1次，读取数据
        input TimeFormat,       //=0表示24小时制，=1表示12小时制
        input [1:0] mode,        //功能选择，00数字时钟，01倒计时，10计时器，11设置闹钟
        input [1:0] ParaSelect,     // 参数设置，00无；01设置秒数；10设置分钟；11设置小时
        input [1:0] AlarmNo,      // 闹钟序号，0~3
        input [3:0] data_h,        //设置参数高位，使用BCD码表示
        input [3:0] data_l,         //设置参数低位，使用BCD码表示
        output  Afternoon,       //12小时制时，下午时间输出为1
        output [2:0] TimeKeeper,    //整点输出3色指示灯
        output [2:0] AlarmDisplay,   //闹钟输出3色指示灯
        output [6:0] segs,           //七段数码管输入值，显示数字
        output [7:0] an             //七段数码管控制位，控制时、分、秒 
    ); 
//分频
    wire clk_100Hz;
    wire clk_10k;
    //为了仿真方便，此处全部改为了10MHz
    freq_div #(.FREQ_IN(100000000), .FREQ_OUT(100)) div_u1(.clk_in(clk), .clk_out(clk_100Hz));
    freq_div #(.FREQ_IN(100000000), .FREQ_OUT(10000)) div_u2(.clk_in(clk), .clk_out(clk_10k));
    
//总控信号：0代表暂停，1代表时间流动
    reg RunorSet;
    initial begin
        RunorSet <= 0;
    end
    always @(posedge clk_100Hz) begin
        if (RST) begin
            RunorSet <= 0;
        end
        else begin//状态机简化
            if (mode == 2'b11) begin
                RunorSet <= 0;
            end
            else begin
                if (ReadPara) begin//每次配置后
                    RunorSet <= 0;
                end
                else if (StartOrPause) begin//按下暂停
                    RunorSet <= ~ RunorSet;
                end
            end
        end
    end

//设置闹铃
    reg [7:0] time_alarm_0 [3:0];
    reg [7:0] time_alarm_1 [3:0];
    reg [7:0] time_alarm_2 [3:0];
    reg [7:0] time_alarm_3 [3:0];

    always @(posedge clk_100Hz) begin
        if (mode == 2'b11) begin
            if (ReadPara) begin
                case (AlarmNo)
                    2'b00: begin
                        case (ParaSelect)
                            2'b00: begin
                                time_alarm_0[0] <= {data_h, data_l};
                            end
                            2'b01: begin
                                time_alarm_0[1] <= {data_h, data_l};
                            end
                            2'b10: begin
                                time_alarm_0[2] <= {data_h, data_l};
                            end
                            2'b11: begin
                                time_alarm_0[3] <= {data_h, data_l};
                            end
                        endcase
                    end
                    2'b01: begin
                        case (ParaSelect)
                            2'b00: begin
                                time_alarm_1[0] <= {data_h, data_l};
                            end
                            2'b01: begin
                                time_alarm_1[1] <= {data_h, data_l};
                            end
                            2'b10: begin
                                time_alarm_1[2] <= {data_h, data_l};
                            end
                            2'b11: begin
                                time_alarm_1[3] <= {data_h, data_l};
                            end
                        endcase
                    end
                    2'b10: begin
                        case (ParaSelect)
                            2'b00: begin
                                time_alarm_2[0] <= {data_h, data_l};
                            end
                            2'b01: begin
                                time_alarm_2[1] <= {data_h, data_l};
                            end
                            2'b10: begin
                                time_alarm_2[2] <= {data_h, data_l};
                            end
                            2'b11: begin
                                time_alarm_2[3] <= {data_h, data_l};
                            end
                        endcase
                    end
                    2'b11: begin
                        case (ParaSelect)
                            2'b00: begin
                                time_alarm_3[0] <= {data_h, data_l};
                            end
                            2'b01: begin
                                time_alarm_3[1] <= {data_h, data_l};
                            end
                            2'b10: begin
                                time_alarm_3[2] <= {data_h, data_l};
                            end
                            2'b11: begin
                                time_alarm_3[3] <= {data_h, data_l};
                            end
                        endcase
                    end
                endcase
            end
        end
    end
//配置输出时钟
    wire rco_mms, rco_sec, rco_min, rco_hour;
    wire [3:0] mms_l, mms_h, sec_l, sec_h, min_l, min_h, hour_l, hour_h;
    
    counter_100 counter_100_mms(
        .clk(clk_100Hz),
        .rst(RST),
        .load(ReadPara && (ParaSelect == 2'b00)),
        .en(RunorSet),
        .mode(mode == 2'b01),
        .cnt_set((mode==2'b10)?0:{data_h, data_l}),
        .cnt_out({mms_h, mms_l}),
        .rco(rco_mms)
    );
    counter_60 counter_60_sec(
        .clk(clk_100Hz),
        .rst(RST),
        .load(ReadPara && (ParaSelect == 2'b01)),
        .en(rco_mms && RunorSet),
        .mode(mode == 2'b01),
        .cnt_set((mode==2'b10)?0:{data_h, data_l}),
        .cnt_out({sec_h, sec_l}),
        .rco(rco_sec)
    );
    counter_60 counter_60_min(
        .clk(clk_100Hz),
        .rst(RST),
        .load(ReadPara && (ParaSelect == 2'b10)),
        .en(rco_sec && RunorSet),
        .mode(mode == 2'b01),
        .cnt_set((mode==2'b10)?0:{data_h, data_l}),
        .cnt_out({min_h, min_l}),
        .rco(rco_min)
    );
    counter_24 counter_24_hour(
        .clk(clk_100Hz),
        .rst(RST),
        .load(ReadPara && (ParaSelect == 2'b11)),
        .en(rco_min && RunorSet),
        .mode(mode == 2'b01),
        .TimeFormat(TimeFormat),
        .cnt_set((mode==2'b10)?0:{data_h, data_l}),
        .cnt_out({hour_h, hour_l}),
        .rco(rco_hour)
    );

//设置标志位
    reg alarm_flag;//闹铃标志
    reg Afternoon_r;//下午标志
    reg TimeKeeper_flag;//整点标志
    reg cnt_done_flag;//倒计时结束标志
    initial begin
        alarm_flag <= 0;
        Afternoon_r <= 0;
        TimeKeeper_flag <= 0;
        cnt_done_flag <= 0;
    end
    always @(posedge clk_100Hz) begin
        if (RST) begin
            alarm_flag <= 0;
            Afternoon_r <= 0;
            TimeKeeper_flag <= 0;
            cnt_done_flag <= 0;
        end
        else begin
            if (mode == 2'b00) begin//正常的时钟下闹钟、下午、整点报时
                //闹钟标志
                if (((time_alarm_0[0] == {mms_h, mms_l}) && (time_alarm_0[1] == {sec_h, sec_l}) && (time_alarm_0[2] == {min_h, min_l}) && (time_alarm_0[3] == {hour_h, hour_l})) ||
                    ((time_alarm_1[0] == {mms_h, mms_l}) && (time_alarm_1[1] == {sec_h, sec_l}) && (time_alarm_1[2] == {min_h, min_l}) && (time_alarm_1[3] == {hour_h, hour_l})) ||
                    ((time_alarm_2[0] == {mms_h, mms_l}) && (time_alarm_2[1] == {sec_h, sec_l}) && (time_alarm_2[2] == {min_h, min_l}) && (time_alarm_2[3] == {hour_h, hour_l})) ||
                    ((time_alarm_3[0] == {mms_h, mms_l}) && (time_alarm_3[1] == {sec_h, sec_l}) && (time_alarm_3[2] == {min_h, min_l}) && (time_alarm_3[3] == {hour_h, hour_l}))) begin//任意一个时钟到了
                    alarm_flag <= 1;
                end
                else begin
                    alarm_flag <= 0;
                end
                //下午标志
                if (TimeFormat) begin//小时进位代表12h结束
                    Afternoon_r <= rco_hour ? ~Afternoon_r : Afternoon_r;
                end
                else begin
                    Afternoon_r <= 0;
                end
                //整点标志
                if (rco_min) begin//整点代表分钟进位
                    TimeKeeper_flag <= 1;
                end
                else begin
                    TimeKeeper_flag <= 0;
                end
            end
            else if (mode == 2'b01) begin//倒计时结束标志
                if (({mms_h, mms_l} == 0)&&({sec_h, sec_l} == 0)&&({min_h, min_l} == 0)&&({hour_h, hour_l} == 0)) begin
                    cnt_done_flag <= 1;
                end
                else begin
                    cnt_done_flag <= 0;
                end
            end
        end
    end

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

    hex2seg seg_u1(.hex(hour_h), .seg(seg_data[7]));
    hex2seg seg_u2(.hex(hour_l), .seg(seg_data[6]));
    hex2seg seg_u3(.hex(min_h), .seg(seg_data[5]));
    hex2seg seg_u4(.hex(min_l), .seg(seg_data[4]));
    hex2seg seg_u5(.hex(sec_h), .seg(seg_data[3]));
    hex2seg seg_u6(.hex(sec_l), .seg(seg_data[2]));
    hex2seg seg_u7(.hex(mms_h), .seg(seg_data[1]));
    hex2seg seg_u8(.hex(mms_l), .seg(seg_data[0]));

    assign an = (sel == 3'b000) ? 8'b11111110 :
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
    assign Afternoon = Afternoon_r;

    wire red_flag;
    wire green_flag;
    assign red_flag = alarm_flag | cnt_done_flag;
    assign green_flag = TimeKeeper_flag;
    shine_per_sec #(.TIME(5), .COLOR(3'b010)) shine_u1(.clk_100Hz(clk_100Hz), .rst(RST), .flag(green_flag), .led(TimeKeeper));
    shine_per_sec #(.TIME(5), .COLOR(3'b100)) shine_u2(.clk_100Hz(clk_100Hz), .rst(RST), .flag(red_flag), .led(AlarmDisplay));
endmodule

/********************************************************************
子模块
*********************************************************************/
//模60计数器模块
module counter_60(
    input clk,
    input rst,
    input load,
    input en,
    input [1:0] mode,//正向or反向
    input [7:0] cnt_set,
    output reg [7:0] cnt_out,
    output reg rco 
    );
    always @(posedge clk) begin
        if (rst) begin//复位归零
            cnt_out <= 0;
            rco     <= 0;
        end
        else if (load || mode == 2'b11) begin//置数
            cnt_out <= cnt_set;
        end
        else if (en) begin
            if (mode == 2'b00 || mode == 2'b10) begin//正计时
                if (cnt_out[7:4] == 5 && cnt_out[3:0] == 9) begin//计满
                    cnt_out <= 0;
                    rco     <= 1;
                end
                else begin
                    rco     <= 0;
                    if (cnt_out[3:0] == 9) begin//低位计满
                        cnt_out[3:0] <= 0;
                        cnt_out[7:4] <= cnt_out[7:4] + 1;
                    end
                    else begin
                        cnt_out[3:0] <= cnt_out[3:0] + 1;
                    end
                end
            end
            else if (mode == 2'b01) begin//倒计时
                if (cnt_out == 0) begin//计满
                    cnt_out <= {4'b0101, 4'b1001};
                    rco     <= 1;
                end
                else begin
                    rco     <= 0;
                    if (cnt_out[3:0] == 0) begin//低位计满
                        cnt_out[3:0] <= 9;
                        cnt_out[7:4] <= cnt_out[7:4] - 1;
                    end
                    else begin
                        cnt_out[3:0] <= cnt_out[3:0] - 1;
                    end
                end
            end
        end
        else begin
            rco <= 0;
        end
    end
endmodule

//模100计数器模块
module counter_100(
    input clk,
    input rst,
    input load,
    input en,
    input [1:0] mode,//正向or反向
    input [7:0] cnt_set,
    output reg [7:0] cnt_out,
    output reg rco 
    );
    always @(posedge clk) begin
        if (rst) begin//复位归零
            cnt_out <= 0;
            rco     <= 0;
        end
        else if (load || mode == 2'b11) begin//置数
            cnt_out <= cnt_set;
        end
        else if (en) begin
            if (mode == 2'b00 || mode == 2'b10) begin//正计时
                if (cnt_out[7:4] == 9 && cnt_out[3:0] == 9) begin//计满
                    cnt_out <= 0;
                    rco     <= 1;
                end
                else begin
                    rco     <= 0;
                    if (cnt_out[3:0] == 9) begin//低位计满
                        cnt_out[3:0] <= 0;
                        cnt_out[7:4] <= cnt_out[7:4] + 1;
                    end
                    else begin
                        cnt_out[3:0] <= cnt_out[3:0] + 1;
                    end
                end
            end
            else if (mode == 2'b01) begin//倒计时
                if (cnt_out == 0) begin//计满
                    cnt_out <= {4'b1001, 4'b1001};
                    rco     <= 1;
                end
                else begin
                    rco     <= 0;
                    if (cnt_out[3:0] == 0) begin//低位计满
                        cnt_out[3:0] <= 9;
                        cnt_out[7:4] <= cnt_out[7:4] - 1;
                    end
                    else begin
                        cnt_out[3:0] <= cnt_out[3:0] - 1;
                    end
                end
            end
        end
        else begin
            rco <= 0;
        end
    end
endmodule

//小时计数器模块
module counter_24(
    input clk,
    input rst,
    input load,
    input en,
    input [1:0] mode,//正向or反向
    input TimeFormat,
    input [7:0] cnt_set,
    output  reg [7:0] cnt_out,
    output  reg rco 
    );
    always @(posedge clk) begin
        if (rst) begin//复位归零
            cnt_out <= 0;
            rco     <= 0;
        end
        else if (load || mode == 2'b11) begin//置数
            cnt_out <= cnt_set;
        end
        else if (en) begin
            if (mode == 2'b00 || mode == 2'b10) begin//正计时
                if (TimeFormat) begin//12小时制
                    if (cnt_out[7:4] == 1 && cnt_out[3:0] == 1) begin//计满
                        cnt_out <= 0;
                        rco     <= 1;
                    end
                    else begin
                        rco     <= 0;
                        if (cnt_out[3:0] == 9) begin//低位计满
                            cnt_out[3:0] <= 0;
                            cnt_out[7:4] <= cnt_out[7:4] + 1;
                        end
                        else begin
                            cnt_out[3:0] <= cnt_out[3:0] + 1;
                        end
                    end
                end
                else begin//24小时制
                    if (cnt_out[7:4] == 2 && cnt_out[3:0] == 3) begin//计满
                        cnt_out <= 0;
                        rco     <= 1;
                    end
                    else begin
                        rco     <= 0;
                        if (cnt_out[3:0] == 9) begin//低位计满
                            cnt_out[3:0] <= 0;
                            cnt_out[7:4] <= cnt_out[7:4] + 1;
                        end
                        else begin
                            cnt_out[3:0] <= cnt_out[3:0] + 1;
                        end
                    end
                end
            end
            else if (mode == 2'b01) begin//倒计时
                if (cnt_out == 0) begin//计满
                    cnt_out <= {4'b0010, 4'b0011};
                    rco     <= 1;
                end
                else begin
                    rco     <= 0;
                    if (cnt_out[3:0] == 0) begin//低位计满
                        cnt_out[3:0] <= 9;
                        cnt_out[7:4] <= cnt_out[7:4] - 1;
                    end
                    else begin
                        cnt_out[3:0] <= cnt_out[3:0] - 1;
                    end
                end
            end
        end
        else begin
            rco <= 0;
        end
    end
endmodule

module shine_per_sec 
    #(
    parameter TIME = 5,//seconds
    parameter CLK_FREQ = 100,//input freqency
    parameter COLOR = 3'b100
    )
    (
    input clk_100Hz,
    input rst,
    input flag,
    output reg [2:0] led
    );
    localparam MAX_COUNT = TIME*CLK_FREQ;

    reg start;
    reg [15:0] cnt;
    reg LightOrDark;
    initial begin
        start <= 0;
        cnt <= 0;
        led <= 0;
        LightOrDark <= 0;
    end
    //开始标志
    always @(posedge clk_100Hz) begin
        if (rst == 1) begin
            start <= 0;
        end
        else begin
            if (flag == 1) begin
                start <= 1;
            end
            if (cnt == MAX_COUNT - 1) begin
                start <= 0;
            end
        end
    end
    //计时
    always @(posedge clk_100Hz) begin
        if (rst == 1) begin
            cnt <= 0;
        end
        else begin
            if (start == 1) begin
                cnt <= cnt + 1;
            end
            if (cnt == MAX_COUNT - 1) begin
                cnt <= 0;
            end
        end
    end

    //闪烁
    always @(posedge clk_100Hz) begin
        if (rst == 1) begin
            LightOrDark <= 0;
        end
        else begin
            if (cnt % CLK_FREQ) begin//每秒切换状态
                LightOrDark <= ~LightOrDark;
            end
            if (cnt == MAX_COUNT - 1) begin//闪完了
                LightOrDark <= 0;
            end
        end
    end

    always @(posedge clk_100Hz) begin
        if (rst) begin
            led <= 0;
        end
        else begin
            led <= LightOrDark? COLOR : 0;
        end
    end
endmodule

//分频模块，不妨假设32位计数器足够使用
module freq_div 
    #(
        parameter FREQ_IN = 100000000,
        parameter FREQ_OUT = 1
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