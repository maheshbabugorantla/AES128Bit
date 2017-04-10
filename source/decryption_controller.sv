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
	output wire inv_key_addition_enable,
	output wire start, 
	output wire clear,
	output wire count_enable,
	output wire control_output,
	output wire [127:0] decryptedOutput,
	output reg done
);

	reg temp_inv_sub_bytes_enable;
	reg temp_inv_shift_rows_enable;
	reg temp_inv_mix_cols_enable;
	reg temp_inv_key_addition_enable;
	reg temp_start;
	reg temp_clear;
	reg temp_count_enable;
	reg temp_control_output;
	reg [127:0] temp_decryptedOut;

	typedef enum reg [3:0]
	{
		IDLE,
	  	KEY_SCHEDULE,
		START,
		WAIT_1,
		ROUND_KEY,
		INV_MIX_COLUMN,
		NO_INV_MIX_COLUMN,
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

				else if(count >= 4'b0010 && count <= 4'b1001) // Count >= 2 and Count <= 9
				begin
					nextState = INV_MIX_COLUMN;
				end
				else if(count == 4'b0001) // Count == 1
				begin
					nextState = NO_INV_MIX_COLUMN;
				end
				else if(count == 4'b1010)
				begin
					nextState = DECRYPT_OUT;
				end
			end

			INV_MIX_COLUMN:
			begin
				nextState = CONTROL_OUTPUT;
			end

			NO_INV_MIX_COLUMN:
			begin
				nextState = CONTROL_OUTPUT;
			end

			CONTROL_OUTPUT:
			begin
				nextState = ROUND_KEY;
			end

			DECRYPT_OUT:
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


	// Output Logic
	always_comb
	begin: OUTPUT_LOGIC

		temp_inv_sub_bytes_enable = 1'b0;
		temp_inv_shift_rows_enable = 1'b0;		
		temp_inv_mix_cols_enable = 1'b0;
		temp_start = 1'b0;
		temp_clear = 1'b0;
		temp_count_enable = 1'b0;
		temp_control_output = 1'b0;
		temp_decryptedOut = 128'h00000000000000000000000000000000;

		case(currentState)

			IDLE:
			begin
				temp_inv_sub_bytes_enable = 1'b0;
				temp_inv_shift_rows_enable = 1'b0;
				temp_inv_mix_cols_enable = 1'b0;
				temp_inv_key_addition_enable = 1'b0;
				temp_start = 1'b0;
				temp_clear = 1'b1;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;

				if(count == 4'b0000)
				begin
					temp_decryptedOut = 128'h00000000000000000000000000000000;
				end
			end

			KEY_SCHEDULE:
			begin
				temp_inv_sub_bytes_enable = 1'b0;
				temp_inv_shift_rows_enable = 1'b0;
				temp_inv_mix_cols_enable = 1'b0;
				temp_inv_key_addition_enable = 1'b0;
				temp_start = 1'b0;
				temp_clear = 1'b1;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;
				temp_decryptedOut = dataIn;
			end

			START:
			begin
				temp_inv_sub_bytes_enable = 1'b0;
				temp_inv_shift_rows_enable = 1'b0;
				temp_inv_mix_cols_enable = 1'b0;
				temp_inv_key_addition_enable = 1'b0;
				temp_start = 1'b1;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0; // 
				temp_control_output = 1'b1;
				temp_decryptedOut = dataIn;
			end

			WAIT_1:
			begin
				temp_inv_sub_bytes_enable = 1'b0;
				temp_inv_shift_rows_enable = 1'b0;
				temp_inv_mix_cols_enable = 1'b0;
				temp_inv_key_addition_enable = 1'b0;
				temp_start = 1'b1;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0; //
				temp_control_output = 1'b1;
				temp_decryptedOut = dataIn;
			end

			ROUND_KEY:
			begin

				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_decryptedOut = dataIn;
				temp_control_output = 1'b0;
				temp_count_enable = 1'b1;

				if(count == 4'b0000)
				begin
					temp_control_output = 1'b1;
				end

				else if(count == 4'b0001)
				begin
					temp_inv_sub_bytes_enable = 1'b1;
					temp_inv_shift_rows_enable = 1'b1;
					temp_inv_mix_cols_enable = 1'b0;
					temp_inv_key_addition_enable = 1'b1;
					temp_control_output = 1'b1;
//					temp_count_enable = 1'b0;
				end
				else if(count >= 4'b0010 && count <= 4'b1010)
				begin
					temp_inv_sub_bytes_enable = 1'b1; ///
					temp_inv_shift_rows_enable = 1'b1; ///
					temp_inv_mix_cols_enable = 1'b1; ///
					temp_inv_key_addition_enable = 1'b1;
					temp_control_output = 1'b1;
				end
				else if(count == 4'b1011)
				begin
					temp_inv_sub_bytes_enable = 1'b0;
					temp_inv_shift_rows_enable = 1'b0;
					temp_inv_mix_cols_enable = 1'b0;
					temp_inv_key_addition_enable = 1'b1;
					temp_control_output = 1'b1;
				end
			end

			INV_MIX_COLUMN:
			begin
				temp_inv_sub_bytes_enable = 1'b0;
				temp_inv_shift_rows_enable = 1'b0;
				temp_inv_mix_cols_enable = 1'b0;
				temp_inv_key_addition_enable = 1'b0;
				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;
				temp_decryptedOut = dataIn;
			end
	
			NO_INV_MIX_COLUMN:
			begin
				temp_inv_sub_bytes_enable = 1'b0;
				temp_inv_shift_rows_enable = 1'b0;
				temp_inv_mix_cols_enable = 1'b0;
				temp_inv_key_addition_enable = 1'b0;
				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;
				temp_decryptedOut = dataIn;
			end

			CONTROL_OUTPUT:
			begin
				temp_inv_sub_bytes_enable = 1'b0;
				temp_inv_shift_rows_enable = 1'b0;
				temp_inv_mix_cols_enable = 1'b0;
				temp_inv_key_addition_enable = 1'b0;
				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;
				temp_decryptedOut = dataIn;
			end

			DECRYPT_OUT:
			begin
				temp_inv_sub_bytes_enable = 1'b0;
				temp_inv_shift_rows_enable = 1'b0;
				temp_inv_mix_cols_enable = 1'b0;
				temp_inv_key_addition_enable = 1'b1;
				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;
				temp_decryptedOut = dataIn;
			end

			default:
			begin
				temp_inv_sub_bytes_enable = 1'b0;
				temp_inv_shift_rows_enable = 1'b0;
				temp_inv_mix_cols_enable = 1'b0;
				temp_inv_key_addition_enable = 1'b0;
				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;
				temp_decryptedOut = 128'h00000000000000000000000000000000;
			end
		endcase

		if(count == 4'b1011)
		begin
			done = 1;
			temp_clear = 1;
		end
		else
		begin
			done = 0;
		end
	end

	assign inv_sub_bytes_enable = temp_inv_sub_bytes_enable;
	assign inv_shift_rows_enable = temp_inv_shift_rows_enable;
	assign inv_mix_cols_enable = temp_inv_mix_cols_enable;
	assign inv_key_addition_enable = temp_inv_key_addition_enable;
	assign start = temp_start;
	assign clear = temp_clear;
	assign count_enable = temp_count_enable;
	assign control_output = temp_control_output;
	assign decryptedOut = (count == 4'b1010) ? temp_decryptedOut : 128'h00000000000000000000000000000000;

endmodule 