// $Id: $
// File name:   tb_roundkey.sv
// Created:     3/14/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the test bench to ensure the proper working of the logic to generate the round Key for the Key Expansion for AES128 bit"

`timescale 1ns/10ps

module tb_roundKey();

	// Test Bench Parameters
	integer	test_case_number;
	parameter DELAY = 10ns;

	// DUT Parameters
	reg [127:0] tb_inputKey;
	reg [3:0] tb_count;
	reg [127:0] tb_outputRoundKey;

	// DUT Portmap
	roundKey ROUND_KEY (
				.inputKey(tb_inputKey),
				.count(tb_count),
				.outputRoundKey(tb_outputRoundKey)
			   );


	// Testing the Generation of all the Round Keys
	initial
	begin

		// Round Key 1
		test_case_number = 1;

		tb_inputKey = 128'h2B6BAAB2B3768EA3F69807D892BEB46D; // Input Key for the RoundKey Module
		tb_count =  4'b0000;

		#(DELAY);

		if(tb_outputRoundKey == 128'h84E696FD3790185EC1081F8653B6ABEB)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Round Key 2
		test_case_number += 1;

		tb_inputKey = tb_outputRoundKey;
		tb_count = 4'b0001;
		
		#(DELAY);

		if(tb_outputRoundKey == 128'hC8847F10FF14674E3E1C78C86DAAD323)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Round Key 3
		test_case_number += 1;

		tb_inputKey = tb_outputRoundKey;
		tb_count = 2;
		
		#(DELAY);

		if(tb_outputRoundKey == 128'h60E2592C9FF63E62A1EA46AACC409589)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Round Key 4
		test_case_number += 1;

		tb_inputKey = tb_outputRoundKey;
		tb_count = 3;
		
		#(DELAY);

		if(tb_outputRoundKey == 128'h61C8FE67FE3EC0055FD486AF93941326)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Round Key 5
		test_case_number += 1;

		tb_inputKey = tb_outputRoundKey;
		tb_count = 4;
		
		#(DELAY);

		if(tb_outputRoundKey == 128'h53B509BBAD8BC9BEF25F4F1161CB5C37)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Round Key 6
		test_case_number += 1;

		tb_inputKey = tb_outputRoundKey;
		tb_count = 5;
		
		#(DELAY);

		if(tb_outputRoundKey == 128'h6CFF9354C1745AEA332B15FB52E049CC)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Round Key 7
		test_case_number += 1;

		tb_inputKey = tb_outputRoundKey;
		tb_count = 6;
		
		#(DELAY);

		if(tb_outputRoundKey == 128'hCDC4D8540CB082BE3F9B97456D7BDE89)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Round Key 8
		test_case_number += 1;

		tb_inputKey = tb_outputRoundKey;
		tb_count = 7;
		
		#(DELAY);

		if(tb_outputRoundKey == 128'h6CD97F686069FDD65FF26A933289B41A)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Round Key 9
		test_case_number += 1;

		tb_inputKey = tb_outputRoundKey;
		tb_count = 8;
		
		#(DELAY);

		if(tb_outputRoundKey == 128'hD054DD4BB03D209DEFCF4A0EDD46FE14)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Round Key 10
		test_case_number += 1;

		tb_inputKey = tb_outputRoundKey;
		tb_count = 9;
		
		#(DELAY);

		if(tb_outputRoundKey == 128'hBCEF278A0CD20717E31D4D193E5BB30D)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end
	end

endmodule 