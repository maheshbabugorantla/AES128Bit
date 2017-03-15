// $Id: $
// File name:   tb_inverse_mix_columns.sv
// Created:     3/13/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the test bench to test the proper working of the inverse_mix_columns module"

`timescale 1ns/10ps

module tb_inverse_mix_columns ();

	// Test Bench Parameters
	integer test_case_num;
	parameter DELAY = 10ns;

	// DUT Parameters
	reg [127:0] tb_invDataIn;	
	reg [127:0] tb_invDataOut;

	// Test Bench Reference Signals	
	
	inverse_mix_columns INV_MIX_COLS(
						.invDataIn(tb_invDataIn),
						.invDataOut(tb_invDataOut)
					);

	initial
	begin
		test_case_num = 1;

//		tb_invDataIn = 128'hAABBCCDDAABBCCDDAABBCCDDAABBCCDD;					
		tb_invDataIn = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;

		#DELAY
		       
		if(tb_invDataOut == 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA)
		begin
			$info("Test Case #%0d Passed", test_case_num);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_num);
		end
	end

endmodule 