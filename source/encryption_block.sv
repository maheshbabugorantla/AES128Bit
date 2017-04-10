// $Id: $
// File name:   encryption_block.sv
// Created:     2/8/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is a top-level module for the AES Encryption Block"
module encryption_block (
	input wire clk,
	input wire n_rst,
	input wire encryptEnable,
	input wire [127:0] key,
	input wire [127:0] inputData,
	output reg [127:0] outputData
);

	// Additional XOR Block
	reg [127:0] tempInputData;

	// Signals for ByteSubstitution Layer
	reg [127:0] byteSubData;

	// Signals for the Diffusion Layer
	// shiftRows
	reg [127:0] shiftRowData;

	// mix_columns module
	reg [127:0] mix_cols_Out;

	// KeySchedule module
	reg [1407:0] roundKeys;

	// flex_counter module
	reg [3:0] count;
	reg rollover_flag;

	// encryption_controller
	reg sub_bytes_enable;
	reg shift_rows_enable;
	reg mix_cols_enable;
	reg start;
	reg clear;
	reg count_enable;
	reg control_output;
	reg [127:0] encryptedOutput;	
	reg done;	

	// KeyAddition Block
	reg [127:0] tempOutputData;
	reg [127:0] tempOutputData1;
	reg [127:0] tempOutputData2;
	reg [127:0] tempOutputData3;

	// Substitution Box Module
	SBox SBOX_I 
			(
				.inputData(tempOutputData),
				.enable(sub_bytes_enable),
				.byteSubData(byteSubData)
			);

	// shiftRows Module
	shiftRows SHIFT_ROWS 
			( 
				.byteSData(byteSubData),
				.enable(shift_rows_enable),
				.shiftRowData(shiftRowData)
			);
	
	// Mix Columns Module
	mix_columns MIX_COLUMNS
			( 
				.dataIn(shiftRowData),
				.enable(mix_cols_enable),
				.dataOut(mix_cols_Out)
			);

	// Counter Logic
	flex_counter #(4) COUNTER_ELEVEN
			(
				.clk(clk),
				.n_rst(n_rst),
				.clear(clear),
				.count_enable(count_enable),
				.rollover_val(4'b1010),
				.count_out(count),
				.rollover_flag(rollover_flag)
			);
	
	// Generate Key Expansion Array
	KeySchedule KEY_SCHEDULE 
			(
				.encryptKey(key),
				.roundKeys(roundKeys)
			);

	// CONTROLLER FOR THE AES 128 ENCRYPTION
	encryption_controller ENCRYPTION_CONTROLLER
			(
				.clk(clk),
				.n_rst(n_rst),
				.encryptEnable(encryptEnable),
				.count(count),
				.dataIn(tempOutputData1),
				.mix_cols_enable(mix_cols_enable),
				.shift_rows_enable(shift_rows_enable),
				.sub_bytes_enable(sub_bytes_enable),
				.start(start),
				.clear(clear),
				.count_enable(count_enable),
				.control_output(control_output),
				.encryptedOut(encryptedOutput),
				.done(done)
			);

	// Key Addition Block
	KeyAddition KEY_ADDITION
			(
				.dataIn(mix_cols_Out),
				.count(count),
				.roundKeys(roundKeys),
				.dataOut(tempOutputData1)
			);
	
	always_ff@(posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0)
		begin
			tempOutputData <= '0;
		end
		else
		begin
			tempOutputData <= tempOutputData2;
		end
	end

	always_ff@(posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0)
		begin
			outputData <= '0;
		end
		else
		begin
			outputData <= tempOutputData3;
		end
	end
	
	always_comb
	begin
		tempInputData = (start == 1) ? inputData : tempOutputData1;

		tempOutputData2 = (control_output == 1) ? tempInputData : tempOutputData;

		tempOutputData3 = (done == 1) ? tempOutputData1 : outputData;
	end

endmodule 