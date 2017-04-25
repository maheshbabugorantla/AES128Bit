// $Id: $
// File name:   decryption_block.sv
// Created:     3/17/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is a top-level module for the AES 128-Bit Decryption Block"

module decryption_block
(
	input wire clk,
	input wire n_rst,
	input wire decryptEnable,
	input wire [127:0] key,
	input wire [127:0] inputData,
	output reg [127:0] outputData,
	output wire decryptionDone
);

	// Intermediate Input Data Buffer
	reg [127:0] tempInputData;

	// Signals for Inverse Byte Substitution Layer
	reg [127:0] InvByteSubData;

	// Signals for the Inverse Diffusion Layer
	// Inverse Shift Rows
	reg [127:0] InvShiftRowData;

	// Inverse Mix Columns
	reg [127:0] mix_cols_Out;

	// Key Schedule Layer/Module
	reg [1407:0] roundKeys;

	// Flex Counter Module
	reg [3:0] count;
	reg rollover_flag;

	// Decryption Controller
	reg inv_sub_bytes_enable;
	reg inv_shift_rows_enable;
	reg inv_mix_cols_enable;
	reg inv_key_addition_enable;
	reg start;
	reg clear;
	reg count_enable;
	reg control_output;
	reg [127:0] decryptedOutput;
	reg done;

	// Key Addition Block
	reg [127:0] tempOutputData; // Input
	reg [127:0] tempOutputData1; // Output

	// Inputs to registers
	reg [127:0] tempOutputData2;
	reg [127:0] tempOutputData3;

	// Inverse Substitution Block Module
	inv_subBytes INV_SBOX
			(
				.inputData(InvShiftRowData),
				.enable(inv_sub_bytes_enable),
				.invByteSubData(InvByteSubData)
			);

	// Inverse Shift Rows Module
	inv_shiftRows INV_SHIFT_ROWS
			(
				.invByteSData(mix_cols_Out),
				.enable(inv_shift_rows_enable),
				.invShiftRowData(InvShiftRowData)
			);

	// Inverse Mix Columns Module
	inverse_mix_columns INV_MIX_COLUMNS
			(
				.invDataIn(tempOutputData1),
				.enable(inv_mix_cols_enable),
				.invDataOut(mix_cols_Out)
			);

	// Counter Logic
	flex_counter #(4) COUNTER_TEN
			(
				.clk(clk),
				.n_rst(n_rst),
				.clear(clear),
				.count_enable(count_enable),
				.rollover_val(4'b1101),
				.count_out(count),
				.rollover_flag(rollover_flag)
			);

	// Generate Key Expansion Array
	KeySchedule KEY_SCHEDULE 
			(
				.encryptKey(key),
				.roundKeys(roundKeys)
			);

	// CONTROLLER FOR THE AES128 DECRYPTION
	decryption_controller DECRYPTION_CONTROLLER
			(
				.clk(clk),
				.n_rst(n_rst),
				.decryptEnable(decryptEnable),
				.count(count),
				.dataIn(InvByteSubData),
				.inv_mix_cols_enable(inv_mix_cols_enable),
				.inv_shift_rows_enable(inv_shift_rows_enable),
				.inv_sub_bytes_enable(inv_sub_bytes_enable),
				.inv_key_addition_enable(inv_key_addition_enable),
				.start(start),
				.clear(clear),
				.count_enable(count_enable),
				.control_output(control_output),
				.decryptedOutput(decryptedOutput),
				.done(done)
			);

	// Key Addition Block
	KeyAddition_dec KEY_ADDITION
			(
				.dataIn(tempOutputData),
				.count(4'b1011 - count),
				.roundKeys(roundKeys),
				.enable(inv_key_addition_enable),
				.dataOut(tempOutputData1)
			);

	always_ff@(posedge clk, negedge n_rst)
	begin
		if(n_rst == 0)
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
		if(n_rst == 0)
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
		tempInputData = (start == 1) ? inputData : InvByteSubData;

		tempOutputData2 = (control_output == 1) ? tempInputData : tempOutputData;

		tempOutputData3 = (done == 1) ? InvByteSubData : outputData;
	end

	assign decryptionDone = done;

endmodule 