// $Id: $
// File name:   KeySchedule.sv
// Created:     3/14/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the Key Schedule for both the AES Encryption and Decryption"

module KeySchedule
(
	input wire [127:0] encryptKey,
	output wire [1407:0] roundKeys
);
		
	reg [127:0] roundKey0, roundKey1, roundKey2, roundKey3, roundKey4, roundKey5, roundKey6, roundKey7, roundKey8, roundKey9, roundKey10;  

	assign roundKey0 = encryptKey;

	// Round Key 1
	roundKey ROUND_KEY_1(
				.inputKey(roundKey0),
			      	.count(4'b0000),
			      	.outputRoundKey(roundKey1)
			    );

	// Round Key 2
	roundKey ROUND_KEY_2(
				.inputKey(roundKey1),
			      	.count(4'b0001),
			      	.outputRoundKey(roundKey2)
			    );

	// Round Key 3
	roundKey ROUND_KEY_3(
				.inputKey(roundKey2),
			      	.count(4'b0010),
			      	.outputRoundKey(roundKey3)
			    );

	// Round Key 4
	roundKey ROUND_KEY_4( 
				.inputKey(roundKey3),
			      	.count(4'b0011),
			      	.outputRoundKey(roundKey4)
			    );

	// Round Key 5
	roundKey ROUND_KEY_5( 
				.inputKey(roundKey4),
			      	.count(4'b0100),
			      	.outputRoundKey(roundKey5)
			    );

	// Round Key 6
	roundKey ROUND_KEY_6( 
				.inputKey(roundKey5),
			      	.count(4'b0101),
			      	.outputRoundKey(roundKey6)
			    );

	// Round Key 7
	roundKey ROUND_KEY_7( 	
				.inputKey(roundKey6),
			      	.count(4'b0110),
			      	.outputRoundKey(roundKey7)
			    );

	// Round Key 8
	roundKey ROUND_KEY_8( 
				.inputKey(roundKey7),
			      	.count(4'b0111),
			      	.outputRoundKey(roundKey8)
			    );

	// Round Key 9
	roundKey ROUND_KEY_9( 
				.inputKey(roundKey8),
			      	.count(4'b1000),
			      	.outputRoundKey(roundKey9)
			    );

	// Round Key 10
	roundKey ROUND_KEY_10( 
				.inputKey(roundKey9),
	                        .count(4'b1001),
	                        .outputRoundKey(roundKey10)
 			     );

	assign roundKeys = { roundKey10, roundKey9, roundKey8, roundKey7, roundKey6, roundKey5, roundKey4, roundKey3, roundKey2, roundKey1, roundKey0 };
	
endmodule 