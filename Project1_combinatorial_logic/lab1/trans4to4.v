`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/09 20:14:55
// Design Name: 
// Module Name: trans4to4
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


module trans4to4(
    output  [2:0] Y0,Y1,Y2,Y3,
    input   [2:0] D0,D1,D2,D3,
    input   [1:0] S
); 
// add your code here
// in order to facilitate the module reuse, we write other 2 moddule first
    wire [2:0] bus;
    wire [2:0] out0,out1,out2,out3;
    mux4to1 mux4to1_u0(
        .Y(bus),
        .D0(D0),
        .D1(D1),
        .D2(D2),
        .D3(D3),
        .S(S)
    );
    demux1to4 demux1to4_u0(
        .Y0(out0),
        .Y1(out1),
        .Y2(out2),
        .Y3(out3),
        .D(bus),
        .S(S)
    );
    assign Y0 = out0;
    assign Y1 = out1;
    assign Y2 = out2;
    assign Y3 = out3;

endmodule

module mux4to1(
    output  [2:0] Y,
    input   [2:0] D0,D1,D2,D3,
    input   [1:0] S
);
    assign Y = (S == 2'b00) ? D0 : 
               (S == 2'b01) ? D1 : 
               (S == 2'b10) ? D2 : 
               (S == 2'b11) ? D3 : 3'bzzz;
endmodule

module demux1to4(
    output [2:0] Y0,Y1,Y2,Y3,
    input  [2:0] D,
    input  [1:0] S
);
    assign Y0 = (S == 2'b00) ? D : 3'bzzz;
    assign Y1 = (S == 2'b01) ? D : 3'bzzz;
    assign Y2 = (S == 2'b10) ? D : 3'bzzz;
    assign Y3 = (S == 2'b11) ? D : 3'bzzz;
endmodule