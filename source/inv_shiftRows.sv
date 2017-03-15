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
	output wire [127:0] invShiftRowData
);

//	assign shiftRowData[31:0] = {invByteSData[127:120], invByteSData[87:80], invByteSData[47:40], invByteSData[7:0]};
	assign invShiftRowData[31:0] = {invByteSData[7:0], invByteSData[111:104], invByteSData[87:80], invByteSData[63:56]};
//	assign shiftRowData[63:32] = {invByteSData[31:24], invByteSData[119:112], invByteSData[79:72], invByteSData[39:32]};
	assign invShiftRowData[63:32] = {invByteSData[39:32], invByteSData[15:8], invByteSData[119:112], invByteSData[95:88]};
//	assign shiftRowData[95:64] = {invByteSData[63:56], invByteSData[23:16], invByteSData[111:104], invByteSData[71:64]};
	assign invShiftRowData[95:64] = {invByteSData[71:64], invByteSData[47:40], invByteSData[23:16], invByteSData[127:120]};
//	assign shiftRowData[127:96] = {invByteSData[95:88], invByteSData[55:48], invByteSData[15:8], invByteSData[103:96]};
	assign invShiftRowData[127:96] = {invByteSData[103:96], invByteSData[79:72], invByteSData[55:48], invByteSData[31:24]};

endmodule 