// $Id: $
// File name:   gf_mul9.sv
// Created:     3/13/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is used to perform the multiplication with 9 in Galois Field"

module gf_mul9
(
	input wire [7:0] byte_in,
	output wire [7:0] byte_out
);

	assign byte_out = {byte_in[4], 
			   byte_in[3] ^ byte_in[7], 
                           byte_in[7] ^ byte_in[2] ^ byte_in[6], 
                           byte_in[5] ^ byte_in[1] ^ byte_in[6],
			   byte_in[5] ^ byte_in[0] ^ byte_in[7],
			   byte_in[6] ^ byte_in[7],
			   byte_in[6] ^ byte_in[5],
			   byte_in[5] } ^ byte_in;

endmodule 