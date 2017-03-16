// $Id: $
// File name:   mix_columns.sv
// Created:     3/12/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This module is used to perform the mix columns section of the AES Encryption"

module mix_columns
(
	input wire [127:0] dataIn,
	input wire enable,
	output wire [127:0] dataOut
);
	
	// For first Column
	reg [7:0] in_00, in_01, in_02, in_03;
	reg [7:0] out_00, out_01, out_02, out_03;
	
	// For Second Column	  
	reg [7:0] in_10, in_11, in_12, in_13;
	reg [7:0] out_10, out_11, out_12, out_13;

	// For Third Column
	reg [7:0] in_20, in_21, in_22, in_23;
	reg [7:0] out_20, out_21, out_22, out_23;
	
	// For Fourth Column	  
	reg [7:0] in_30, in_31, in_32, in_33;
	reg [7:0] out_30, out_31, out_32, out_33;
	
	// Output
	reg [127:0] tempDataOut;

	// Getting the individual bytes
	assign {in_00, in_01, in_02, in_03} = dataIn[31:0];
	assign {in_10, in_11, in_12, in_13} = dataIn[63:32];
	assign {in_20, in_21, in_22, in_23} = dataIn[95:64];
	assign {in_30, in_31, in_32, in_33} = dataIn[127:96];

/***********************************************************************************/
	
	// First Mixed Column
	reg [7:0] byte_out_200;
	reg [7:0] byte_out_300;
	reg [7:0] byte_out_201;
	reg [7:0] byte_out_301;
	reg [7:0] byte_out_202;
	reg [7:0] byte_out_302;
	reg [7:0] byte_out_203;
	reg [7:0] byte_out_303;

	gf_mul2 GF_MUL200(.byte_in(in_00), .byte_out(byte_out_200));
	gf_mul3 GF_MUL300(.byte_in(in_01), .byte_out(byte_out_300));	

	gf_mul2 GF_MUL201(.byte_in(in_01), .byte_out(byte_out_201));
	gf_mul3 GF_MUL301(.byte_in(in_02), .byte_out(byte_out_301));

	gf_mul2 GF_MUL202(.byte_in(in_02), .byte_out(byte_out_202));
	gf_mul3 GF_MUL302(.byte_in(in_03), .byte_out(byte_out_302));

	gf_mul2 GF_MUL203(.byte_in(in_03), .byte_out(byte_out_203));
	gf_mul3 GF_MUL303(.byte_in(in_00), .byte_out(byte_out_303));

	// Putting the 1st Column together
	assign out_00 = byte_out_200 ^ byte_out_300 ^ in_02 ^ in_03;
	assign out_01 = in_00 ^ byte_out_201 ^ byte_out_301 ^ in_03;
	assign out_02 = in_00 ^ in_01 ^ byte_out_202 ^ byte_out_302;
	assign out_03 = byte_out_303 ^ in_01 ^ in_02 ^ byte_out_203;

	assign tempDataOut[31:0] = {out_00, out_01, out_02, out_03};

/***********************************************************************************/

	// Second Mixed Column
	reg [7:0] byte_out_210;
	reg [7:0] byte_out_310;
	reg [7:0] byte_out_211;
	reg [7:0] byte_out_311;
	reg [7:0] byte_out_212;
	reg [7:0] byte_out_312;
	reg [7:0] byte_out_213;
	reg [7:0] byte_out_313;

	gf_mul2 GF_MUL210(.byte_in(in_10), .byte_out(byte_out_210));
	gf_mul3 GF_MUL310(.byte_in(in_11), .byte_out(byte_out_310));	

	gf_mul2 GF_MUL211(.byte_in(in_11), .byte_out(byte_out_211));
	gf_mul3 GF_MUL311(.byte_in(in_12), .byte_out(byte_out_311));

	gf_mul2 GF_MUL212(.byte_in(in_12), .byte_out(byte_out_212));
	gf_mul3 GF_MUL312(.byte_in(in_13), .byte_out(byte_out_312));

	gf_mul2 GF_MUL213(.byte_in(in_13), .byte_out(byte_out_213));
	gf_mul3 GF_MUL313(.byte_in(in_10), .byte_out(byte_out_313));

	// Putting the 2nd Column together
	assign out_10 = byte_out_210 ^ byte_out_310 ^ in_12 ^ in_13;
	assign out_11 = in_10 ^ byte_out_211 ^ byte_out_311 ^ in_13;
	assign out_12 = in_10 ^ in_11 ^ byte_out_212 ^ byte_out_312;
	assign out_13 = byte_out_313 ^ in_11 ^ in_12 ^ byte_out_213;

	assign tempDataOut[63:32] = {out_10, out_11, out_12, out_13};

/***********************************************************************************/

	// Third Mixed Column
	reg [7:0] byte_out_220;
	reg [7:0] byte_out_320;
	reg [7:0] byte_out_221;
	reg [7:0] byte_out_321;
	reg [7:0] byte_out_222;
	reg [7:0] byte_out_322;
	reg [7:0] byte_out_223;
	reg [7:0] byte_out_323;

	gf_mul2 GF_MUL220(.byte_in(in_20), .byte_out(byte_out_220));
	gf_mul3 GF_MUL320(.byte_in(in_21), .byte_out(byte_out_320));	

	gf_mul2 GF_MUL221(.byte_in(in_21), .byte_out(byte_out_221));
	gf_mul3 GF_MUL321(.byte_in(in_22), .byte_out(byte_out_321));

	gf_mul2 GF_MUL222(.byte_in(in_22), .byte_out(byte_out_222));
	gf_mul3 GF_MUL322(.byte_in(in_23), .byte_out(byte_out_322));

	gf_mul2 GF_MUL223(.byte_in(in_23), .byte_out(byte_out_223));
	gf_mul3 GF_MUL323(.byte_in(in_20), .byte_out(byte_out_323));
	
	// Putting the 3rd Column together
	assign out_20 = byte_out_220 ^ byte_out_320 ^ in_22 ^ in_23;
	assign out_21 = in_20 ^ byte_out_221 ^ byte_out_321 ^ in_23;
	assign out_22 = in_20 ^ in_21 ^ byte_out_222 ^ byte_out_322;
	assign out_23 = byte_out_323 ^ in_21 ^ in_22 ^ byte_out_223;

	assign tempDataOut[95:64] = {out_20, out_21, out_22, out_23};

/***********************************************************************************/

	// Fourth Mixed Column
	reg [7:0] byte_out_230;
	reg [7:0] byte_out_330;
	reg [7:0] byte_out_231;
	reg [7:0] byte_out_331;
	reg [7:0] byte_out_232;
	reg [7:0] byte_out_332;
	reg [7:0] byte_out_233;
	reg [7:0] byte_out_333;

	gf_mul2 GF_MUL230(.byte_in(in_30), .byte_out(byte_out_230));
	gf_mul3 GF_MUL330(.byte_in(in_31), .byte_out(byte_out_330));	

	gf_mul2 GF_MUL231(.byte_in(in_31), .byte_out(byte_out_231));
	gf_mul3 GF_MUL331(.byte_in(in_32), .byte_out(byte_out_331));

	gf_mul2 GF_MUL232(.byte_in(in_32), .byte_out(byte_out_232));
	gf_mul3 GF_MUL332(.byte_in(in_33), .byte_out(byte_out_332));

	gf_mul2 GF_MUL233(.byte_in(in_33), .byte_out(byte_out_233));
	gf_mul3 GF_MUL333(.byte_in(in_30), .byte_out(byte_out_333));

	// Putting the 4th Column together
	assign out_30 = byte_out_230 ^ byte_out_330 ^ in_32 ^ in_33;
	assign out_31 = in_30 ^ byte_out_231 ^ byte_out_331 ^ in_33;
	assign out_32 = in_30 ^ in_31 ^ byte_out_232 ^ byte_out_332;
	assign out_33 = byte_out_333 ^ in_31 ^ in_32 ^ byte_out_233;

	assign tempDataOut[127:96] = {out_30, out_31, out_32, out_33};

/***********************************************************************************/

	assign dataOut = enable ? tempDataOut : dataIn;

endmodule 