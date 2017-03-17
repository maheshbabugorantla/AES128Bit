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
	output wire [127:0] invByteSubData
);

	reg [127:0] tempInvByteSubData;

	genvar index;

	generate
		for(index = 0; index <= 120; index = index + 8)
		begin
			inv_sbox_unit INV_SBOX_UNIT(.inputByte(inputData[index + 7 : index]), .invByteSOut(tempInvByteSubData[index + 7 : index]));
		end
	endgenerate

	assign invByteSubData = tempInvByteSubData;

endmodule 