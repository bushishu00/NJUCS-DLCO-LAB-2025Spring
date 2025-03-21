`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/26 11:07:24
// Design Name: 
// Module Name: My_xor_tb
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

// Testbench code
// Note: sign here is ` instead of '
`timescale 1ns / 1ps
module My_xor_tb(
    );
    wire c;
    reg a,b;
    My_xor Myxor1(
        .a(a),
        .b(b),
        .c(c)
        );
    initial begin
        //set initial value
        begin 
            a=0;
            b=0;
        end
        #50 //after 50ns, change the value of a and b
        begin 
            a=0;
            b=1;
        end
        #50 
        begin 
            a=1;
            b=0;
        end
        #50 
        begin 
            a=1;
            b=1;
        end
        //if u want to stop simulation after the behaviors above, add the code below
        #200 $finish;
        //$finish will exit the simulato
        //$stop will pause the simulation, u can use $stop to debug and continue the simulation again
    end
endmodule
