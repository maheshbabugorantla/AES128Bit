// $Id: $
// File name:   mixColumns.sv
// Created:     2/25/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is used to implement the MixColumns part of the Diffusion Layer in AES"
module mixColumns 
(
	input wire [127:0] state_in, 
	output wire [127:0] state_out
);

  genvar i;

  reg [31:0] enc_row [0:3]; //Encryption values
   
  //This generate loop is used to create several always blocks that update the values
  //of the mixed columns every time the input state changes for encryption
  //Since the MixColumn operation operates on one column at at time, using this method
  //allows for a single loop to implement all of the column tranformations in parallel
  generate 
	for (i = 0; i < 4; i = i + 1)
	begin: gen_loop_enc
        // This is the algorithm defined in the Rijndael specification for computing the
        // MixColumn values, which is equivalent to the mulplication in GF(256)
	      
	      reg [31:0] r [0:3];

	      r[0] = state_in[31:0];
	      r[1] = state_in[63:32];
	      r[2] = state_in[95:64];
	      r[3] = state_in[127:96];
		
              // The registers to get the output from the GField_02
	      reg [7:0] byte_out_20;
	      reg [7:0] byte_out_21;
	      reg [7:0] byte_out_22;
	      reg [7:0] byte_out_23;
		
	      // The registers to get the output from the GField_03
	      reg [7:0] byte_out_30;	
	      reg [7:0] byte_out_31; 
	      reg [7:0] byte_out_32;
	      reg [7:0] byte_out_33;
		
	      GField_02 GF_02_I(.byte_in(r[0][((i + 1) * 8) - 1:(i * 8)]), .byte_out(byte_out_20));
	      GField_02 GF_02_II(.byte_in(r[1][((i + 1) * 8) - 1:(i * 8)]), .byte_out(byte_out_21));
	      GField_02 GF_02_III(.byte_in(r[2][((i + 1) * 8) - 1:(i * 8)]), .byte_out(byte_out_22));
	      GField_02 GF_02_IV(.byte_in(r[3][((i + 1) * 8) - 1:(i * 8)]), .byte_out(byte_out_23));

	      GField_03 GF_03_I(.byte_in(r[0][((i + 1) * 8) - 1:(i * 8)]), .byte_out(byte_out_30));
	      GField_03 GF_03_II(.byte_in(r[1][((i + 1) * 8) - 1:(i * 8)]), .byte_out(byte_out_31));
	      GField_03 GF_03_III(.byte_in(r[2][((i + 1) * 8) - 1:(i * 8)]), .byte_out(byte_out_32));
	      GField_03 GF_03_IV(.byte_in(r[3][((i + 1) * 8) - 1:(i * 8)]), .byte_out(byte_out_33));

              // Need to change the GField_02 and GField_03 to DUTs
	      enc_row[0][((i + 1) * 8) - 1:(i * 8)] = byte_out_20 ^ byte_out_31 ^ r[2][((i + 1) * 8) - 1:(i * 8)] ^ r[3][((i + 1) * 8) - 1:(i * 8)];
	      enc_row[1][((i + 1) * 8) - 1:(i * 8)] = r[0][((i + 1) * 8) - 1:(i * 8)] ^ byte_out_21 ^ byte_out_32 ^ r[3][((i + 1) * 8) - 1:(i * 8)];
	      enc_row[2][((i + 1) * 8) - 1:(i * 8)] = r[0][((i + 1) * 8) - 1:(i * 8)] ^ r[1][((i + 1) * 8) - 1:(i * 8)] ^ byte_out_22 ^ byte_out_33;
	      enc_row[3][((i + 1) * 8) - 1:(i * 8)] = byte_out_30 ^ r[1][((i + 1) * 8) - 1:(i * 8)] ^ r[2][((i + 1) * 8) - 1:(i * 8)] ^ byte_out_23;
	end
  endgenerate

  //It uses the values from enc_row if performing encryption
  assign state_out = {enc_row[3], enc_row[2], enc_row[1], enc_row[0]};
 
endmodule 