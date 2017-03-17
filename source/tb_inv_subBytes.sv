// $Id: $
// File name:   tb_inv_subBytes.sv
// Created:     3/13/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the testbench for the inv_subBytes.sv module"

`timescale 1ns/10ps

module tb_inv_subBytes();

		// Test Bench Paramters
		parameter DELAY = 2ns;
		integer test_case_num;

		// DUT signals
		reg [127:0] tb_inputData;
		reg [127:0] tb_invByteSubData;
		
		inv_subBytes INV_SUB_BYTES 
				(
					.inputData(tb_inputData),
					.invByteSubData(tb_invByteSubData)
				);

		initial
		begin
			// Test Case 1
			test_case_num = 1;

			tb_inputData = 128'h5D071662586F061230019532779B3564;

			#(DELAY);

			if(tb_invByteSubData == 128'h8D38FFAB5E06A5390809ADA102E8D98C)
			begin
				$info("Test Case %0d, PASSED", test_case_num);
			end
			else
			begin
				$error("Test Case %0d, FAILED", test_case_num);
			end

			// Test Case 2
			test_case_num += 1;

			tb_inputData = 128'h9DD10BDD51F9D208A838439C8D21CB8E;

			#(DELAY);

			if(tb_invByteSubData == 128'h75519EC970697FBF6F76641CB47B59E6)
			begin
				$info("Test Case %0d, PASSED", test_case_num);
			end
			else
			begin
				$error("Test Case %0d, FAILED", test_case_num);
			end

			// Test Case 3
			test_case_num += 1;

			tb_inputData = 128'h96DA98295F1FE22996BD6D0E857C5D64;

			#(DELAY);

			if(tb_invByteSubData == 128'h357AE24C84CB3B4C35CDB3D767018D8C)
			begin
				$info("Test Case %0d, PASSED", test_case_num);
			end
			else
			begin
				$error("Test Case %0d, FAILED", test_case_num);
			end

			// Test Case 4
			test_case_num += 1;

			tb_inputData = 128'hE3C25660D8A860589E983B1516F7557B;

			#(DELAY);

			if(tb_invByteSubData == 128'h4DA8B9902D6F905EDFE2492FFF26ED03)
			begin
				$info("Test Case %0d, PASSED", test_case_num);
			end
			else
			begin
				$error("Test Case %0d, FAILED", test_case_num);
			end

			// Test Case 5
			test_case_num += 1;

			tb_inputData = 128'h5E4ECD5B81722D25E12BE8153542EC18;

			#(DELAY);

			if(tb_invByteSubData == 128'h9DB68057911EFAC2E00BC82FD9F68334)
			begin
				$info("Test Case %0d, PASSED", test_case_num);
			end
			else
			begin
				$error("Test Case %0d, FAILED", test_case_num);
			end

			// Test Case 6
			test_case_num += 1;

			tb_inputData = 128'hAE0978FA649C645F51ACC60820D14C47;

			#(DELAY);

			if(tb_invByteSubData == 128'hBE40C1148C1C8C8470AAC7BF54515D16)
			begin
				$info("Test Case %0d, PASSED", test_case_num);
			end
			else
			begin
				$error("Test Case %0d, FAILED", test_case_num);
			end
		end

endmodule 