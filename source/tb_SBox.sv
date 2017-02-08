// $Id: $
// File name:   tb_SBox.sv
// Created:     2/8/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This testbench is used to test the outputs of Byte Substitution Layer"

`timescale 1ns/10ps

module tb_SBox();
	
	// Test Bench DUT Port Signals
	reg [127:0] tb_inputData;
	reg [127:0] tb_byteSubData;
	integer test_case_num;

	// DUT PortMap
	generate
		SBox DUT( .inputData(tb_inputData), .byteSubData(tb_byteSubData));		
	endgenerate

	// Test Bench Process	
	initial
	begin
		test_case_num = 0;

		tb_inputData = 128'hC2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2;
		#5; // 5ns Delay
		if(tb_byteSubData == 128'h25252525252525252525252525252525)
		begin
			$info("Test Case #%0d Passed",test_case_num);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_num);
		end

		test_case_num = test_case_num + 1;

		tb_inputData = 128'h00112233445566778899AABBCCDDEEFF;
		#5;
		if(tb_byteSubData == 128'h638293C31BFC33F5C4EEACEA4BC12816)
		begin
			$info("Test Case #%0d Passed",test_case_num);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_num);
		end

	end
endmodule 