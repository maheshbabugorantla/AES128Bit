// $Id: $
// File name:   s_box.sv
// Created:     2/7/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This module is used to implement the Byte Substitution Layer using an LUT.".

module s_box
(
	input wire [127:0] inputData,
	output wire [127:0] byteSubData
);
	reg [127:0] subByteData;

	reg [7:0] tempIn, tempOut;

	reg [6:0] index;

	sbox_unit SBOX_UNIT (.dataIn(tempIn), .byteSOut(tempOut));
	
	always_comb
	begin
		for(index = 0; index <= 120; index = index + 8)
		begin
			tempIn = inputData[index + 7:index];
			
			//subByteData[index + 7:index] = substitution_box[inputData[(index+7):(index+4)]][inputData[(index+3):index]];
		end
	end

	assign byteSubData = subByteData; // Byte Substituted Data

endmodule 
