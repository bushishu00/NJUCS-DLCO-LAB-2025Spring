module tb_DigitalTimer;

    // Inputs
    reg clk;
    reg RST;
    reg StartOrPause;
    reg ReadPara;
    reg TimeFormat;
    reg [1:0] mode;
    reg [1:0] ParaSelect;
    reg [1:0] AlarmNo;
    reg [3:0] data_h;
    reg [3:0] data_l;

    // Outputs
    wire Afternoon;
    wire [2:0] TimeKeeper;
    wire [2:0] AlarmDisplay;
    wire [6:0] segs;
    wire [7:0] an;

    // Instantiate the Unit Under Test (UUT)
    DigitalTimer uut (
        .clk(clk),
        .RST(RST),
        .StartOrPause(StartOrPause),
        .ReadPara(ReadPara),
        .TimeFormat(TimeFormat),
        .mode(mode),
        .ParaSelect(ParaSelect),
        .AlarmNo(AlarmNo),
        .data_h(data_h),
        .data_l(data_l),
        .Afternoon(Afternoon),
        .TimeKeeper(TimeKeeper),
        .AlarmDisplay(AlarmDisplay),
        .segs(segs),
        .an(an)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        RST = 1; // Reset active high
        StartOrPause = 0;
        ReadPara = 0;
        TimeFormat = 0; // 24-hour format
        mode = 2'b00; // Digital clock mode
        ParaSelect = 2'b00;
        AlarmNo = 2'b00;
        data_h = 4'b0000;
        data_l = 4'b0000;

        // Wait 100 ns for global reset to finish
        #100;
        RST = 0;

        // Add stimulus here

        // Example: Set time to 12:34:56 in 24-hour format and start timer
        #1000;
        TimeFormat = 0;
        ParaSelect = 2'b11; // Select hours
        data_h = 4'b0001;   // Hour tens digit (1)
        data_l = 4'b0010;   // Hour ones digit (2)
        ReadPara = 1;
        #10000;
        ReadPara = 0;
        #10000;
        ParaSelect = 2'b10; // Select minutes
        data_h = 4'b0011;   // Minute tens digit (3)
        data_l = 4'b0100;   // Minute ones digit (4)
        ReadPara = 1;
        #10000;
        ReadPara = 0;
        #10000;
        ParaSelect = 2'b01; // Select seconds
        data_h = 4'b0101;   // Second tens digit (5)
        data_l = 4'b0110;   // Second ones digit (6)
        ReadPara = 1;
        #10000;
        ReadPara = 0;
        #10000;
        StartOrPause = 1; // Start timer
        #1500;
        StartOrPause = 0;

        // Simulate for some time
        #100000;

        $stop;
    end

    always #5 clk = ~clk; // Generate a 10 MHz clock signal

endmodule



