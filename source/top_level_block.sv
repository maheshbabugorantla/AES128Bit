// $Id: $
// File name:   top_level_block.sv
// Created:     4/11/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is whole TOP LEVEL BLOCK for the project"

module top_level_block
(
	input wire clk,
	input wire n_rst,
	input wire encrypt_enable, // This signal decides whether the input Data needs to be encrypted/decrypted
	input wire [127:0] dataPacketIn, // This will come from the RX_FIFO
	input wire [127:0] Key, // This is Key to encrypt/decrypt the data
	output wire [127:0] dataPacketOut // This will go to TX_FIFO
);

//	output wire encrypt_done, // Comes from the Encryption Done
//	output wire decrypt_done // Comes from the Decryption Done
//);
	
	// Signals for the Encryption Block
	reg [127:0] encryptedOutput;

	// Signal for the Decryption Block
	reg [127:0] decryptedOutput;

	// AES 128 Encryption Block
	encryption_block ENCRYPTION_BLK
	(
		.clk(clk),
		.n_rst(n_rst),
		.encryptEnable(encrypt_enable),
		.key(Key),
		.inputData(dataPacketIn),
		.outputData(encryptedOutput)
	);

	// AES 128 Decryption Block
	decryption_block DECRYPTION_BLK
	(
		.clk(clk),
		.n_rst(n_rst),
		.decryptEnable(~encrypt_enable),
		.key(Key),
		.inputData(dataPacketIn),
		.outputData(decryptedOutput)
	);

	assign dataPacketOut = (encrypt_enable == 1) ? encryptedOutput : decryptedOutput;

endmodule 