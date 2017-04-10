// $Id: $
// File name:   inverse_mix_columns.sv
// Created:     3/13/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This module is used to perform the inverse of mix_columns for AES-128 Decryption"

module inverse_mix_columns
(
	input wire [127:0] invDataIn,
	input wire enable,
	output wire [127:0] invDataOut
);

	reg[127:0] tempInvDataOut;

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

	// Getting the individual bytes
	assign {in_00, in_01, in_02, in_03} = invDataIn[31:0];
	assign {in_10, in_11, in_12, in_13} = invDataIn[63:32];
	assign {in_20, in_21, in_22, in_23} = invDataIn[95:64];
	assign {in_30, in_31, in_32, in_33} = invDataIn[127:96];

/***********************************************************************************/
	
	// First Mixed Column	
	reg [7:0] byte_out_e00;
	reg [7:0] byte_out_b00;
	reg [7:0] byte_out_d00;
	reg [7:0] byte_out_900;

	reg [7:0] byte_out_e01;
	reg [7:0] byte_out_b01;
	reg [7:0] byte_out_d01;
	reg [7:0] byte_out_901;

	reg [7:0] byte_out_e02;
	reg [7:0] byte_out_b02;
	reg [7:0] byte_out_d02;
	reg [7:0] byte_out_902;

	reg [7:0] byte_out_e03;
	reg [7:0] byte_out_b03;
	reg [7:0] byte_out_d03;
	reg [7:0] byte_out_903;


	gf_mulE GF_MULE00(.byte_in(in_00), .byte_out(byte_out_e00));
	gf_mulB GF_MULB00(.byte_in(in_01), .byte_out(byte_out_b00));	
	gf_mulD GF_MULD00(.byte_in(in_02), .byte_out(byte_out_d00));
	gf_mul9 GF_MUL900(.byte_in(in_03), .byte_out(byte_out_900));

	gf_mulE GF_MULE01(.byte_in(in_01), .byte_out(byte_out_e01));
	gf_mulB GF_MULB01(.byte_in(in_02), .byte_out(byte_out_b01));	
	gf_mulD GF_MULD01(.byte_in(in_03), .byte_out(byte_out_d01));
	gf_mul9 GF_MUL901(.byte_in(in_00), .byte_out(byte_out_901));

	gf_mulE GF_MULE02(.byte_in(in_02), .byte_out(byte_out_e02));
	gf_mulB GF_MULB02(.byte_in(in_03), .byte_out(byte_out_b02));	
	gf_mulD GF_MULD02(.byte_in(in_00), .byte_out(byte_out_d02));
	gf_mul9 GF_MUL902(.byte_in(in_01), .byte_out(byte_out_902));

	gf_mulE GF_MULE03(.byte_in(in_03), .byte_out(byte_out_e03));
	gf_mulB GF_MULB03(.byte_in(in_00), .byte_out(byte_out_b03));	
	gf_mulD GF_MULD03(.byte_in(in_01), .byte_out(byte_out_d03));
	gf_mul9 GF_MUL903(.byte_in(in_02), .byte_out(byte_out_903));

	// Putting the 1st Column together
	assign out_00 = byte_out_e00 ^ byte_out_b00 ^ byte_out_d00 ^ byte_out_900;
	assign out_01 = byte_out_901 ^ byte_out_e01 ^ byte_out_b01 ^ byte_out_d01;
	assign out_02 = byte_out_d02 ^ byte_out_902 ^ byte_out_e02 ^ byte_out_b02;
	assign out_03 = byte_out_b03 ^ byte_out_d03 ^ byte_out_903 ^ byte_out_e03;

	assign tempInvDataOut[31:0] = {out_00, out_01, out_02, out_03};

/***********************************************************************************/

	// Second Mixed Column	
	reg [7:0] byte_out_e10;
	reg [7:0] byte_out_b10;
	reg [7:0] byte_out_d10;
	reg [7:0] byte_out_910;

	reg [7:0] byte_out_e11;
	reg [7:0] byte_out_b11;
	reg [7:0] byte_out_d11;
	reg [7:0] byte_out_911;

	reg [7:0] byte_out_e12;
	reg [7:0] byte_out_b12;
	reg [7:0] byte_out_d12;
	reg [7:0] byte_out_912;

	reg [7:0] byte_out_e13;
	reg [7:0] byte_out_b13;
	reg [7:0] byte_out_d13;
	reg [7:0] byte_out_913;

	gf_mulE GF_MULE10(.byte_in(in_10), .byte_out(byte_out_e10));
	gf_mulB GF_MULB10(.byte_in(in_11), .byte_out(byte_out_b10));	
	gf_mulD GF_MULD10(.byte_in(in_12), .byte_out(byte_out_d10));
	gf_mul9 GF_MUL910(.byte_in(in_13), .byte_out(byte_out_910));

	gf_mulE GF_MULE11(.byte_in(in_11), .byte_out(byte_out_e11));
	gf_mulB GF_MULB11(.byte_in(in_12), .byte_out(byte_out_b11));	
	gf_mulD GF_MULD11(.byte_in(in_13), .byte_out(byte_out_d11));
	gf_mul9 GF_MUL911(.byte_in(in_10), .byte_out(byte_out_911));

	gf_mulE GF_MULE12(.byte_in(in_12), .byte_out(byte_out_e12));
	gf_mulB GF_MULB12(.byte_in(in_13), .byte_out(byte_out_b12));	
	gf_mulD GF_MULD12(.byte_in(in_10), .byte_out(byte_out_d12));
	gf_mul9 GF_MUL912(.byte_in(in_11), .byte_out(byte_out_912));

	gf_mulE GF_MULE13(.byte_in(in_13), .byte_out(byte_out_e13));
	gf_mulB GF_MULB13(.byte_in(in_10), .byte_out(byte_out_b13));	
	gf_mulD GF_MULD13(.byte_in(in_11), .byte_out(byte_out_d13));
	gf_mul9 GF_MUL913(.byte_in(in_12), .byte_out(byte_out_913));

	// Putting the 2nd Column Together
	assign out_10 = byte_out_e10 ^ byte_out_b10 ^ byte_out_d10 ^ byte_out_910;
	assign out_11 = byte_out_911 ^ byte_out_e11 ^ byte_out_b11 ^ byte_out_d11;
	assign out_12 = byte_out_d12 ^ byte_out_912 ^ byte_out_e12 ^ byte_out_b12;
	assign out_13 = byte_out_b13 ^ byte_out_d13 ^ byte_out_913 ^ byte_out_e13;

	assign tempInvDataOut[63:32] = {out_10, out_11, out_12, out_13};

/***********************************************************************************/

	// Third Mixed Column	
	reg [7:0] byte_out_e20;
	reg [7:0] byte_out_b20;
	reg [7:0] byte_out_d20;
	reg [7:0] byte_out_920;

	reg [7:0] byte_out_e21;
	reg [7:0] byte_out_b21;
	reg [7:0] byte_out_d21;
	reg [7:0] byte_out_921;

	reg [7:0] byte_out_e22;
	reg [7:0] byte_out_b22;
	reg [7:0] byte_out_d22;
	reg [7:0] byte_out_922;

	reg [7:0] byte_out_e23;
	reg [7:0] byte_out_b23;
	reg [7:0] byte_out_d23;
	reg [7:0] byte_out_923;

	gf_mulE GF_MULE20(.byte_in(in_20), .byte_out(byte_out_e20));
	gf_mulB GF_MULB20(.byte_in(in_21), .byte_out(byte_out_b20));	
	gf_mulD GF_MULD20(.byte_in(in_22), .byte_out(byte_out_d20));
	gf_mul9 GF_MUL920(.byte_in(in_23), .byte_out(byte_out_920));

	gf_mulE GF_MULE21(.byte_in(in_21), .byte_out(byte_out_e21));
	gf_mulB GF_MULB21(.byte_in(in_22), .byte_out(byte_out_b21));	
	gf_mulD GF_MULD21(.byte_in(in_23), .byte_out(byte_out_d21));
	gf_mul9 GF_MUL921(.byte_in(in_20), .byte_out(byte_out_921));

	gf_mulE GF_MULE22(.byte_in(in_22), .byte_out(byte_out_e22));
	gf_mulB GF_MULB22(.byte_in(in_23), .byte_out(byte_out_b22));	
	gf_mulD GF_MULD22(.byte_in(in_20), .byte_out(byte_out_d22));
	gf_mul9 GF_MUL922(.byte_in(in_21), .byte_out(byte_out_922));

	gf_mulE GF_MULE23(.byte_in(in_23), .byte_out(byte_out_e23));
	gf_mulB GF_MULB23(.byte_in(in_20), .byte_out(byte_out_b23));	
	gf_mulD GF_MULD23(.byte_in(in_21), .byte_out(byte_out_d23));
	gf_mul9 GF_MUL923(.byte_in(in_22), .byte_out(byte_out_923));

	// Putting the 3rd Column Together
	assign out_20 = byte_out_e20 ^ byte_out_b20 ^ byte_out_d20 ^ byte_out_920;
	assign out_21 = byte_out_921 ^ byte_out_e21 ^ byte_out_b21 ^ byte_out_d21;
	assign out_22 = byte_out_d22 ^ byte_out_922 ^ byte_out_e22 ^ byte_out_b22;
	assign out_23 = byte_out_b23 ^ byte_out_d23 ^ byte_out_923 ^ byte_out_e23;

	assign tempInvDataOut[95:64] = {out_20, out_21, out_22, out_23};

/***********************************************************************************/

	// Fourth Mixed Column	
	reg [7:0] byte_out_e30;
	reg [7:0] byte_out_b30;
	reg [7:0] byte_out_d30;
	reg [7:0] byte_out_930;

	reg [7:0] byte_out_e31;
	reg [7:0] byte_out_b31;
	reg [7:0] byte_out_d31;
	reg [7:0] byte_out_931;

	reg [7:0] byte_out_e32;
	reg [7:0] byte_out_b32;
	reg [7:0] byte_out_d32;
	reg [7:0] byte_out_932;

	reg [7:0] byte_out_e33;
	reg [7:0] byte_out_b33;
	reg [7:0] byte_out_d33;
	reg [7:0] byte_out_933;

	gf_mulE GF_MULE30(.byte_in(in_30), .byte_out(byte_out_e30));
	gf_mulB GF_MULB30(.byte_in(in_31), .byte_out(byte_out_b30));	
	gf_mulD GF_MULD30(.byte_in(in_32), .byte_out(byte_out_d30));
	gf_mul9 GF_MUL930(.byte_in(in_33), .byte_out(byte_out_930));

	gf_mulE GF_MULE31(.byte_in(in_31), .byte_out(byte_out_e31));
	gf_mulB GF_MULB31(.byte_in(in_32), .byte_out(byte_out_b31));	
	gf_mulD GF_MULD31(.byte_in(in_33), .byte_out(byte_out_d31));
	gf_mul9 GF_MUL931(.byte_in(in_30), .byte_out(byte_out_931));

	gf_mulE GF_MULE32(.byte_in(in_32), .byte_out(byte_out_e32));
	gf_mulB GF_MULB32(.byte_in(in_33), .byte_out(byte_out_b32));	
	gf_mulD GF_MULD32(.byte_in(in_30), .byte_out(byte_out_d32));
	gf_mul9 GF_MUL932(.byte_in(in_31), .byte_out(byte_out_932));

	gf_mulE GF_MULE33(.byte_in(in_33), .byte_out(byte_out_e33));
	gf_mulB GF_MULB33(.byte_in(in_30), .byte_out(byte_out_b33));	
	gf_mulD GF_MULD33(.byte_in(in_31), .byte_out(byte_out_d33));
	gf_mul9 GF_MUL933(.byte_in(in_32), .byte_out(byte_out_933));

	// Putting the 4th Column Together
	assign out_30 = byte_out_e30 ^ byte_out_b30 ^ byte_out_d30 ^ byte_out_930;
	assign out_31 = byte_out_931 ^ byte_out_e31 ^ byte_out_b31 ^ byte_out_d31;
	assign out_32 = byte_out_d32 ^ byte_out_932 ^ byte_out_e32 ^ byte_out_b32;
	assign out_33 = byte_out_b33 ^ byte_out_d33 ^ byte_out_933 ^ byte_out_e33;

	assign tempInvDataOut[127:96] = {out_30, out_31, out_32, out_33};

/***********************************************************************************/

	assign invDataOut = (enable == 1) ? tempInvDataOut : invDataIn;

endmodule 