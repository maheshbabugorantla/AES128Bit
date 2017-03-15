// $Id: $
// File name:   KeySchedule.sv
// Created:     3/14/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the Key Schedule for both the AES Encryption and Decryption"

module KeySchedule
(
	input wire clk,
	input wire [127:0] encryptKey,
	output wire [1407:0] roundKeys,
	output wire done
);
		
	reg [31:0] word4, word8, word12, word16, word20, word24, word28, word32, word36, word40; // Every Fourth Word
	reg [31:0] word3, word7, word11, word15, word19, word23, word27, word31, word35, word39; // Every Third Word	
	
	assign roundKeys[127:0] = encryptKey; // Round Key 0

	// Round Key 1
	assign word3 = encryptKey[127:96];
	
	reg [31:0] word14, word5, word6; 

	g_func_key_expansion G_FUNC_1 (
					 .inputWord(word3),
					 .count(4'b0001),
					 .outputWord(word4)
				      );

	assign word14 = word4 ^ encryptKey[31:0]; // XOR with First Word of Zeroeth Round and g(word3)
	assign word5 = word14 ^ encryptKey[63:32];
	assign word6 = word5 ^ encryptKey[95:64];
	assign word7 = word6 ^ word3;

	// Round Key 2
	
	// Round Key 3

	// Round Key 4

	// Round Key 5

	// Round Key 6

	// Round Key 7

	// Round Key 8

	// Round Key 9

	// Round Key 10

	// This is a signal to the Encryptor Controller that the Key Schedule is done generating all the 11 round keys needed
	assign done = 1;

endmodule 