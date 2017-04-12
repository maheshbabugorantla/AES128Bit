// $Id: $
// File name:   tb_top_level_block.sv
// Created:     4/12/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is used to test the proper working of the Main Controller, Encryption and Decryption Modules"

`timescale 1ns/10ps

module tb_top_level_block();

	// Test Bench Parameters
	integer test_case_number = 1;	
	parameter CLK_PERIOD = 8ns;

	// Common Test Bench Signals
	reg tb_clk;
	reg tb_n_rst;

	// Clock Generation Block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2);
	end

	// Top Level Block DUT Signals
	reg tb_encrypt_enable;
	reg [127:0] tb_dataPacketIn;
	reg [127:0] tb_Key;
	reg [127:0] tb_dataPacketOut;
//	reg tb_encrypt_done; 	
//	reg tb_decrypt_done;

	// RX FIFO DUT Signals
	reg tb_rx_read_en;
	reg tb_rx_write_en;
	reg [31:0] tb_rx_data_in;
	reg [127:0] tb_rx_data_out;
	reg tb_rx_fifo_empty;
	reg tb_rx_fifo_full;

/*	// TX_FIFO DUT Signals
	reg tb_tx_read_en;
	reg tb_tx_write_en;
	reg [31:0] tb_tx_data_in;
	reg [127:0] tb_tx_data_out;
	reg tb_tx_fifo_empty;
	reg tb_tx_fifo_full; */

	// RX_FIFO DUT
	fifo_in RX_FIFO
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.read_en(tb_rx_read_en),
		.write_en(tb_rx_write_en),
		.data_in(tb_rx_data_in),
		.data_out(tb_rx_data_out),
		.fifo_empty(tb_rx_fifo_empty),
		.fifo_full(tb_rx_fifo_full)
	);

	// TX_FIFO DUT	
/*	fifo_in TX_FIFO
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.read_en(tb_tx_read_en),
		.write_en(tb_tx_write_en),
		.data_in(tb_tx_data_in),
		.data_out(tb_tx_data_out),
		.fifo_empty(tb_tx_fifo_empty),
		.fifo_full(tb_tx_fifo_full)
	); */

	top_level_block TOP_LEVEL_BLK
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.encrypt_enable(tb_encrypt_enable),
		.dataPacketIn(tb_dataPacketIn),
		.Key(tb_Key),
		.dataPacketOut(tb_dataPacketOut)
	);

//		.encrypt_done(tb_encrypt_done),
//		.decrypt_done(tb_decrypt_done)
//	);

	task reset_dut;
		// Resetting the Top Level Block
		tb_n_rst = 1'b1;
		@(posedge tb_clk);
		tb_n_rst = 1'b0;
		//tb_encrypt_enable = 1'b0;
		@(posedge tb_clk);
		tb_n_rst = 1'b1;
		@(negedge tb_clk);
	endtask

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
		@(negedge tb_clk); // Wait for the Decrypted Output to Stabilize
		@(negedge tb_clk); // Wait for the Decrypted Output to Stabilize
		@(negedge tb_clk); // Wait for the Decrypted Output to Stabilize
		@(negedge tb_clk); // Wait for the Decrypted Output to Stabilize
		@(negedge tb_clk); // Wait for the Decrypted Output to Stabilize
		@(negedge tb_clk);
		@(negedge tb_clk);
	endtask

	// Enqueue 32-bit data FIFO into the RX FIFO
	task enqueue_rx_fifo;
		input [31:0] data_in;
		begin
			tb_rx_data_in = data_in;
			tb_rx_write_en = 1'b1;
			@(posedge tb_clk);
			#3;
			tb_rx_write_en = 1'b0;
			@(posedge tb_clk);
			#3;
		end
	endtask

	// Dequeue all the 128-bit data from the RX_FIFO
	task dequeue_rx_fifo;
		tb_rx_write_en = 1'b0;
		@(posedge tb_clk);
		#3;
		tb_rx_read_en = 1'b1;
		@(posedge tb_clk);
		#3;
		tb_rx_read_en = 1'b0;
	endtask

	initial
	begin

		reset_dut; // Resetting the Top Level Block
			
		// Enqueue all the 4 32-bit Data Packets  
		enqueue_rx_fifo (32'hdeb0f813); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (32'h41f3503a); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (32'h7cd01e2b); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (32'hc7cdd556); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("Test case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test case #%0d Failed", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'hdeb0f81341f3503a7cd01e2bc7cdd556)
		begin
			$info("Test case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test case #%0d Failed", test_case_number);
		end

		test_case_number = test_case_number + 1;

		tb_dataPacketIn = tb_rx_data_out; // Using the Data from the RX_FIFO
		tb_Key = 128'h5E74E7BA66B0C7CC1B7697B3F9F51527;

		// When tb_encrypt_enable = 1'b1 => ENCRYPTION TASK 
		// And  tb_encrypt_enable = 1'b0 => DECRYPTION TASK
		tb_encrypt_enable = 1'b0;
		
		@(posedge tb_clk); // IDLE

		wait_for_decryption;

		if(tb_dataPacketOut == 128'h7D8AE0F7CFA0A6CB09FB5D05A8EC586D)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end

		test_case_number = test_case_number + 1;

		/*************************************** Testing AES Encryption Integration ****************************************/

		// Enqueue all the 4 32-bit Data Packets  
		enqueue_rx_fifo (32'h7D8AE0F7); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (32'hCFA0A6CB); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (32'h09FB5D05); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (32'hA8EC586D); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("Test case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test case #%0d Failed", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'h7D8AE0F7CFA0A6CB09FB5D05A8EC586D)
		begin
			$info("Test case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test case #%0d Failed", test_case_number);
		end

		tb_dataPacketIn = tb_rx_data_out; // Using the Data from the RX_FIFO
		tb_Key = 128'h5E74E7BA66B0C7CC1B7697B3F9F51527;

		// When tb_encrypt_enable = 1'b1 => ENCRYPTION TASK 
		// And  tb_encrypt_enable = 1'b0 => DECRYPTION TASK
		tb_encrypt_enable = 1'b1;
		
		@(posedge tb_clk); // IDLE

		wait_for_encryption;

		if(tb_dataPacketOut == 128'hdeb0f81341f3503a7cd01e2bc7cdd556)
		begin
			$info("Test Case #%0d Passed", test_case_number);
		end
		else
		begin
			$error("Test Case #%0d Failed", test_case_number);
		end
	end

endmodule 