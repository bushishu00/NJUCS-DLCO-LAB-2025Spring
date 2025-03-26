`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/25
// Design Name: 
// Module Name: div_32b_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for the 32-bit signed division module (div_32b)
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module div_32b_tb();
  parameter N = 32;                 // Define bit-width
  parameter SEED = 1;               // Define different random sequence
  reg clk, rst;
  reg [N-1:0] x, y;
  reg in_valid;
  wire [N-1:0] q, r;
  wire out_valid;
  wire in_error;

  div_32b my_div_32b (
    .Q(q),
    .R(r),
    .out_valid(out_valid),
    .in_error(in_error),
    .clk(clk),
    .rst(rst),
    .X(x),
    .Y(y),
    .in_valid(in_valid)
  );

  reg [N-1:0] temp_Q, temp_R;
  integer i, errors;

  // Task to check the result
  task checkP;
    begin
      // Calculating expected quotient and remainder
      temp_Q = $signed(x) / $signed(y);
      temp_R = $signed(x) % $signed(y);

      // Check if the results match
      if (out_valid && ((temp_Q != q) || (temp_R != r))) begin
        errors = errors + 1;
        $display($time, " Error: x=%d, y=%d, expected Quot= %d, Rem=%d(%h), got Quot= %d, Rem=%d(%h)",
                 x, y, temp_Q, temp_R, temp_R, q, r, r);
      end
    end
  endtask

  // Clock generation
  initial begin : TB_Clock
    clk = 0;
    forever #2 clk = ~clk;  // Simulate clock signal with 2 ns period
  end

  // Test procedure
  initial begin
    errors = 0;
    x = $random(SEED);  // Set random pattern based on seed parameter
    for (i = 0; i < 10000; i = i + 1) begin  // Run 10000 tests
      rst = 1'b0;
      #2;
      rst = 1'b1;  // Reset after 2 ns
      x = $random; y = $random;  // Random values for X and Y
      // x = 0; y = 1;  // Uncomment for specific test case

      #2;
      rst = 1'b0;
      in_valid = 1'b1;  // Initialize valid input signal
      #5;
      in_valid = 1'b0;  // Deactivate valid signal after 5 ns
      #150;  // Wait for 150 ns, then check the result
      checkP;  // Compare the results
    end

    $display($time, " Divider32B test end. Errors %d.", errors);
    $stop(1);  // Stop the simulation if needed
  end

endmodule
