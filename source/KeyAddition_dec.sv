// $Id: $
// File name:   KeyAddition.sv
// Created:     3/15/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the Key Addition block"

module KeyAddition_dec
(
	input wire [127:0] dataIn,
	input wire [3:0] count,
	input wire enable,
	input wire [1407:0] roundKeys,
	output wire [127:0] dataOut
);

	reg [127:0] roundKey;
	
	always_comb
	begin
		case(count)

			4'b0000:
			begin
				roundKey = roundKeys[127:0];			
			end

			4'b0001:
			begin
				roundKey = roundKeys[255:128];
			end

			4'b0010:
			begin
				roundKey = roundKeys[383:256];
			end

			4'b0011:
			begin
				roundKey = roundKeys[511:384];
			end

			4'b0100:
			begin
				roundKey = roundKeys[639:512];
			end

			4'b0101:
			begin
				roundKey = roundKeys[767:640];
			end

			4'b0110:
			begin
				roundKey = roundKeys[895:768];
			end

			4'b0111:
			begin
				roundKey = roundKeys[1023:896];
			end

			4'b1000:
			begin
				roundKey = roundKeys[1151:1024];
			end

			4'b1001:
			begin
				roundKey = roundKeys[1279:1152];
			end

			4'b1010:
			begin
				roundKey = roundKeys[1407:1280];
			end
			default:
			begin
				roundKey = 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
			end
		endcase
	end

	assign dataOut = (enable == 1) ? dataIn ^ roundKey : dataIn;

endmodule 