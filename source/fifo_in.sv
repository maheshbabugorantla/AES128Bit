// $Id: $
// File name:   fifo_in.sv
// Created:     3/13/2017
// Author:      Zane Johnson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: 128-bit input FIFO from APB data bus

module fifo_in
(
    input wire clk,
    input wire n_rst,
    input wire read_en,
    input wire write_en,
    input wire [31:0]data_in,
    output reg [127:0]data_out,
    output reg fifo_empty,
    output reg fifo_full

);
	reg [31:0]data1, next_data1;
	reg [31:0]data2, next_data2;    
	reg [31:0]data3, next_data3;
	reg [31:0]data4, next_data4;
	reg [2:0] w_pointer, next_w_pointer;
	reg [127:0] next_data_out;
	reg next_empty, next_full;

	always_ff @ (posedge clk, negedge n_rst)
	begin
		if(n_rst == 0)
    		begin
			data1 = '0;
			data2 = '0;
      			data3 = '0;
      			data4 = '0;
      			w_pointer = '0;
      			data_out = '0;
      			fifo_empty = 1;
      			fifo_full = 0;
    		end
    		else
    		begin
			data1 = next_data1;
        	 	data2 = next_data2;
        	 	data3 = next_data3; 
        		data4 = next_data4;
			w_pointer = next_w_pointer;
         		data_out = next_data_out;
         		fifo_empty = next_empty;
         		fifo_full = next_full;
      		end
	end

	always_comb 
	begin //load_info
	      	next_data1 = data1;
	      	next_data2 = data2;
	      	next_data3 = data3; 
	      	next_data4 = data4;
	      	next_data_out = data_out;
	      	next_w_pointer = w_pointer;

	      	if(write_en)
		begin
	      		if(~fifo_full)
			begin
				next_w_pointer = w_pointer + 1;    
			       if(w_pointer == 0)
				   	next_data1 = data_in;   		
			       if(w_pointer == 1)
	 		     		next_data2 = data_in;
			       if(w_pointer == 2)
			          	next_data3 = data_in;
			       if(w_pointer == 3)
			          	next_data4 = data_in; 
			end
		end

		else if(read_en)
		begin
			if(~fifo_empty)
			begin
				next_w_pointer = w_pointer - 4;
      				next_data_out = {data1, data2, data3, data4};
		  		next_data1 = '0;
		  		next_data2 = '0;
		  		next_data3 = '0;
		  		next_data4 = '0;
			end
		end
	end

	assign next_full = (next_w_pointer == 4);
	assign next_empty = (next_w_pointer == 0);

endmodule



	

