// $Id: $
// File name:   encryption_block.sv
// Created:     2/8/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is a top-level module for the AES Encryption Block"
module encryption_block (
	input wire [127:0] inputData,
	output wire [127:0] outputData
);

	// Signals for ByteSubstitution Layer
	reg [127:0] byteSubData;

	// Signals for the Diffusion Layer
	// shiftRows
	reg [127:0] shiftRowData;

	SBox SBOX_I (
			.inputData(inputData), 
			.byteSubData(byteSubData)
		    );

	shiftRows SHIFT_ROWS ( 
				.byteSData(byteSubData), 
				.shiftRowData(shiftRowData)
			     );

	mix_columns MIX_COLUMNS( 
					.dataIn(shiftRowData),
					.enable(1'b1),
					.dataOut(outputData) 
				);

endmodule 