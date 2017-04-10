// $Id: $
// File name:   inv_shiftRows.sv
// Created:     3/13/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This module is used to perform the inversion of shift Rows operation for AES Decryption"

module inv_shiftRows
(
	input wire [127:0] invByteSData,
	input wire enable,
	output wire [127:0] invShiftRowData
);

	reg [127:0] tempOutputData;

	assign tempOutputData[127:96] = {invByteSData[127:120], invByteSData[23:16], invByteSData[47:40], invByteSData[71:64]};
	assign tempOutputData[95:64] = {invByteSData[95:88], invByteSData[119:112], invByteSData[15:8], invByteSData[39:32]};
	assign tempOutputData[63:32] = {invByteSData[63:56], invByteSData[87:80], invByteSData[111:104], invByteSData[7:0]};
	assign tempOutputData[31:0] = {invByteSData[31:24], invByteSData[55:48], invByteSData[79:72], invByteSData[103:96]};

	assign invShiftRowData = (enable == 1) ? tempOutputData : invByteSData;

endmodule 