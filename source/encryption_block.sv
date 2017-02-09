// $Id: $
// File name:   encryption_block.sv
// Created:     2/8/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is a top-level module for the AES Encryption Block"
module encryption_block (
	input wire clk,
	input wire nRst,
	input wire [127:0] inputData,
	input wire encryptEnable,
	output wire [127:0] encryptedData,
	output wire encryptionDone
);

	reg [127:0] nextEncryptedData;
	reg [127:0] currentEncryptedData;

	// Signals for ByteSubstitution Layer
	reg [127:0] byteSubData;

	// Signals for the Diffusion Layer
	// shiftRows
	reg [127:0] shiftRowData;	

	SBox SBOX_I (.inputData(inputData), .byteSubData(byteSubData));
	shiftRows SHIFT_ROWS (.byteSData(byteSubData), .shiftRowData(shiftRowData));

	always_ff@(posedge clk, negedge nRst)
	begin
		if(nRst == 0)
		begin
			currentEncryptedData <= '0;
		end
		else
		begin
			// So makes sure that the Encryption is done only when this signal is asserted HIGH
			if(encryptEnable == 1'b1)
			begin
				currentEncryptedData <= nextEncryptedData;
			end
		end
	end

	always_comb
	begin
		
	end

	assign encryptedData = currentEncryptedData;

endmodule 