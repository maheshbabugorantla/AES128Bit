// $Id: $
// File name:   tb_KeySchedule.sv
// Created:     3/14/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: This is the testbench to test the proper working of the KeySchedule for the 128-bit Key Schedule

`timescale 1ns/10ps

module tb_KeySchedule();

	// Test Bench Parameters
	integer	test_case_number;
	parameter DELAY = 100ns;

	// DUT Parameters
	reg [127:0] tb_encryptKey;
	reg [1407:0] tb_roundKeys;

	// DUT Portmap
	KeySchedule KEY_SCHEDULE (
					.encryptKey(tb_encryptKey),
					.roundKeys(tb_roundKeys)
			   	 );

	reg [127:0] roundKey0, roundKey1, roundKey2, roundKey3, roundKey4, roundKey5, roundKey6, roundKey7, roundKey8, roundKey9, roundKey10;


	initial
	begin
		tb_encryptKey = 128'h2B6BAAB2B3768EA3F69807D892BEB46D; // Input Encrypt Key	
		
		#DELAY;
		
		roundKey0 = tb_roundKeys[127:0];	

		test_case_number = 1;

		roundKey1 = tb_roundKeys[255:128];
		
		#5;

		if(roundKey1 == 128'h84E696FD3790185EC1081F8653B6ABEB)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		test_case_number += 1;

		roundKey2 = tb_roundKeys[383:256];

		#5;

		if( roundKey2 == 128'hC8847F10FF14674E3E1C78C86DAAD323)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		test_case_number += 1;

		roundKey3 = tb_roundKeys[511:384];

		if(roundKey3 == 128'h60E2592C9FF63E62A1EA46AACC409589)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		test_case_number += 1;

		roundKey4 = tb_roundKeys[639:512];

		if(roundKey4 == 128'h61C8FE67FE3EC0055FD486AF93941326)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end		

		test_case_number += 1;

		roundKey5 = tb_roundKeys[767:640];

		if(roundKey5 == 128'h53B509BBAD8BC9BEF25F4F1161CB5C37)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end		

		test_case_number += 1;

		roundKey6 = tb_roundKeys[895:768];

		if(roundKey6 == 128'h6CFF9354C1745AEA332B15FB52E049CC)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end	

		test_case_number += 1;

		roundKey7 = tb_roundKeys[1023:896];

		if(roundKey7 == 128'hCDC4D8540CB082BE3F9B97456D7BDE89)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		test_case_number += 1;

		roundKey8 = tb_roundKeys[1151:1024];

		if(roundKey8 == 128'h6CD97F686069FDD65FF26A933289B41A)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		test_case_number += 1;

		roundKey9 = tb_roundKeys[1279:1152];

		if(roundKey9 == 128'hD054DD4BB03D209DEFCF4A0EDD46FE14)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		test_case_number += 1;

		roundKey10 = tb_roundKeys[1407:1280];

		if(roundKey10 == 128'hBCEF278A0CD20717E31D4D193E5BB30D)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

	end

endmodule 
