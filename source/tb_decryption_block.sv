// $Id: $
// File name:   tb_decryption_block.sv
// Created:     4/9/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the testbench to ensure the proper working of the AES128 Decryption Module"

`timescale 1ns/10ps

module tb_decryption_block();

	// Basic Test Bench Parameters
	integer test_case_number = 1;
	parameter CLK_DELAY = 6ns;

	// DUT Parameters
	reg tb_clk;
	reg tb_n_rst;
	reg tb_decryptEnable;
	reg [127:0] tb_key;
	reg [127:0] tb_inputData;
	reg [127:0] tb_outputData;
	
	// Test Bench Reference Signals
		
	// Clock Generation Block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_DELAY / 2);
		tb_clk = 1'b1;
		#(CLK_DELAY / 2);
	end
	
	// DUT PortMap
	decryption_block DECRYPTION_BLK
		(
			.clk(tb_clk),
			.n_rst(tb_n_rst),
			.decryptEnable(tb_decryptEnable),
			.key(tb_key),
			.inputData(tb_inputData),
			.outputData(tb_outputData)
		);

	task wait_for_decryption;

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
		@(negedge tb_clk); // Wait for the Decrypted Output to Stabilize

	endtask

	task reset_dut;

		// Resetting the Encryption Block
		tb_n_rst = 1'b1;
		@(posedge tb_clk);
		tb_n_rst = 1'b0;
		tb_decryptEnable = 1'b0;
		@(posedge tb_clk);
		tb_n_rst = 1'b1;
		@(negedge tb_clk);		

	endtask

	initial
	begin
		test_case_number = 1;

		reset_dut;

		tb_inputData = 128'h67928dd5470d4a11f0ea4ae7d49b2dd4;
		tb_key = 128'h33DE20E331BA5A525AB7C2495A767B5A;

		@(posedge tb_clk); // IDLE

		tb_decryptEnable = 1'b1;

		wait_for_decryption;

		if(tb_outputData == 128'hE6FEBF30133874EBCB49226CD36D0D4F)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end
	end

endmodule 