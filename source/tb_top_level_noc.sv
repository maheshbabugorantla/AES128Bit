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
	parameter CLK_PERIOD = 10ns;

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
		@(posedge tb_clk);
		tb_n_rst = 1'b1;
		@(negedge tb_clk);
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
		@(negedge tb_clk); // Wait for the Decrypted Output to Stabilize
		@(negedge tb_clk); // Wait for the Decrypted Output to Stabilize
		@(negedge tb_clk); // Wait for the Decrypted Output to Stabilize
		@(negedge tb_clk); // Wait for the Decrypted Output to Stabilize
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

	/*
	task do_thing (input wire[2:0] a, output ...);
		
	endtask
	*/

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

	task reset_rx_fifo;
		tb_rx_read_en = 0;
		tb_rx_write_en = 0;
		tb_rx_data_in = 32'h00000000;
	endtask

	task reset_encryption_decryption_block;
		tb_encrypt_enable = 1'b1;
		@(posedge tb_clk);
		tb_encrypt_enable = 1'b0;
		@(posedge tb_clk);
	endtask

	initial
	begin

		reset_rx_fifo; // Resetting the RX FIFO
		reset_encryption_decryption_block; // Resetting both the Encryption and Decryption Blocks
		reset_dut; // Resetting the Top Level Block

		/*************************************** Testing AES Encryption Integration ****************************************/

		// Enqueue all the 4 32-bit Data Packets  
		enqueue_rx_fifo (32'h7D8AE0F7); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (32'hCFA0A6CB); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (32'h09FB5D05); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (32'hA8EC586D); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("FIFO Full Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("FIFO Full Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'h7D8AE0F7CFA0A6CB09FB5D05A8EC586D)
		begin
			$info("Dequeue Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Dequeue Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		tb_dataPacketIn = tb_rx_data_out; // Using the Data from the RX_FIFO
		tb_Key = 128'h5E74E7BA66B0C7CC1B7697B3F9F51527;

		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);

		// When tb_encrypt_enable = 1'b1 => ENCRYPTION TASK 
		// And  tb_encrypt_enable = 1'b0 => DECRYPTION TASK
		tb_encrypt_enable = 1'b1;

		@(posedge tb_clk); // IDLE

		wait_for_encryption;

		if(tb_dataPacketOut == 128'hdeb0f81341f3503a7cd01e2bc7cdd556)
		begin
			$info("Encryption: Test Case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Encryption: Test Case #%0d FAILED", test_case_number);
		end

		// LoopBack Test No. 1
		/*************************************** Testing AES Encryption Integration ****************************************/

		$info("\n\n*~*~*~*~*~*~*~*~*~*~*~*~*~*~ Loop Back Test 1 *~*~*~*~*~*~*~*~*~*~*~*~");

		test_case_number = test_case_number + 1;

		// Enqueue all the 4 32-bit Data Packets  
		enqueue_rx_fifo (32'h7D8AE0F7); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (32'hCFA0A6CB); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (32'h09FB5D05); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (32'hA8EC586D); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("\n\nFIFO Full Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("\n\nFIFO Full Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'h7D8AE0F7CFA0A6CB09FB5D05A8EC586D)
		begin
			$info("Dequeue Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Dequeue Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		tb_dataPacketIn = tb_rx_data_out; // Using the Data from the RX_FIFO
		tb_Key = 128'h5E74E7BA66B0C7CC1B7697B3F9F51527;

		// When tb_encrypt_enable = 1'b1 => ENCRYPTION TASK 
		// And  tb_encrypt_enable = 1'b0 => DECRYPTION TASK
		tb_encrypt_enable = 1'b1;
		
		@(posedge tb_clk); // IDLE

		wait_for_encryption;

		if(tb_dataPacketOut == 128'hdeb0f81341f3503a7cd01e2bc7cdd556)
		begin
			$info("Encryption: Test Case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Encryption: Test Case #%0d FAILED", test_case_number);
		end

		/*************************************** Testing AES Decryption Integration ****************************************/

		test_case_number = test_case_number + 1;

		// Enqueue all the 4 32-bit Data Packets  
		enqueue_rx_fifo (tb_dataPacketOut[127:96]); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (tb_dataPacketOut[95:64]); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (tb_dataPacketOut[63:32]); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (tb_dataPacketOut[31:0]); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("FIFO Full Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("FIFO Full Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'hdeb0f81341f3503a7cd01e2bc7cdd556)
		begin
			$info("Dequeue Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Dequeue Test case #%0d FAILED", test_case_number);
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
			$info("Decryption: Test Case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Decryption: Test Case #%0d FAILED", test_case_number);
		end

		// LoopBack Test No. 2
		/*************************************** Testing AES Encryption Integration ****************************************/

		$info("\n\n*~*~*~*~*~*~*~*~*~*~*~*~*~*~ Loop Back Test 2 *~*~*~*~*~*~*~*~*~*~*~*~");

		test_case_number = test_case_number + 1;

		// Enqueue all the 4 32-bit Data Packets  
		enqueue_rx_fifo (32'hE6FEBF30); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (32'h133874EB); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (32'hCB49226C); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (32'hD36D0D4F); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("\n\nFIFO Full Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("\n\nFIFO Full Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'hE6FEBF30133874EBCB49226CD36D0D4F)
		begin
			$info("Dequeue Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Dequeue Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		tb_dataPacketIn = tb_rx_data_out; // Using the Data from the RX_FIFO
		tb_Key = 128'h33DE20E331BA5A525AB7C2495A767B5A;

		// When tb_encrypt_enable = 1'b1 => ENCRYPTION TASK 
		// And  tb_encrypt_enable = 1'b0 => DECRYPTION TASK
		tb_encrypt_enable = 1'b1;
		
		@(posedge tb_clk); // IDLE

		wait_for_encryption;

		if(tb_dataPacketOut == 128'h67928dd5470d4a11f0ea4ae7d49b2dd4)
		begin
			$info("Encryption: Test Case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Encryption: Test Case #%0d FAILED", test_case_number);
		end

		/*************************************** Testing AES Decryption Integration ****************************************/

		test_case_number = test_case_number + 1;

		// Enqueue all the 4 32-bit Data Packets  
		enqueue_rx_fifo (tb_dataPacketOut[127:96]); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (tb_dataPacketOut[95:64]); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (tb_dataPacketOut[63:32]); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (tb_dataPacketOut[31:0]); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("FIFO Full Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("FIFO Full Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'h67928dd5470d4a11f0ea4ae7d49b2dd4)
		begin
			$info("Dequeue Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Dequeue Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		tb_dataPacketIn = tb_rx_data_out; // Using the Data from the RX_FIFO
		tb_Key = 128'h33DE20E331BA5A525AB7C2495A767B5A;

		// When tb_encrypt_enable = 1'b1 => ENCRYPTION TASK 
		// And  tb_encrypt_enable = 1'b0 => DECRYPTION TASK
		tb_encrypt_enable = 1'b0;
		
		@(posedge tb_clk); // IDLE

		wait_for_decryption;

		if(tb_dataPacketOut == 128'hE6FEBF30133874EBCB49226CD36D0D4F)
		begin
			$info("Decryption: Test Case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Decryption: Test Case #%0d FAILED", test_case_number);
		end

		// Loop Back Test 3
		/*************************************** Testing AES Encryption Integration ****************************************/

		$info("\n\n*~*~*~*~*~*~*~*~*~*~*~*~*~*~ Loop Back Test 3 ~*~*~*~*~*~*~*~*~*~*~*~*~*");

		test_case_number = test_case_number + 1;

		// Enqueue all the 4 32-bit Data Packets  
		enqueue_rx_fifo (32'hBA81B9A3); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (32'h1A55ED31); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (32'h6B37F79C); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (32'hCF9A205A); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("\n\nFIFO Full Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("\n\nFIFO Full Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'hBA81B9A31A55ED316B37F79CCF9A205A)
		begin
			$info("Dequeue Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Dequeue Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		tb_dataPacketIn = tb_rx_data_out; // Using the Data from the RX_FIFO
		tb_Key = 128'h3191574B5B8317804948D8AE84FD3750;

		// When tb_encrypt_enable = 1'b1 => ENCRYPTION TASK 
		// And  tb_encrypt_enable = 1'b0 => DECRYPTION TASK
		tb_encrypt_enable = 1'b1;
		
		@(posedge tb_clk); // IDLE

		wait_for_encryption;

		if(tb_dataPacketOut == 128'hF2F6D7B98CC234003195112DF5A801D2)
		begin
			$info("Encryption: Test Case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Encryption: Test Case #%0d FAILED", test_case_number);
		end

		/*************************************** Testing AES Decryption Integration ****************************************/

		test_case_number = test_case_number + 1;

		// Enqueue all the 4 32-bit Data Packets  
		enqueue_rx_fifo (tb_dataPacketOut[127:96]); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (tb_dataPacketOut[95:64]); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (tb_dataPacketOut[63:32]); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (tb_dataPacketOut[31:0]); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("FIFO Full Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("FIFO Full Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'hF2F6D7B98CC234003195112DF5A801D2)
		begin
			$info("Dequeue Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Dequeue Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		tb_dataPacketIn = tb_rx_data_out; // Using the Data from the RX_FIFO
		tb_Key = 128'h3191574B5B8317804948D8AE84FD3750;

		// When tb_encrypt_enable = 1'b1 => ENCRYPTION TASK 
		// And  tb_encrypt_enable = 1'b0 => DECRYPTION TASK
		tb_encrypt_enable = 1'b0;
		
		@(posedge tb_clk); // IDLE

		wait_for_decryption;

		if(tb_dataPacketOut == 128'hBA81B9A31A55ED316B37F79CCF9A205A)
		begin
			$info("Decryption: Test Case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Decryption: Test Case #%0d FAILED", test_case_number);
		end

		// Resetting the Top Level DUT once again
		reset_dut;

		// Loop Back Test 4

		$info("\n\n*~*~*~*~*~*~*~*~*~*~*~*~*~*~ Loop Back Test 4 ~*~*~*~*~*~*~*~*~*~*~*~*~*\n\n");

		test_case_number = test_case_number + 1;

		/*************************************** Testing AES Encryption Integration ****************************************/

		// Enqueue all the 4 32-bit Data Packets
		enqueue_rx_fifo (32'h30517918); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (32'h608B23AB); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (32'h28D65F9B); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (32'hD4B37D29); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("\n\nFIFO Full Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("\n\nFIFO Full Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'h30517918608B23AB28D65F9BD4B37D29)
		begin
			$info("Dequeue Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Dequeue Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		tb_dataPacketIn = tb_rx_data_out; // Using the Data from the RX_FIFO
		tb_Key = 128'h347F9E3C7593ADC95FF5DC7F2DA9D3D5;

		// When tb_encrypt_enable = 1'b1 => ENCRYPTION TASK 
		// And  tb_encrypt_enable = 1'b0 => DECRYPTION TASK
		tb_encrypt_enable = 1'b1;
		
		@(posedge tb_clk); // IDLE

		wait_for_encryption;

		if(tb_dataPacketOut == 128'hE5728B4704F72A6689E3DA19EFB22A87)
		begin
			$info("Encryption: Test Case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Encryption: Test Case #%0d FAILED", test_case_number);
		end

		/*************************************** Testing AES Decryption Integration ****************************************/

		test_case_number = test_case_number + 1;

		// Enqueue all the 4 32-bit Data Packets  
		enqueue_rx_fifo (tb_dataPacketOut[127:96]); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (tb_dataPacketOut[95:64]); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (tb_dataPacketOut[63:32]); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (tb_dataPacketOut[31:0]); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("FIFO Full Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("FIFO Full Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'hE5728B4704F72A6689E3DA19EFB22A87)
		begin
			$info("Dequeue Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Dequeue Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		tb_dataPacketIn = tb_rx_data_out; // Using the Data from the RX_FIFO
		tb_Key = 128'h347F9E3C7593ADC95FF5DC7F2DA9D3D5;

		// When tb_encrypt_enable = 1'b1 => ENCRYPTION TASK 
		// And  tb_encrypt_enable = 1'b0 => DECRYPTION TASK
		tb_encrypt_enable = 1'b0;
		
		@(posedge tb_clk); // IDLE

		wait_for_decryption;

		if(tb_dataPacketOut == 128'h30517918608B23AB28D65F9BD4B37D29)
		begin
			$info("Decryption: Test Case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Decryption: Test Case #%0d FAILED", test_case_number);
		end

		// Loop Back Test 5

		$info("\n\n*~*~*~*~*~*~*~*~*~*~*~*~*~*~ Loop Back Test 5 ~*~*~*~*~*~*~*~*~*~*~*~*~*\n\n");

		test_case_number = test_case_number + 1;

		/*************************************** Testing AES Encryption Integration ****************************************/

		// Enqueue all the 4 32-bit Data Packets
		enqueue_rx_fifo (32'h99B49DF5); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (32'hBFF455D7); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (32'hCEC06148); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (32'hD671C890); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("\n\nFIFO Full Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("\n\nFIFO Full Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'h99B49DF5BFF455D7CEC06148D671C890)
		begin
			$info("Dequeue Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Dequeue Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		tb_dataPacketIn = tb_rx_data_out; // Using the Data from the RX_FIFO
		tb_Key = 128'h10FCBF612C99C84F4200831C21DF163E;

		// When tb_encrypt_enable = 1'b1 => ENCRYPTION TASK 
		// And  tb_encrypt_enable = 1'b0 => DECRYPTION TASK
		tb_encrypt_enable = 1'b1;
		
		@(posedge tb_clk); // IDLE

		wait_for_encryption;

		if(tb_dataPacketOut == 128'h20E9A382C73090D90D051C66A50F0879)
		begin
			$info("Encryption: Test Case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Encryption: Test Case #%0d FAILED", test_case_number);
		end

		/*************************************** Testing AES Decryption Integration ****************************************/

		test_case_number = test_case_number + 1;

		// Enqueue all the 4 32-bit Data Packets  
		enqueue_rx_fifo (tb_dataPacketOut[127:96]); // Enqueue 32 Bit Data Packet 1
		enqueue_rx_fifo (tb_dataPacketOut[95:64]); // Enqueue 32 Bit Data Packet 2
		enqueue_rx_fifo (tb_dataPacketOut[63:32]); // Enqueue 32 Bit Data Packet 3
		enqueue_rx_fifo (tb_dataPacketOut[31:0]); // Enqueue 32 Bit Data Packet 4

		if(tb_rx_fifo_full == 1'b1)
		begin
			$info("FIFO Full Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("FIFO Full Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		// Dequeue all the 32-bit data packets
		dequeue_rx_fifo;

		if(tb_rx_data_out == 128'h20E9A382C73090D90D051C66A50F0879)
		begin
			$info("Dequeue Test case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Dequeue Test case #%0d FAILED", test_case_number);
		end

		test_case_number = test_case_number + 1;

		tb_dataPacketIn = tb_rx_data_out; // Using the Data from the RX_FIFO
		tb_Key = 128'h10FCBF612C99C84F4200831C21DF163E;

		// When tb_encrypt_enable = 1'b1 => ENCRYPTION TASK 
		// And  tb_encrypt_enable = 1'b0 => DECRYPTION TASK
		tb_encrypt_enable = 1'b0;
		
		@(posedge tb_clk); // IDLE

		wait_for_decryption;

		if(tb_dataPacketOut == 128'h99B49DF5BFF455D7CEC06148D671C890)
		begin
			$info("Decryption: Test Case #%0d PASSED", test_case_number);
		end
		else
		begin
			$error("Decryption: Test Case #%0d FAILED", test_case_number);
		end
	end

endmodule 