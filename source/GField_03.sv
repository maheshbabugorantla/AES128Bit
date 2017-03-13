// $Id: $
// File name:   GField_03.sv
// Created:     2/28/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the LUT for the Multiplcation with 3 over Galois Field => This is mainly used in mixColumns.sv and invMixColumns.sv modules"

module GField_03
(
	input wire [7:0] byte_in,
	output reg [7:0] byte_out
);

	always_comb
	begin
		case(byte_in)

		      	8'h00 : byte_out = 8'h00;
		      	8'h01 : byte_out = 8'h03;
		      	8'h02 : byte_out = 8'h06;
		      	8'h03 : byte_out = 8'h05;
		      	8'h04 : byte_out = 8'h0C;
		      	8'h05 : byte_out = 8'h0F;
		      	8'h06 : byte_out = 8'h0A;
		      	8'h07 : byte_out = 8'h09;
		      	8'h08 : byte_out = 8'h18;
		      	8'h09 : byte_out = 8'h1B;
		      	8'h0A : byte_out = 8'h1E;
		      	8'h0B : byte_out = 8'h1D;
		      	8'h0C : byte_out = 8'h14;
		      	8'h0D : byte_out = 8'h17;
		      	8'h0E : byte_out = 8'h12;
		      	8'h0F : byte_out = 8'h11;
		      	8'h10 : byte_out = 8'h30;
		      	8'h11 : byte_out = 8'h33;
		      	8'h12 : byte_out = 8'h36;
		      	8'h13 : byte_out = 8'h35;
		      	8'h14 : byte_out = 8'h3C;
		      	8'h15 : byte_out = 8'h3F;
		      	8'h16 : byte_out = 8'h3A;
		      	8'h17 : byte_out = 8'h39;
		      	8'h18 : byte_out = 8'h28;
		      	8'h19 : byte_out = 8'h2B;
		      	8'h1A : byte_out = 8'h2E;
		      	8'h1B : byte_out = 8'h2D;
		      	8'h1C : byte_out = 8'h24;
		      	8'h1D : byte_out = 8'h27;
		      	8'h1E : byte_out = 8'h22;
		      	8'h1F : byte_out = 8'h21;
		      	8'h20 : byte_out = 8'h60;
		      	8'h21 : byte_out = 8'h63;
		      	8'h22 : byte_out = 8'h66;
		      	8'h23 : byte_out = 8'h65;
		      	8'h24 : byte_out = 8'h6C;
		      	8'h25 : byte_out = 8'h6F;
		      	8'h26 : byte_out = 8'h6A;
		      	8'h27 : byte_out = 8'h69;
		      	8'h28 : byte_out = 8'h78;
		      	8'h29 : byte_out = 8'h7B;
		      	8'h2A : byte_out = 8'h7E;
		      	8'h2B : byte_out = 8'h7D;
		      	8'h2C : byte_out = 8'h74;
		      	8'h2D : byte_out = 8'h77;
		      	8'h2E : byte_out = 8'h72;
		      	8'h2F : byte_out = 8'h71;
		      	8'h30 : byte_out = 8'h50;
		      	8'h31 : byte_out = 8'h53;
		      	8'h32 : byte_out = 8'h56;
		      	8'h33 : byte_out = 8'h55;
		      	8'h34 : byte_out = 8'h5C;
		      	8'h35 : byte_out = 8'h5F;
		      	8'h36 : byte_out = 8'h5A;
		      	8'h37 : byte_out = 8'h59;
		      	8'h38 : byte_out = 8'h48;
		      	8'h39 : byte_out = 8'h4B;
		      	8'h3A : byte_out = 8'h4E;
		      	8'h3B : byte_out = 8'h4D;
		      	8'h3C : byte_out = 8'h44;
		      	8'h3D : byte_out = 8'h47;
		      	8'h3E : byte_out = 8'h42;
		      	8'h3F : byte_out = 8'h41;
		      	8'h40 : byte_out = 8'hC0;
		      	8'h41 : byte_out = 8'hC3;
		      	8'h42 : byte_out = 8'hC6;
		      	8'h43 : byte_out = 8'hC5;
		      	8'h44 : byte_out = 8'hCC;
		      	8'h45 : byte_out = 8'hCF;
		      	8'h46 : byte_out = 8'hCA;
		      	8'h47 : byte_out = 8'hC9;
		      	8'h48 : byte_out = 8'hD8;
		      	8'h49 : byte_out = 8'hDB;
		      	8'h4A : byte_out = 8'hDE;
		      	8'h4B : byte_out = 8'hDD;
		      	8'h4C : byte_out = 8'hD4;
		      	8'h4D : byte_out = 8'hD7;
		      	8'h4E : byte_out = 8'hD2;
		      	8'h4F : byte_out = 8'hD1;
		      	8'h50 : byte_out = 8'hF0;
		      	8'h51 : byte_out = 8'hF3;
		      	8'h52 : byte_out = 8'hF6;
		      	8'h53 : byte_out = 8'hF5;
		      	8'h54 : byte_out = 8'hFC;
		      	8'h55 : byte_out = 8'hFF;
		      	8'h56 : byte_out = 8'hFA;
		      	8'h57 : byte_out = 8'hF9;
		      	8'h58 : byte_out = 8'hE8;
		      	8'h59 : byte_out = 8'hEB;
		      	8'h5A : byte_out = 8'hEE;
		      	8'h5B : byte_out = 8'hED;
		      	8'h5C : byte_out = 8'hE4;
		      	8'h5D : byte_out = 8'hE7;
		      	8'h5E : byte_out = 8'hE2;
		      	8'h5F : byte_out = 8'hE1;
		      	8'h60 : byte_out = 8'hA0;
		      	8'h61 : byte_out = 8'hA3;
		      	8'h62 : byte_out = 8'hA6;
		      	8'h63 : byte_out = 8'hA5;
		      	8'h64 : byte_out = 8'hAC;
		      	8'h65 : byte_out = 8'hAF;
		      	8'h66 : byte_out = 8'hAA;
		      	8'h67 : byte_out = 8'hA9;
		      	8'h68 : byte_out = 8'hA8;
		      	8'h69 : byte_out = 8'hBB;
		      	8'h6A : byte_out = 8'hBE;
		      	8'h6B : byte_out = 8'hBD;
		      	8'h6C : byte_out = 8'hB4;
		      	8'h6D : byte_out = 8'hB7;
		      	8'h6E : byte_out = 8'hB2;
		      	8'h6F : byte_out = 8'hB1;
		      	8'h70 : byte_out = 8'h90;
		      	8'h71 : byte_out = 8'h93;
		      	8'h72 : byte_out = 8'h96;
		      	8'h73 : byte_out = 8'h95;
		      	8'h74 : byte_out = 8'h9C;
		      	8'h75 : byte_out = 8'h9F;
		      	8'h76 : byte_out = 8'h9A;
		      	8'h77 : byte_out = 8'h99;
		      	8'h78 : byte_out = 8'h88;
		      	8'h79 : byte_out = 8'h8B;
		      	8'h7A : byte_out = 8'h8E;
		      	8'h7B : byte_out = 8'h8D;
		      	8'h7C : byte_out = 8'h84;
		      	8'h7D : byte_out = 8'h87;
		      	8'h7E : byte_out = 8'h82;
		      	8'h7F : byte_out = 8'h81;
		      	8'h80 : byte_out = 8'h9B;
		      	8'h81 : byte_out = 8'h98;
		      	8'h82 : byte_out = 8'h9D;
		      	8'h83 : byte_out = 8'h9E;
		      	8'h84 : byte_out = 8'h97;
		      	8'h85 : byte_out = 8'h94;
		      	8'h86 : byte_out = 8'h91;
		      	8'h87 : byte_out = 8'h92;
		      	8'h88 : byte_out = 8'h83;
		      	8'h89 : byte_out = 8'h80;
		      	8'h8A : byte_out = 8'h85;
		      	8'h8B : byte_out = 8'h86;
		      	8'h8C : byte_out = 8'h8F;
		      	8'h8D : byte_out = 8'h8C;
		      	8'h8E : byte_out = 8'h89;
		      	8'h8F : byte_out = 8'h8A;
		      	8'h90 : byte_out = 8'hAB;
		      	8'h91 : byte_out = 8'hA8;
		      	8'h92 : byte_out = 8'hAD;
		      	8'h93 : byte_out = 8'hAE;
		      	8'h94 : byte_out = 8'hA7;
		      	8'h95 : byte_out = 8'hA4;
		      	8'h96 : byte_out = 8'hA1;
		      	8'h97 : byte_out = 8'hA2;
		      	8'h98 : byte_out = 8'hB3;
		      	8'h99 : byte_out = 8'hB0;
		      	8'h9A : byte_out = 8'hB5;
		      	8'h9B : byte_out = 8'hB6;
		      	8'h9C : byte_out = 8'hBF;
		      	8'h9D : byte_out = 8'hBC;
		      	8'h9E : byte_out = 8'hB9;
		      	8'h9F : byte_out = 8'hBA;
		      	8'hA0 : byte_out = 8'hFB;
		      	8'hA1 : byte_out = 8'hFF;
		      	8'hA2 : byte_out = 8'hFD;
		      	8'hA3 : byte_out = 8'hFE;
		      	8'hA4 : byte_out = 8'hF7;
		      	8'hA5 : byte_out = 8'hF4;
		      	8'hA6 : byte_out = 8'hF1;
		      	8'hA7 : byte_out = 8'hF2;
		      	8'hA8 : byte_out = 8'hE3;
		      	8'hA9 : byte_out = 8'hE0;
		      	8'hAA : byte_out = 8'hE5;
		      	8'hAB : byte_out = 8'hE6;
		      	8'hAC : byte_out = 8'hEF;
		      	8'hAD : byte_out = 8'hEC;
		      	8'hAE : byte_out = 8'hE9;
		      	8'hAF : byte_out = 8'hEA;
		      	8'hB0 : byte_out = 8'hCB;
		      	8'hB1 : byte_out = 8'hC8;
		      	8'hB2 : byte_out = 8'hCD;
		      	8'hB3 : byte_out = 8'hCE;
		      	8'hB4 : byte_out = 8'hC7;
		      	8'hB5 : byte_out = 8'hC4;
		      	8'hB6 : byte_out = 8'hC1;
		      	8'hB7 : byte_out = 8'hC2;
		      	8'hB8 : byte_out = 8'hD3;
		      	8'hB9 : byte_out = 8'hD0;
		      	8'hBA : byte_out = 8'hD5;
		      	8'hBB : byte_out = 8'hD6;
		      	8'hBC : byte_out = 8'hDF;
		      	8'hBD : byte_out = 8'hDC;
		      	8'hBE : byte_out = 8'hD9;
		      	8'hBF : byte_out = 8'hDA;
		      	8'hC0 : byte_out = 8'h5B;
		      	8'hC1 : byte_out = 8'h58;
		      	8'hC2 : byte_out = 8'h5D;
		      	8'hC3 : byte_out = 8'h5E;
		      	8'hC4 : byte_out = 8'h57;
		      	8'hC5 : byte_out = 8'h54;
		      	8'hC6 : byte_out = 8'h51;
		      	8'hC7 : byte_out = 8'h52;
		      	8'hC8 : byte_out = 8'h43;
		      	8'hC9 : byte_out = 8'h40;
		      	8'hCA : byte_out = 8'h45;
		      	8'hCB : byte_out = 8'h46;
		      	8'hCC : byte_out = 8'h4F;
		      	8'hCD : byte_out = 8'h4C;
		      	8'hCE : byte_out = 8'h49;
		      	8'hCF : byte_out = 8'h4A;
		      	8'hD0 : byte_out = 8'h6B;
	      		8'hD1 : byte_out = 8'h68;
			8'hD2 : byte_out = 8'h6D;
	      		8'hD3 : byte_out = 8'h6E;
	      		8'hD4 : byte_out = 8'h67;
	      		8'hD5 : byte_out = 8'h64;
	      		8'hD6 : byte_out = 8'h61;
	      		8'hD7 : byte_out = 8'h62;
	      		8'hD8 : byte_out = 8'h73;
	      		8'hD9 : byte_out = 8'h70;
	      		8'hDA : byte_out = 8'h75;
	      		8'hDB : byte_out = 8'h76;
	      		8'hDC : byte_out = 8'h7F;
	      		8'hDD : byte_out = 8'h7C;
	      		8'hDE : byte_out = 8'h79;
	      		8'hDF : byte_out = 8'h7A;
	      		8'hE0 : byte_out = 8'h3B;
	      		8'hE1 : byte_out = 8'h38;
	      		8'hE2 : byte_out = 8'h3D;
	      		8'hE3 : byte_out = 8'h3E;
	      		8'hE4 : byte_out = 8'h37;
	      		8'hE5 : byte_out = 8'h34;
	      		8'hE6 : byte_out = 8'h31;
	      		8'hE7 : byte_out = 8'h32;
	      		8'hE8 : byte_out = 8'h23;
	      		8'hE9 : byte_out = 8'h20;
	      		8'hEA : byte_out = 8'h25;
	      		8'hEB : byte_out = 8'h26;
	      		8'hEC : byte_out = 8'h2F;
	      		8'hED : byte_out = 8'h2C;
	      		8'hEE : byte_out = 8'h29;
	      		8'hEF : byte_out = 8'h2A;
	      		8'hF0 : byte_out = 8'h0B;
	      		8'hF1 : byte_out = 8'h08;
	      		8'hF2 : byte_out = 8'h0D;
	      		8'hF3 : byte_out = 8'h0E;
	      		8'hF4 : byte_out = 8'h07;
	      		8'hF5 : byte_out = 8'h04;
	      		8'hF6 : byte_out = 8'h01;
	      		8'hF7 : byte_out = 8'h02;
	      		8'hF8 : byte_out = 8'h13;
	      		8'hF9 : byte_out = 8'h10;
	      		8'hFA : byte_out = 8'h15;
	      		8'hFB : byte_out = 8'h16;
	      		8'hFC : byte_out = 8'h1F;
	      		8'hFD : byte_out = 8'h1C;
	      		8'hFE : byte_out = 8'h19;
	      		8'hFF : byte_out = 8'h1A;
		endcase
	end

endmodule 