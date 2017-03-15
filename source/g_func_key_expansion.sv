// $Id: $
// File name:   g_func_key_expansion.sv
// Created:     3/14/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the g() function used in the keySchedule to every 4th word in the keyExpansion Array"

module g_func_key_expansion
(
	input wire [31:0] inputWord,
	input wire [3:0] count,
	output wire [31:0] outputWord
);

	reg [31:0] tempOutput;
	
	// These are the RConstants used from the Rjindael's Wiki 
	// Because we need only constants from 1 - 10 as there are only 10 round in AES 128-bit encryption
	reg [7:0] R_Const [0:9] = {8'h01, 8'h02, 8'h04, 8'h08, 8'h10, 8'h20, 8'h40, 8'h80, 8'h1b, 8'h36};

	reg [7:0] byte_0, byte_1, byte_2, byte_3;	
	reg [31:0] round_constant;	


	// 1st Step
	// Perform a byte substitution for each byte of input the word
	sbox_unit SBOX_1(.dataIn(inputWord[7:0]), .byteSOut(byte_0));
	sbox_unit SBOX_2(.dataIn(inputWord[15:8]), .byteSOut(byte_1));
	sbox_unit SBOX_3(.dataIn(inputWord[23:16]), .byteSOut(byte_2));
	sbox_unit SBOX_4(.dataIn(inputWord[31:24]), .byteSOut(byte_3));

	always_comb
	begin
		// 2nd Step
		// Perform a one-byte left circular rotation on the argument 4-byte word
		tempOutput = {byte_2, byte_1, byte_0, byte_3};

		// 3rd Step
		// XOR the bytes obtained from the previous step with what is known as round constant
		// REMEMBER: The round constant is a word whose three rightmost bytes are always zero
		round_constant = {R_Const[count], 8'h00, 8'h00, 8'h00};
		tempOutput = tempOutput ^ round_constant;
	end

	assign outputWord = tempOutput;

endmodule 