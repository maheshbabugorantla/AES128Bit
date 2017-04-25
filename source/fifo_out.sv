// $Id: $
// File name:   fifo_out.sv
// Created:     3/13/2017
// Author:      Zane Johnson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: 32-bit output FIFO to APB data bus

module fifo_out
(
	input wire clk,
	input wire n_rst,
	input wire read_en,
	input wire write_en,
	input wire [127:0]data_in,
	output reg [31:0]data_out,
	output reg fifo_empty,
	output reg fifo_full
);

    reg [127:0] data;
    reg [31:0] next_data_out;
    reg [2:0] w_pointer, next_w_pointer, r_pointer, next_r_pointer;
    reg [127:0] next_data; 
    reg next_empty, next_full;

  always_ff @ (posedge clk, negedge n_rst)
  begin

    if(n_rst == 0)
    begin
	fifo_empty = 1;
	data = '0;
      	w_pointer = '0;
      	r_pointer = '0;
      	data_out = '0;
      	fifo_full = '0;
    end

    else
    begin
	 data = next_data;
	 w_pointer = next_w_pointer;
	 r_pointer = next_r_pointer;
         data_out = next_data_out;
         fifo_empty = next_empty;
         fifo_full = next_full;         
      end
  end

  always_comb 
  begin //load_info
	next_data_out = data_out;
	next_w_pointer = w_pointer;
      	next_r_pointer = r_pointer;
      
	if(write_en) 
	begin
      		if(~fifo_full) 
		begin
      	       		next_w_pointer = w_pointer + 4;
	       		next_r_pointer = 0;    
			next_data = data_in;
		end
        end

      	else if(read_en)
	begin
		if(~fifo_empty)
		begin
			next_w_pointer = w_pointer - 1; 
        	        next_r_pointer = r_pointer + 1;
	
			if(r_pointer == 3)
				next_data_out = data[31:0];
				
			else if(r_pointer == 2)
      				next_data_out = data[63:32];
				
			else if(r_pointer == 1)
      				next_data_out = data[95:64];
			
			else if(r_pointer == 0)
      				next_data_out = data[127:96];
		end
	end
  end
  
	assign next_full = (next_w_pointer != 0);
	assign next_empty = (next_w_pointer == 0);

endmodule



	

