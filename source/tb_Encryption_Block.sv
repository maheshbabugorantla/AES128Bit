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

		// Test Case 8
		test_case_number += 1;
	
		tb_inputData = 128'h4452D2CA485F5E5D8CC0BB674E47BA2C;

		#5;

		if(tb_outputData == 128'h0700197698A20E09D61AAC9213EF3380)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 9
		test_case_number += 1;
	
		tb_inputData = 128'h206641F7BB4F1DC64676508180322B9B;

		#5;

		if(tb_outputData == 128'h0A33CCBE94969FD311C78202EE92969E)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 10
		test_case_number += 1;
	
		tb_inputData = 128'h9010A5C4B867787E5E3A544CD2C4792B;

		#5;

		if(tb_outputData == 128'h159C05CAB38325A4F2BADE7C7C45606D)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 11
		test_case_number += 1;
	
		tb_inputData = 128'h8F088F33774CFFCC29D029D21CBB36A7;

		#5;

		if(tb_outputData == 128'h17AC22DA4C2D0315E7557CC116053E8E)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 12
		test_case_number += 1;
	
		tb_inputData = 128'h2326CA7D5CDB960E082B1159A876DFFF;

		#5;

		if(tb_outputData == 128'hE79A46E1D93BFFCA1330F3BE2EFF974D)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

	end

endmodule 