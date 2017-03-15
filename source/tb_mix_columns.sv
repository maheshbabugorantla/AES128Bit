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
	reg [127:0] tb_dataInput;
	reg [127:0] tb_dataOutput;	
	reg tb_enable;

	// DUT PortMap for mix_columns module
	mix_columns MIX_COLUMNS(
					.dataIn(tb_dataInput),
					.enable(tb_enable),
					.dataOut(tb_dataOutput)
			       );

	initial
	begin
		test_case_num = 1;

		tb_enable = 1;

		tb_dataInput = 128'h97ECC3954D904AD8F24CE78CA6466E87;
		
		#2

		if(tb_dataOutput == 128'h4C9F42BCA3703AA640D4E4A5741FAECC)
		begin
			$info("Test Case #%0d Passed", test_case_num);	
		end
		else 
		begin
			$error("Test Case #%0d Failed", test_case_num);	
		end

		test_case_num += 1;

		tb_enable = 1;

		tb_dataInput = 128'hCA6E80D7A0543F0EC358558977895ED9;
		
		#2

		if(tb_dataOutput == 128'h6A5ADD1E9647988CA905B15AE94532E7)
		begin
			$info("Test Case #%0d Passed", test_case_num);	
		end
		else 
		begin
			$error("Test Case #%0d Failed", test_case_num);	
		end

		#1

		test_case_num += 1;

		tb_enable = 0;
		
		#2
	
		if(tb_dataOutput == tb_dataInput)
		begin
			$info("Test Case #%0d Passed", test_case_num);	
		end
		else 
		begin
			$error("Test Case #%0d Failed", test_case_num);	
		end
	end

endmodule 