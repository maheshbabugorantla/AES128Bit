// $Id: $
// File name:   tb_g_func_key_expansion.sv
// Created:     3/14/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the testbench to verify the working of the g() function to the AES Key Expansion"

`timescale 1ns/10ps

module tb_g_func_key_expansion();

	// TestBench Parameters
	integer test_case_number;
	parameter DELAY = 2ns;

	// DUT Parameters
	reg [31:0] tb_inputWord;
	reg [3:0] tb_count;
	reg [31:0] tb_outputWord;

	
	// DUT PortMap	
	g_func_key_expansion G_FUNC(
					.inputWord(tb_inputWord),
					.count(tb_count),
					.outputWord(tb_outputWord)
				   );

	initial
	begin
		test_case_number = 1;

		tb_inputWord = 32'h92BEB46D; // Input Word for the g function
		tb_count =  4'b0000;

		#(DELAY);
	
		if(tb_outputWord == 32'hAF8D3C4F)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end
	end

endmodule 