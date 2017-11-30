`timescale 1ns / 1ps
 /*******************************************************************************
 * Author:   Benjamin Adinata
 * Email:	 benjaminadinata@yahoo.com
 * Filename: display_controller.v
 * Date:     October 23, 2017
 * Version:  1.0
 * Purpose:  The purpose of this module is to display specified things on each
 *           7-segment display. This module instantiates the pixel clk which
 *           implements a 480Hz clock used by the pixel_controller. The
 *           pixel_controller determines what anode should be changed at the clock.
 *           The ad_mux selects what output should be displayed. The hex_to_7segment
 *           determines which cathode should be lit.
 *					
 * Notes:	 The 480Hz clock is used to change each segment every clock tick.
 *           This gives us an approximately 60Hz refresh rate for the entire
 *           display
 *******************************************************************************/
module display_controller(clk, reset, An, D, a, b, c, d, e, f, g);
    input   clk, reset;
	input   [31:0] D;
	output         a, b, c, d, e, f, g;
	output  [ 7:0] An;
	 
    wire        clk_out;
    wire [ 2:0] seg_sel;
    wire [ 3:0] Y;
    wire [15:0] switch;
    wire [31:0] seg;
    
    //pixel_clk             (clk_in, reset, clk_out)
    pixel_clk           pclk(  clk , reset, clk_out);
    
    //pixel_controller      (  clk  , reset, seg_sel, An)
    pixel_controller    pcon(clk_out, reset, seg_sel, An);
    
    //ad_mux               (  Sel  , D, Y)
    ad_mux              mux(seg_sel, D, Y);
    
    //hex_to_7segment         (hex, a, b, c, d, e, f, g)
    hex_to_7segment     hexseg( Y,  a, b, c, d, e, f, g);

endmodule
