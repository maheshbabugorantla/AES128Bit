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
	parameter DELAY = 2ns;

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
		// Test Case 1
		test_case_num = 1;

		tb_invDataIn = 128'hF1FE3DB041C7C82ADF40F32A0D027136;

		#DELAY

		if(tb_invDataOut == 128'h0CBEDFEF2D296C0C0ACEAA28C60A2AAE)
		begin
			$info("Test Case #%0d Passed", test_case_num);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_num);
		end
		
		// Test Case 2
		test_case_num += 1;

		tb_invDataIn = 128'hB8EC5E26B1BDBB64E666CF4EBDE233E7;

		#DELAY

		if(tb_invDataOut == 128'hF2C14C5390E9278D50867BACB2F031F8)
		begin
			$info("Test Case #%0d Passed", test_case_num);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_num);
		end

		// Test Case 3
		test_case_num += 1;

		tb_invDataIn = 128'h8B3A0766E4753C876226539B01F89626;

		#DELAY

		if(tb_invDataOut == 128'hFE21C9C6F1637DC5AE8E9C30B546B00A)
		begin
			$info("Test Case #%0d Passed", test_case_num);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_num);
		end

		// Test Case 4
		test_case_num += 1;

		tb_invDataIn = 128'hDDB3E612D6FEEAF7C2650EF4E30FB6CB;

		#DELAY

		if(tb_invDataOut == 128'hCB8DDF03F074A61709427F691A2E76D3)
		begin
			$info("Test Case #%0d Passed", test_case_num);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_num);
		end

		// Test Case 5
		test_case_num += 1;

		tb_invDataIn = 128'hCCBEA8713B1AE30EC12AE5010E7A7C8E;

		#DELAY

		if(tb_invDataOut == 128'h27070E85C25599C2EB74D141EF518AB2)
		begin
			$info("Test Case #%0d Passed", test_case_num);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_num);
		end

		// Test Case 6
		test_case_num += 1;

		tb_invDataIn = 128'hE8609F1511EBE0E491A3317CADA64A94;

		#DELAY

		if(tb_invDataOut == 128'h36584529588E4E66E967B7462D8A7B09)
		begin
			$info("Test Case #%0d Passed", test_case_num);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_num);
		end

	end

endmodule 