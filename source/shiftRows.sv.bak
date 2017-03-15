// $Id: $
// File name:   shiftRows.sv
// Created:     2/8/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This Module is used to shiftRows as a part of Diffusion Layer."

module shiftRows
(
	input wire [127:0] byteSData,
	output wire [127:0] shiftRowData
);

//	assign shiftRowData[31:0] = {byteSData[127:120], byteSData[87:80], byteSData[47:40], byteSData[7:0]};
	assign shiftRowData[31:0] = {byteSData[7:0], byteSData[47:40], byteSData[87:80], byteSData[127:120]};
//	assign shiftRowData[63:32] = {byteSData[31:24], byteSData[119:112], byteSData[79:72], byteSData[39:32]};
	assign shiftRowData[63:32] = {byteSData[39:32], byteSData[79:72], byteSData[119:112], byteSData[31:24]};
//	assign shiftRowData[95:64] = {byteSData[63:56], byteSData[23:16], byteSData[111:104], byteSData[71:64]};
	assign shiftRowData[95:64] = {byteSData[71:64], byteSData[111:104], byteSData[23:16], byteSData[63:56]};
//	assign shiftRowData[127:96] = {byteSData[95:88], byteSData[55:48], byteSData[15:8], byteSData[103:96]};
	assign shiftRowData[127:96] = {byteSData[103:96], byteSData[15:8], byteSData[55:48], byteSData[95:88]};

endmodule 