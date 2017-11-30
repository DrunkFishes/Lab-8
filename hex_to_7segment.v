`timescale 1ns / 1ps
 /***************************************************************************
 * Author:   Benjamin Adinata
 * Email:    benjaminadinata@yahoo.com
 * Filename: hex_to_7segment.v
 * Date:     October 03, 2017
 * Version:  1.0
 * Purpose:  The purpose of this module is to take a 4-bit input and translate
 *           it into a hex number that can be displayed on the 7-segment
 *           display.
 *					
 * Notes:    This module has inputs hex which is a 4-bit input, and it has
 *           outputs a, b, c, d, e, f, & g. Each of these outputs correspond
 *           with one of the cathodes on the display. Case statements are
 *           used to turn on certain cathodes depending on the desired
 *           Hex value.			
 **************************************************************************/
module hex_to_7segment(hex, a, b, c, d, e, f, g);
	input [3:0] hex;
	output reg a, b, c, d, e, f, g;
	
	// Will run whenever the hex input changes
	always@(hex)
		// compares hex with each case to check for a match
		// The cathodes are active low, so OFF=1 and ON=0
		case(hex)
			4'b0000: {a,b,c,d,e,f,g} = 7'b0000001;	// 0
			4'b0001: {a,b,c,d,e,f,g} = 7'b1001111;	// 1
			4'b0010: {a,b,c,d,e,f,g} = 7'b0010010;	// 2
			4'b0011: {a,b,c,d,e,f,g} = 7'b0000110;	// 3
			4'b0100: {a,b,c,d,e,f,g} = 7'b1001100;	// 4
			4'b0101: {a,b,c,d,e,f,g} = 7'b0100100;	// 5
			4'b0110: {a,b,c,d,e,f,g} = 7'b0100000;	// 6
			4'b0111: {a,b,c,d,e,f,g} = 7'b0001111;	// 7
			4'b1000: {a,b,c,d,e,f,g} = 7'b0000000;	// 8
			4'b1001: {a,b,c,d,e,f,g} = 7'b0000100;	// 9
			4'b1010: {a,b,c,d,e,f,g} = 7'b0001000;	// A
			4'b1011: {a,b,c,d,e,f,g} = 7'b1100000;	// b
			4'b1100: {a,b,c,d,e,f,g} = 7'b0110001;	// C
			4'b1101: {a,b,c,d,e,f,g} = 7'b1000010;	// d
			4'b1110: {a,b,c,d,e,f,g} = 7'b0110000;	// E
			4'b1111: {a,b,c,d,e,f,g} = 7'b0111000;	// F
			// "-" is displayed if no match is found
			default: {a,b,c,d,e,f,g} = 7'b1111110;
		endcase

endmodule
