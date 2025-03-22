`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/17 22:35:58
// Design Name: 
// Module Name: ALU32_tb
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


module ALU32_tb(    );
  parameter N = 32;               // ����λ��
  parameter SEED = 1;              // ���岻ͬ���������
  wire [N-1:0] Result;              //32λ������
  wire zero;                         //���Ϊ0��־λ
  reg [N-1:0]  Data_A, Data_B;     //32λ��������,�͵�ALU�˿�A
  reg [3:0]   ALUctr;             //4λALU���������ź�
  integer i, errors;
  reg [N-1:0] TempS;
  reg [4:0] shamt;
//  reg tempZero;
  reg less;
  reg signed [31:0] tempdata_a,tempdata_b;
  
  parameter Addctr  = 4'b0000,   // ���岻ͬ����Ŀ�����
             Sllctr  = 4'b0001, 
             Sltctr  = 4'b0010, 
             Sltuctr = 4'b0011, 
             Xorctr  = 4'b0100, 
             Srlctr  = 4'b0101, 
             Orctr   = 4'b0110, 
             Andctr  = 4'b0111, 
             Subctr  = 4'b1000, 
             Sractr  = 4'b1101, 
             Luictr  = 4'b1111; 


ALU32 ALU32_inst(.result(Result),.zero(zero),.dataa(Data_A),.datab(Data_B),.aluctr(ALUctr));

  task checkalu;
    begin
    case (ALUctr)
    Addctr: begin 
                 TempS=Data_A+Data_B;   //�ӷ�����
                 if (TempS!=Result) 
                  begin     
                       errors = errors + 1;
                      $display("ERROR: ALUctr,Data_A,Data_B = %4b,%8h,%8h, want= %8h, got=%8h,%1b." ,
                      ALUctr, Data_A, Data_B, TempS, Result,zero);                 
                  end
             end
    Sllctr: begin 
                 shamt=Data_B[4:0];
                 TempS=Data_A << shamt;   //��������
                 if (TempS!=Result) 
                  begin     
                       errors = errors + 1;
                      $display("ERROR: ALUctr,Data_A,Data_B = %4b,%8h,%8h, want= %8h, got=%8h,%1b." ,
                      ALUctr, Data_A, Data_B, TempS, Result,zero);                 
                  end
             end
    Sltctr: begin                 //��������С�ڱȽ�����
                 tempdata_a=Data_A;
                 tempdata_b=Data_B;
                 less=tempdata_a < tempdata_b;
                 TempS={28'h0000000,3'b000,less};
                 if (TempS!=Result)
                  begin     
                       errors = errors + 1;
                      $display("ERROR: ALUctr,Data_A,Data_B = %4b,%8h,%8h, want= %8h, got=%8h,%1b." ,
                      ALUctr, Data_A, Data_B, TempS, Result,zero);                 
                  end
             end
    Sltuctr: begin                 //�޷�����С�ڱȽ�����
                 less=Data_A < Data_B;
                 TempS={28'h0000000,3'b000,less};
                 if (TempS!=Result)
                  begin     
                       errors = errors + 1;
                      $display("ERROR: ALUctr,Data_A,Data_B = %4b,%8h,%8h, want= %8h, got=%8h,%1b." ,
                      ALUctr, Data_A, Data_B, TempS, Result,zero);                 
                  end
             end
      Xorctr: begin 
                 TempS=Data_A ^ Data_B;   //�������
                 if (TempS!=Result) 
                  begin     
                       errors = errors + 1;
                      $display("ERROR: ALUctr,Data_A,Data_B = %4b,%8h,%8h, want= %8h, got=%8h,%1b." ,
                      ALUctr, Data_A, Data_B, TempS, Result,zero);                 
                  end
             end
      Srlctr: begin 
                 shamt=Data_B[4:0];
                 TempS=Data_A >> shamt;   //�߼���������
                 if (TempS!=Result) 
                  begin     
                       errors = errors + 1;
                      $display("ERROR: ALUctr,Data_A,Data_B = %4b,%8h,%8h, want= %8h, got=%8h,%1b." ,
                      ALUctr, Data_A, Data_B, TempS, Result,zero);                 
                  end
             end
      Orctr: begin 
                 TempS=Data_A | Data_B;   //������
                 if (TempS!=Result) 
                  begin     
                       errors = errors + 1;
                      $display("ERROR: ALUctr,Data_A,Data_B = %4b,%8h,%8h, want= %8h, got=%8h,%1b." ,
                      ALUctr, Data_A, Data_B, TempS, Result,zero);                 
                  end
             end
      Andctr: begin 
                 TempS=Data_A & Data_B;   //������
                 if (TempS!=Result) 
                  begin     
                       errors = errors + 1;
                      $display("ERROR: ALUctr,Data_A,Data_B = %4b,%8h,%8h, want= %8h, got=%8h,%1b." ,
                      ALUctr, Data_A, Data_B, TempS, Result,zero);                 
                  end
             end
      Subctr: begin 
                 TempS=Data_A-Data_B;   //��������
                 if (TempS!=Result) 
                  begin     
                       errors = errors + 1;
                      $display("ERROR: ALUctr,Data_A,Data_B = %4b,%8h,%8h, want= %8h, got=%8h,%1b." ,
                      ALUctr, Data_A, Data_B, TempS, Result,zero);                 
                  end
             end
      Sractr: begin 
                 shamt=Data_B[4:0];
                 TempS=tempdata_a >>> shamt;   //������������
                 if (TempS!=Result) 
                  begin     
                       errors = errors + 1;
                      $display("ERROR: ALUctr,Data_A,Data_B = %4b,%8h,%8h, want= %8h, got=%8h,%1b." ,
                      ALUctr, Data_A, Data_B, TempS, Result,zero);                 
                  end
             end
    Luictr: begin 
                 TempS=Data_B;   //ȡ������B
                 if (TempS!=Result) 
                  begin     
                       errors = errors + 1;
                      $display("ERROR: ALUctr,Data_A,Data_B = %4b,%8h,%8h, want= %8h, got=%8h,%1b." ,
                      ALUctr, Data_A, Data_B, TempS, Result,zero);                 
                  end
             end
           
             
    endcase
    end
  endtask
  
  initial begin
    errors = 0;
           Data_A = $random(SEED);                        // Set pattern based on seed parameter
   for (i=0; i<10000; i=i+1) begin                //����10000��
          Data_B = ~Data_A; 
          ALUctr = Addctr;  #10 ; checkalu;     
          ALUctr = Sllctr;  #10 ; checkalu;     
          ALUctr = Sltctr;  #10 ; checkalu;     
          ALUctr = Sltuctr; #10 ; checkalu;     
          ALUctr = Xorctr;  #10 ; checkalu;     
          ALUctr = Srlctr;  #10 ; checkalu;     
          ALUctr = Orctr;   #10 ; checkalu;     
          ALUctr = Subctr;  #10 ; checkalu;     
          ALUctr = Sractr;  #10 ; checkalu;     
          ALUctr = Luictr;  #10 ; checkalu;     
          Data_B = Data_A; 
          ALUctr = Addctr;  #10 ; checkalu;     
          ALUctr = Sllctr;  #10 ; checkalu;     
          ALUctr = Sltctr;  #10 ; checkalu;     
          ALUctr = Sltuctr; #10 ; checkalu;     
          ALUctr = Xorctr;  #10 ; checkalu;     
          ALUctr = Srlctr;  #10 ; checkalu;     
          ALUctr = Orctr;   #10 ; checkalu;     
          ALUctr = Subctr;  #10 ; checkalu;     
          ALUctr = Sractr;  #10 ; checkalu;     
          ALUctr = Luictr;  #10 ; checkalu;     
          Data_A = $random; Data_B= $random;                          // Get random number, maybe > 32 bits wide
          ALUctr = Addctr;  #10 ; checkalu;     
          ALUctr = Sllctr;  #10 ; checkalu;     
          ALUctr = Sltctr;  #10 ; checkalu;     
          ALUctr = Sltuctr; #10 ; checkalu;     
          ALUctr = Xorctr;  #10 ; checkalu;     
          ALUctr = Srlctr;  #10 ; checkalu;     
          ALUctr = Orctr;   #10 ; checkalu;     
          ALUctr = Subctr;  #10 ; checkalu;     
          ALUctr = Sractr;  #10 ; checkalu;     
          ALUctr = Luictr;  #10 ; checkalu;     
    end
    $display("ALU32 test done. Errors: %0d .", errors);
    $stop(1);
  end




/*
     initial begin
         #10 begin Data_A=$random(SEED); Data_B=$random; aluctr=4'b0000;end
         
         #20 aluctr=4'b0001;
         #20 aluctr=4'b0010;
         #20 aluctr=4'b0011;
         #20 aluctr=4'b0100;
         #20 aluctr=4'b0101;
         #20 aluctr=4'b0110;
         #20 aluctr=4'b0111;
         #20 aluctr=4'b1000;
         #20 aluctr=4'b1101;
         #20 aluctr=4'b1111;
         #50 begin a=32'h80000000; b=32'h7fffffff; aluctr=4'b0010; end
         #20 aluctr=4'b0011; 
         #20 aluctr=4'b0100;
         #20 aluctr=4'b0101;
         #20 aluctr=4'b0110;
         #20 aluctr=4'b0111;
         #20 aluctr=4'b1000;
         #50 begin a=32'h00000000; b=32'hffffffff; aluctr=4'b0010; end
         #20 aluctr=4'b0011; 
         #20 aluctr=4'b0100;
         #20 aluctr=4'b0101;
         #20 aluctr=4'b0110;
         #20 aluctr=4'b0111;
         #20 aluctr=4'b1000;
         #20  $stop;
 end
*/
endmodule
