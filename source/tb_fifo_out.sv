// $Id: $
// File name:   tb_fifo_out.sv
// Author:      Zane Johnson
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: testbench for fifo_out

`timescale 1ns / 10ps

module tb_fifo_out ();

localparam CLK_PERIOD = 10;
	reg tb_clk;
	reg tb_n_rst;
	reg tb_write_en;
	reg tb_read_en;
	reg [127:0] tb_data_in;
	reg tb_fifo_empty;
	reg tb_fifo_full;
	reg [31:0] tb_data_out;
integer tb_test_case;
	
fifo_out FIFO (.clk(tb_clk), .n_rst(tb_n_rst), .write_en(tb_write_en), .read_en(tb_read_en), .data_in(tb_data_in), .fifo_empty(tb_fifo_empty), .fifo_full(tb_fifo_full), .data_out(tb_data_out));



always
begin
	tb_clk = 1'b0;
	#(CLK_PERIOD/2.0);
	tb_clk = 1'b1;
	#(CLK_PERIOD/2.0);
end

initial
begin
tb_read_en = 0;
tb_write_en = 0;
tb_data_in = 0;
tb_test_case = 1;
tb_n_rst = 1'b0;
@(posedge tb_clk);
#3
tb_n_rst = 1'b1;

@(posedge tb_clk);
#3

//empty at start 

if (tb_fifo_empty == 1'b1)	
	$info("Test case #%1d passed", tb_test_case); 
else 
	$error("Test case #%1d failed", tb_test_case); 
tb_test_case = tb_test_case + 1;

//basic write and read

tb_data_in = 128'hAAAAAAAABBBBBBBBCCCCCCCCDDDDDDDD;
tb_write_en = 1'b1;
@(posedge tb_clk);
#3
tb_write_en = 1'b0;
@(posedge tb_clk);
#3

if (tb_fifo_full == 1'b1)	
	$info("Test case #%1d passed", tb_test_case); 
else 
	$error("Test case #%1d failed", tb_test_case); 
tb_test_case = tb_test_case + 1;

tb_write_en = 1'b0;
@(posedge tb_clk);
#3

if (tb_data_in == 128'hAAAAAAAABBBBBBBBCCCCCCCCDDDDDDDD)	
	$info("Test case #%1d passed", tb_test_case); 
else 
	$error("Test case #%1d failed", tb_test_case); 
tb_test_case = tb_test_case + 1;

@(posedge tb_clk);
#3

tb_read_en = 1'b1;

@(posedge tb_clk);
#3


if (tb_data_out == 32'hAAAAAAAA)	
	$info("Test case #%1d passed", tb_test_case); 
else 
	$error("Test case #%1d failed", tb_test_case); 
tb_test_case = tb_test_case + 1;


tb_read_en = 1'b0;
@(posedge tb_clk);
#3

tb_read_en = 1'b1;

@(posedge tb_clk);
#3


if (tb_data_out == 32'hBBBBBBBB)	
	$info("Test case #%1d passed", tb_test_case); 
else 
	$error("Test case #%1d failed", tb_test_case); 
tb_test_case = tb_test_case + 1;


tb_read_en = 1'b0;
@(posedge tb_clk);
#3

tb_read_en = 1'b1;

@(posedge tb_clk);
#3


if (tb_data_out == 32'hCCCCCCCC)	
	$info("Test case #%1d passed", tb_test_case); 
else 
	$error("Test case #%1d failed", tb_test_case); 
tb_test_case = tb_test_case + 1;


tb_read_en = 1'b0;
@(posedge tb_clk);
#3

tb_read_en = 1'b1;

@(posedge tb_clk);
#3


if (tb_data_out == 32'hDDDDDDDD)	
	$info("Test case #%1d passed", tb_test_case); 
else 
	$error("Test case #%1d failed", tb_test_case); 
tb_test_case = tb_test_case + 1;


tb_read_en = 1'b0;
@(posedge tb_clk);
#3

if (tb_fifo_empty == 1'b1)	
	$info("Test case #%1d passed", tb_test_case); 
else 
	$error("Test case #%1d failed", tb_test_case); 
tb_test_case = tb_test_case + 1;


end
endmodule

