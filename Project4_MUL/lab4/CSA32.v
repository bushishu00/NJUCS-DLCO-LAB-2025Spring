`timescale 1ns / 1ps

module CSA32 (
    input  wire [31:0] a,
    input  wire [31:0] b,
    input  wire [31:0] c,
    output wire [31:0] sum,
    output wire [31:0] carry
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : csa_bit
            assign sum[i]   = a[i] ^ b[i] ^ c[i];
            assign carry[i] = (a[i] & b[i]) | (b[i] & c[i]) | (a[i] & c[i]);
        end
    endgenerate
    
endmodule
