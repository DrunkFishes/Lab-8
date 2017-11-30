`timescale 1ns / 1ps
 /*******************************************************************************
 * Author:   Benjamin Adinata
 * Email:	 benjaminadinata@yahoo.com
 * Filename: one_shot.v
 * Date:     October 12, 2017
 * Version:  1.0
 * Purpose:  The purpose of this module is to "debounce" the signal from
 *           the push-button switch. When a button is pushed the switch
 *           bounces which causes the signal to keep switching. So this
 *           one_shot module waits until the switch stops bouncing to get
 *           the real signal coming from the switch.
 *					
 * Notes:    This module takes inputs D_in, clk_in, and reset and outputs
 *           D-out. During each clock tick from the onboard clock of the
 *           Nexys 4, the signal from D-in is shifted into the 10 samples
 *           we have. When all the samples are at the desired level, the 
 *           output is stabilized and the appropriate signal is sent to
 *           the shift register.
 *******************************************************************************/
module one_shot(D_in, clk_in, reset, D_out);
	input 	D_in, clk_in, reset;
	output 	D_out;
	wire		D_out;
	
	reg q9, q8, q7, q6, q5, q4, q3, q2, q1, q0;
	
	/***********************************************************************
	* The following code within the always block runs after every clock tick
	* goes high and whenever the reset goes high. 
	***********************************************************************/
	always @(posedge clk_in or posedge reset)
		if (reset==1'b1)
			{q9,q8,q7,q6,q5,q4,q3,q2,q1,q0} <= 10'b0;
		else begin
			// shift in the new sample that's on the D_in input
			q9 <= q8; q8 <= q7; q7 <= q6; q6 <= q5; q5 <= q4;
			q4 <= q3; q3 <= q2; q2 <= q1; q1 <= q0; q0 <= D_in;
		end

	// create the debounced, one-shot ouput pulse
	assign D_out = !q9 & q8 & q7 & q6 & q5	&
						q4 & q3 & q2 & q1 & q0;

endmodule
