`timescale 1ns / 1ps
 /***************************************************************************
 * Author:   Benjamin Adinata
 * Email:    benjaminadinata@yahoo.com
 * Filename: clk_500Hz.v
 * Date:     September 23, 2017
 * Version:  1.0
 * Purpose:  The purpose of this module is to convert the internal clock
 *			 signal of the Nexys 4 board from 100MHz to 500Hz.
 *					
 * Notes:    This module takes inputs clk_in and reset and outputs clk_out.
 *			 This module works by counting the number of clock ticks and
 *           outputting a clock signal once. For this specific project,
 *           I set the number of clock ticks to count to 100000 ticks
 *           following the equation [(Incoming Freq / Outgoing Freq) / 2]		
 **************************************************************************/
module clk_500Hz(clk_in, reset, clk_out);
	input 	clk_in, reset;
	output 	clk_out;
	reg 		clk_out;
	integer 	i;
	
	/************************************************************************
	* Runs the following code whenever the clock or reset goes high
	* After each clock tick i is increased by 1, and once i reaches
	* 100000 clk_out is switched from either high to low or low to high.
	************************************************************************/
	always @(posedge clk_in or posedge reset) begin
		if (reset == 1'b1) begin
			i = 0;
			clk_out = 0;
		end
		// got a clock, so increment the counter and
		// test to see if half a period has elapsed
		else begin
			i = i + 1;
			if (i >= 100000) begin // 100Mhz/500Hz/2 = 100000
				clk_out = ~clk_out;
				i = 0;
			end // if
		end // else
	end // always

endmodule
