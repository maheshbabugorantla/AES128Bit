// $Id: $
// File name:   inv_subBytes.sv
// Created:     3/13/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is used to perform the inverse of Byte Substitution for AES Decryption
// "

module inv_subBytes
(
	input wire [127:0] inputData,
	output wire [127:0] byteSubData
);

	genvar index;

	generate
		for(index = 0; index <= 120; index++)
		begin
			inv_sbox_unit INV_SBOX_UNIT( .inputByte(inputData[index + 7 : index]), .invByteSOut(byteSubData[index + 7 : index]) );
		end
	endgenerate

endmodule 