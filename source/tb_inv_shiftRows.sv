// $Id: $
// File name:   tb_inv_shiftRows.sv
// Created:     3/13/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This the testbench to test the proper working of the inv_shiftRows.sv module"

`timescale 1ns/10ps

module tb_inv_shiftRows();

	// Test Bench Parameters 
	integer test_case_num;
	parameter DELAY = 2ns;

	// DUT Signals
	reg [127:0] tb_invByteSData;
	reg [127:0] tb_invShiftRowData;

	// Test Bench Reference Signals
	reg [127:0] tb_inputs [1:0] = {128'h12345678123456781234567812345678, 128'hAABBCCDDAABBCCDDAABBCCDDAABBCCDD};
	reg [127:0] tb_outputs [1:0] = {128'h12121212343434345656565678787878, 128'hAAAAAAAABBBBBBBBCCCCCCCCDDDDDDDD};


	inv_shiftRows  INV_SHIFT_ROWS(
					.invByteSData(tb_invByteSData),
					.invShiftRowData(tb_invShiftRowData)
				     );

	initial
	begin
		for(test_case_num = 0; test_case_num < 2; test_case_num++)
		begin
			tb_invByteSData = tb_inputs[test_case_num];
			#DELAY
			if(tb_invShiftRowData == tb_outputs[test_case_num])
			begin
				$info("Test Case %0d, PASSED", test_case_num + 1);
			end
			else
			begin
				$error("Test Case %0d, FAILED", test_case_num + 1);
			end
		end
	end

endmodule 