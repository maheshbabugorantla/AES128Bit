// $Id: $
// File name:   decryption_controller.sv
// Created:     3/15/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This is the main controller to orchestrate all the operations to perform the AES 128 Bit Decryption"

module decryption_controller
(
	input wire clk,
	input wire n_rst,
	input wire decryptEnable,
	input wire [3:0] count,
	input wire [127:0] dataIn,
	output wire inv_mix_cols_enable,
	output wire inv_shift_rows_enable,
	output wire inv_sub_bytes_enable,
	output wire start, 
	output wire clear,
	output wire count_enable,
	output wire control_output,
	output wire [127:0] decryptedOutput
);

	reg temp_sub_bytes_enable;
	reg temp_shift_rows_enable;
	reg temp_mix_cols_enable;
	reg temp_start;
	reg temp_clear;
	reg temp_count_enable;
	reg temp_control_output;
	reg [127:0] temp_encryptedOut;

	typedef enum reg [3:0]
	{
		IDLE,
	  	KEY_SCHEDULE,
		START,
		WAIT_1,
		ROUND_KEY,
		INV_MIX_COLUMN,
		INV_NO_MIX_COLUMN,
		CONTROL_OUTPUT,
		DECRYPT_OUT
	} stateType;	


	stateType currentState;
	stateType nextState;

	always_ff@(posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0)
		begin
			currentState <= IDLE;
		end
		else
		begin
			currentState <= nextState;
		end
	end

	// Next State Logic
	always_comb
	begin
nextState = currentState;

		case(currentState)

			IDLE:
			begin
				if(decryptEnable == 1'b1 && count != 4'b1010)
				begin
					nextState = KEY_SCHEDULE;
				end
				else
				begin
					nextState = IDLE;
				end
			end

			KEY_SCHEDULE:
			begin
				nextState = START;
			end

			START:
			begin
				nextState = WAIT_1;
			end

			WAIT_1:
			begin
				nextState = ROUND_KEY;
			end

			ROUND_KEY:
			begin
				if(count == 4'b0000)
				begin
					nextState = CONTROL_OUTPUT;
				end

				if(count >= 4'b0001 && count <= 4'b1000) // Count >= 1 and Count <= 9
				begin
					nextState = MIX_COLUMN;
				end
				else if(count == 4'b1001) // Count == 10
				begin
					nextState = NO_MIX_COLUMN;
				end
				else if(count == 4'b1010)
				begin
					nextState = ENCRYPT_OUT;
				end
			end

			INV_MIX_COLUMN:
			begin
				nextState = CONTROL_OUTPUT;
			end

			INV_NO_MIX_COLUMN:
			begin
				nextState = CONTROL_OUTPUT;
			end

			CONTROL_OUTPUT:
			begin
				nextState = ROUND_KEY;
			end

			ENCRYPT_OUT:
			begin
				nextState = IDLE;
			end
			
			default:
			begin
				nextState = currentState;				
			end
			endcase

			if(count == 4'b1010)
			begin
				nextState = IDLE;
			end
	end

endmodule 