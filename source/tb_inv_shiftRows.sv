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
	reg [127:0] tb_inputs [7:0] = {128'hDB5C77AA2BD6040C51AC0A3DF41C4507, 128'hF76B38416DF88A09B0E52267E8C6BB6E, 128'hBC0097A9EC1664BD6A6D6EC18C640BD8, 128'h0CBEDFEF2D296C0C0ACEAA28C60A2AAE, 128'hF2C14C5390E9278D50867BACB2F031F8, 128'hfe21c9c6f1637dc5ae8e9c30b546b00a, 128'hCB8DDF03F074A61709427F691A2E76D3, 128'h27070E85C25599C2EB74D141EF518AB2};
	reg [127:0] tb_outputs [7:0] = {128'hDB1C0A0C2B5C453D51D67707F4AC04AA, 128'hF7C622096D6BBB67B0F8386EE8E58A41, 128'hBC646EBDEC000BC16A1697D88C6D64A9, 128'h0C0AAA0C2DBE2A280A29DFAEC6CE6CEF, 128'hF2F07B8D90C131AC50E94CF8B2862753, 128'hFE469CC5F121B030AE63C90AB58E7DC6, 128'hCB2E7F17F08D76690974DFD31A42A603, 128'h2751D1C2C2078A41EB550EB2EF749985};

	inv_shiftRows  INV_SHIFT_ROWS(
					.invByteSData(tb_invByteSData),
					.invShiftRowData(tb_invShiftRowData)
				     );

	initial
	begin
		for(test_case_num = 0; test_case_num < 8; test_case_num++)
		begin
			tb_invByteSData = tb_inputs[test_case_num];

			#(DELAY);

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