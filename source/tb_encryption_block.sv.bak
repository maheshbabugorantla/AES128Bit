// $Id: $
// File name:   tb_encryption_block.sv
// Created:     3/13/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the test bench used to test the proper working of the encryption_block module"

`timescale 1ns/10ps

module tb_encryption_block();

	// Basic Test Bench Parameters
	integer test_case_number;

	// DUT parameters
	reg [127:0] tb_inputData;
	reg [127:0] tb_outputData;

	// Test Bench reference Signals
	
	
	encryption_block ENCRYPT_BLK(
					.inputData(tb_inputData),
					.outputData(tb_outputData)
				    );

	initial 
	begin

		// Test Case 1
		test_case_number = 1;
	
		tb_inputData = 128'hEAB09685AD455D652D339804F05C83C5;

		#5;

		if(tb_outputData == 128'h4C9F42BCA3703AA640D4E4A5741FAECC)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 2
		test_case_number += 1;
	
		tb_inputData = 128'h00000000000000000000000000000000;

		#5;

		if(tb_outputData == 128'h63636363636363636363636363636363)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 3
		test_case_number += 1;
	
		tb_inputData = 128'h11111111111111111111111111111111;

		#5;

		if(tb_outputData == 128'h82828282828282828282828282828282)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 4
		test_case_number += 1;
	
		tb_inputData = 128'h22222222222222222222222222222222;

		#5;

		if(tb_outputData == 128'h93939393939393939393939393939393)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 5
		test_case_number += 1;
	
		tb_inputData = 128'h33333333333333333333333333333333;

		#5;

		if(tb_outputData == 128'hC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 6
		test_case_number += 1;
	
		tb_inputData = 128'h44444444444444444444444444444444;

		#5;

		if(tb_outputData == 128'h1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 7
		test_case_number += 1;
	
		tb_inputData = 128'h55555555555555555555555555555555;

		#5;

		if(tb_outputData == 128'hFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

	end

endmodule 