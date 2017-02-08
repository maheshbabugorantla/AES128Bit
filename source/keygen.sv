// $Id: $
// File name:   keygen.sv
// Created:     2/7/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This Block is used to generate random 128 bit keys for the AES"

module keygen 
#(
	parameter BIT_WIDTH = 128
)
(

	input wire [1:0] key_select,
	output wire [BIT_WIDTH - 1:0] encrypt_key 	
);

	



endmodule 