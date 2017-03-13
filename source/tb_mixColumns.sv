// $Id: $
// File name:   tb_mixColumns.sv
// Created:     3/10/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the testbench for the MixColumns Layer"

`timescale 1ns/10ps

module tb_mixColumns();
	
	integer test_case_num;

	// DUT Parameters
	reg [127:0] tb_state_in;
	reg [127:0] tb_state_out;

	// Declare DUT
	mixColumns MIX_COLUMNS
	( 
		.state_in(tb_state_in),
		.state_out(tb_state_out)
	);
	
	initial
	begin
		test_case_num = 1;		
		
		tb_state_in = 128'h627a6f6644b109c82b18330a81c3b3e5;
		#2
	end

endmodule 