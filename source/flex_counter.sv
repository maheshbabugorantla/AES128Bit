// $Id: $
// File name:   flex_counter.sv
// Created:     9/20/2016
// Author:      Mahesh Babu Gorantla
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: "Flexible and Scalable Counter with Rollover."

module flex_counter

#
(
	parameter 	NUM_CNT_BITS = 4
)

(
	input 	wire 	clk,    // Clocking Signal
	input 	wire 	n_rst,  // Asynchronous Reset Active Low
	input 	wire 	clear,  // Clear the count signal
	input 	wire 	count_enable, // Signal to enable the count to increment
	input 	wire 	[ NUM_CNT_BITS - 1: 0 ] rollover_val,
	output 	wire 	[ NUM_CNT_BITS - 1: 0 ] count_out,
	output 	wire	rollover_flag
);

	reg [ NUM_CNT_BITS - 1: 0 ] current_count;
	reg [ NUM_CNT_BITS - 1: 0 ] next_count;
	reg rollflag;
	reg rollflag_1;

	always_ff @ ( posedge clk, negedge n_rst )
	begin: ff_counter

		if( n_rst == 0 )
		begin
			current_count <= 0;
			rollflag <= 0;
		end
		else
		begin
			current_count <= next_count;
			rollflag <= rollflag_1;
		end
	end

	always_comb
	begin
		if( clear == 1 ) // Clear the count
		begin
			next_count = 0;
			rollflag_1 = 0;
		end

		else
		begin

			if( count_enable == 1 )
			begin
				next_count = current_count + 1;
				if( current_count == rollover_val )
					next_count = 1;

				rollflag_1 = 0;
				if( next_count == rollover_val )
					rollflag_1 = 1;
			end
			else
			begin
				next_count = current_count;
				if( next_count == rollover_val )
					rollflag_1 = 1;
				else
					rollflag_1 = 0;
			end
		end
	end

	assign count_out = current_count;
	assign rollover_flag = rollflag;

endmodule
