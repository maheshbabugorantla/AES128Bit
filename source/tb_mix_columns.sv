// $Id: $
// File name:   tb_mix_columns.sv
// Created:     3/13/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the test bench to test the proper working of the mix_columns module"

`timescale 1ns/10ps

module tb_mix_columns();
	
	// Test Bench Parameters
	integer test_case_num;	
	
	// DUT Signals
	reg [127:0] dataInput;
	reg [127:0] dataOutput;	

	// DUT PortMap for mix_columns module
	mix_columns MIX_COLUMNS( .dataIn(dataInput), .dataOut(dataOutput) );

	initial
	begin
		test_case_num = 1;

		dataInput = 128'h97ECC3954D904AD8F24CE78C876E46A6;
		
		#2

		if(dataOutput == 128'h4C9F42BCA3703AA640D4E4A5473794ED)
		begin
			$info("Test Case #%0d Passed", test_case_num);	
		end
		else 
		begin
			$error("Test Case #%0d Failed", test_case_num);	
		end
	end	

endmodule 