// $Id: $
// File name:   roundKey.sv
// Created:     3/14/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This module is used to generate an individual round key for the Key Schedule"

module roundKey
(
	input wire [127:0] inputKey,
	input wire [3:0] count,
	output wire [127:0] outputRoundKey
);
	
	reg [31:0] temp_Word0;

	reg [31:0] word0, word1, word2, word3;

	// For the first Word in the New Round Key
	g_func_key_expansion G_FUNC (
					.inputWord(inputKey[31:0]),
					.count(count),
					.outputWord(temp_Word0)
				    );
	
	always_comb
	begin
		word0 = temp_Word0 ^ inputKey[127:96]; // 1st word of the new round key
	
		word1 = word0 ^ inputKey[95:64]; // 2nd Word of the New Round Key

		word2 = word1 ^ inputKey[63:32]; // 3rd Word of the New Round Key

		word3 = word2 ^ inputKey[31:0]; // 4th Word of the New Round Key	
	end

	assign outputRoundKey = {word0, word1, word2, word3};

endmodule 