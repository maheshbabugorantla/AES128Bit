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
	parameter CLK_DELAY = 10ns;

	// DUT parameters
	reg tb_clk;
	reg tb_n_rst;
	reg tb_encryptEnable;
	reg [127:0] tb_key;
	reg [127:0] tb_inputData;
	reg [127:0] tb_outputData;

	// Test Bench reference Signals
		
	// Clock Generation Block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_DELAY / 2);
		tb_clk = 1'b1;
		#(CLK_DELAY / 2);
	end

	encryption_block ENCRYPT_BLK(
					.clk(tb_clk),
					.n_rst(tb_n_rst),
					.encryptEnable(tb_encryptEnable),
					.key(tb_key),
					.inputData(tb_inputData),
					.outputData(tb_outputData)
				    );

	task wait_for_encryption;

		@(posedge tb_clk); // KEY_SCHEDULE
		@(posedge tb_clk); // START
		@(posedge tb_clk); // WAIT_1
		@(posedge tb_clk); // ROUND_KEY
		@(posedge tb_clk); // CONTROL OUTPUT
		@(posedge tb_clk); // ROUND_KEY 1
		@(posedge tb_clk); // MIX_COLUMN
		@(posedge tb_clk); // CONTROL_OUTPUT
		@(posedge tb_clk); // ROUND_KEY 2
		@(posedge tb_clk); // MIX_COLUMN
		@(posedge tb_clk); // CONTROL_OUTPUT
		@(posedge tb_clk); // ROUND_KEY 3
		@(posedge tb_clk); // MIX_COLUMN
		@(posedge tb_clk); // CONTROL_OUTPUT
		@(posedge tb_clk); // ROUND_KEY 4
		@(posedge tb_clk); // MIX_COLUMN
		@(posedge tb_clk); // CONTROL_OUTPUT
		@(posedge tb_clk); // ROUND_KEY 5
		@(posedge tb_clk); // MIX_COLUMN
		@(posedge tb_clk); // CONTROL_OUTPUT
		@(posedge tb_clk); // ROUND_KEY 6
		@(posedge tb_clk); // MIX_COLUMN
		@(posedge tb_clk); // CONTROL_OUTPUT
		@(posedge tb_clk); // ROUND_KEY 7
		@(posedge tb_clk); // MIX_COLUMN
		@(posedge tb_clk); // CONTROL_OUTPUT
		@(posedge tb_clk); // ROUND_KEY 8
		@(posedge tb_clk); // MIX_COLUMN
		@(posedge tb_clk); // CONTROL_OUTPUT
		@(posedge tb_clk); // ROUND_KEY 9
		@(posedge tb_clk); // MIX_COLUMN
		@(posedge tb_clk); // CONTROL_OUTPUT // Because everything else is a combinational logic other than the controller, the encryptedOutput will be available by this time
		@(negedge tb_clk); // Wait for the Encrypted Output to Stabilize

	endtask

	task reset_dut;

		// Resetting the Encryption Block
		tb_n_rst = 1'b1;
		@(posedge tb_clk);
		tb_n_rst = 1'b0;
		tb_encryptEnable = 1'b0;
		@(posedge tb_clk);
		tb_n_rst = 1'b1;
		@(negedge tb_clk);

	endtask

	initial
	begin
		test_case_number = 1;

		reset_dut;		

		tb_inputData = 128'h7D8AE0F7CFA0A6CB09FB5D05A8EC586D;
		tb_key = 128'h5E74E7BA66B0C7CC1B7697B3F9F51527;

		@(posedge tb_clk); // IDLE

		tb_encryptEnable = 1'b1;

		wait_for_encryption;

		if(tb_outputData == 128'hdeb0f81341f3503a7cd01e2bc7cdd556)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 2
		test_case_number += 1;

    	        tb_inputData = 128'hE6FEBF30133874EBCB49226CD36D0D4F;
		tb_key = 128'h33DE20E331BA5A525AB7C2495A767B5A;
		
		@(posedge tb_clk); // IDLE

		tb_encryptEnable = 1'b1;

		wait_for_encryption;

		if(tb_outputData == 128'h67928dd5470d4a11f0ea4ae7d49b2dd4)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 3
		test_case_number += 1;

    	        tb_inputData = 128'hD07A7228CF5E1ED034E14FA06FA08D49;
		tb_key = 128'hEED5A3496E321A41C925F0389B236E36;
		
		@(posedge tb_clk); // IDLE

		tb_encryptEnable = 1'b1;

		wait_for_encryption;

		if(tb_outputData == 128'h71D31B8BA309FF7ABF61A6938CFA4267)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 4
		test_case_number += 1;

    	        tb_inputData = 128'h47A9A7407366F06BA8D9233CDC85BDE9;
		tb_key = 128'h8A969C8CB7ECF08B60A9E0D8647E6E21;
		
		@(posedge tb_clk); // IDLE

		tb_encryptEnable = 1'b1;

		wait_for_encryption;

		if(tb_outputData == 128'hCDF439C2D97469B5F54939D3E41E9D61)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 5
		test_case_number += 1;

    	        tb_inputData = 128'hB280F924255912E9F3FA10AE589B1785;
		tb_key = 128'h6058C3334044E41A2C71E6205B27E854;
		
		@(posedge tb_clk); // IDLE

		tb_encryptEnable = 1'b1;

		wait_for_encryption;

		if(tb_outputData == 128'h2686C49884668776DD0F02A34150643F)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		// Test Case 6
		test_case_number += 1;

		reset_dut;

    	        tb_inputData = 128'hC0C148CF7C52DC9A10CCAB979FF03920;
		tb_key = 128'hAD711EC0ACD35F80C3E5EDD4E1336B6A;

		@(posedge tb_clk); // IDLE

		tb_encryptEnable = 1'b1;

		wait_for_encryption;

		if(tb_outputData == 128'h0EA6416862183B71C5A2B66E320FDDEB)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end
	end
endmodule 

// Test Case 1
/*		test_case_number = 1;
	
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

	end */