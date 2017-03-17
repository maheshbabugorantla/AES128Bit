// $Id: $
// File name:   encryption_controller.sv
// Created:     3/15/2017
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: "This the main controller to orchestrate all the operations to peform the AES 128 Bit Encryption Block"

module encryption_controller
(
	input wire clk,
	input wire n_rst,
	input wire encryptEnable,
	input wire [3:0] count,
	input wire [127:0] dataIn,
	output wire mix_cols_enable,
	output wire sub_bytes_enable,
	output wire shift_rows_enable,
	output wire start,
	output wire clear,
	output wire count_enable,
	output wire control_output,
	output wire [127:0] encryptedOut
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
		MIX_COLUMN,
		NO_MIX_COLUMN,
		CONTROL_OUTPUT,
		ENCRYPT_OUT
	} stateType;

	stateType currentState;
	stateType nextState;

	always_ff@(posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0 || count == 4'b1010)
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
	begin: NEXT_STATE
		
		nextState = currentState;

		case(currentState)

			IDLE:
			begin
				if(encryptEnable == 1'b1 && count != 4'b1010)
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

			MIX_COLUMN:
			begin
				nextState = CONTROL_OUTPUT;
			end

			NO_MIX_COLUMN:
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
	end

	// Output Logic
	always_comb
	begin: OUTPUT_LOGIC

		temp_sub_bytes_enable = 1'b0;
		temp_shift_rows_enable = 1'b0;		
		temp_mix_cols_enable = 1'b0;
		temp_start = 1'b0;
		temp_clear = 1'b0;
		temp_count_enable = 1'b0;
		temp_control_output = 1'b0;
		temp_encryptedOut = 128'h00000000000000000000000000000000;

		case(currentState)

			IDLE:
			begin
				temp_sub_bytes_enable = 1'b0;
				temp_shift_rows_enable = 1'b0;
				temp_mix_cols_enable = 1'b0;
				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;

				if(count == 4'b0000)
				begin
					temp_encryptedOut = 128'h00000000000000000000000000000000;
				end
			end

			KEY_SCHEDULE:
			begin
				temp_sub_bytes_enable = 1'b0;
				temp_shift_rows_enable = 1'b0;
				temp_mix_cols_enable = 1'b0;
				temp_start = 1'b0;
				temp_clear = 1'b1;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;
				temp_encryptedOut = dataIn;
			end

			START:
			begin
				temp_sub_bytes_enable = 1'b0;
				temp_shift_rows_enable = 1'b0;
				temp_mix_cols_enable = 1'b0;
				temp_start = 1'b1;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0; // 
				temp_control_output = 1'b1;
				temp_encryptedOut = dataIn;
			end

			WAIT_1:
			begin
				temp_sub_bytes_enable = 1'b0;
				temp_shift_rows_enable = 1'b0;
				temp_mix_cols_enable = 1'b0;
				temp_start = 1'b1;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0; //
				temp_control_output = 1'b1;
				temp_encryptedOut = dataIn;
			end

			ROUND_KEY:
			begin

				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_count_enable = 1'b1; //
				temp_encryptedOut = dataIn;
				temp_control_output = 1'b0;

				if(count == 4'b0000)
				begin
					temp_control_output = 1'b1;
				end

				if(count >= 4'b0001 && count <= 4'b1000)
				begin
					temp_sub_bytes_enable = 1'b1; ///
					temp_shift_rows_enable = 1'b1; ///
					temp_mix_cols_enable = 1'b1; ///
				end
				else
				begin
					temp_sub_bytes_enable = 1'b0;
					temp_shift_rows_enable = 1'b0;
					temp_mix_cols_enable = 1'b0;
				end
			end

			MIX_COLUMN:
			begin
				temp_sub_bytes_enable = 1'b1;
				temp_shift_rows_enable = 1'b1;
				temp_mix_cols_enable = 1'b1;
				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;
				temp_encryptedOut = dataIn;
			end
	
			NO_MIX_COLUMN:
			begin
				temp_sub_bytes_enable = 1'b1;
				temp_shift_rows_enable = 1'b1;
				temp_mix_cols_enable = 1'b0;
				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;
				temp_encryptedOut = dataIn;
			end

			CONTROL_OUTPUT:
			begin
				temp_sub_bytes_enable = 1'b1;
				temp_shift_rows_enable = 1'b1;
				temp_mix_cols_enable = 1'b1;
				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b1;
				temp_encryptedOut = dataIn;
			end

			ENCRYPT_OUT:
			begin
				temp_sub_bytes_enable = 1'b0;
				temp_shift_rows_enable = 1'b0;
				temp_mix_cols_enable = 1'b0;
				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;
				temp_encryptedOut = dataIn;
			end

			default:
			begin
				temp_sub_bytes_enable = 1'b0;
				temp_shift_rows_enable = 1'b0;
				temp_mix_cols_enable = 1'b0;
				temp_start = 1'b0;
				temp_clear = 1'b0;
				temp_count_enable = 1'b0;
				temp_control_output = 1'b0;
				temp_encryptedOut = 128'h00000000000000000000000000000000;
			end
		endcase
	end

	assign sub_bytes_enable = temp_sub_bytes_enable;
	assign shift_rows_enable = temp_shift_rows_enable;
	assign mix_cols_enable = temp_mix_cols_enable;
	assign start = temp_start;
	assign clear = temp_clear;
	assign count_enable = temp_count_enable;
	assign control_output = temp_control_output;
	assign encryptedOut = (count == 4'b1010) ? temp_encryptedOut : 128'h00000000000000000000000000000000;

endmodule 