`timescale 1ns / 1ps
 /*******************************************************************************
 * Author:   Benjamin Adinata
 * Email:	 benjaminadinata@yahoo.com
 * Filename: reg_IR.v
 * Date:     November 26, 2017
 * Version:  1.0
 * Purpose:  The purpose of this module is to create a register that will load
 *           in values from Din to Dout when ld is enabled. If load is not enabled
 *           the value in the register stays the same.
 *					
 * Notes:	 
 *******************************************************************************/
module reg_IR(clk, reset, ld, Din, Dout);
	input 		  clk, reset, ld;
	input  [15:0] Din;
	output [15:0] Dout; reg [15:0] Dout;
	
    // behavioral section for writing to the register
    always@ (posedge clk or posedge reset)
        if(reset)
            Dout <= 16'b0;
	    else
            if(ld)
		        Dout <= Din;
            else
		        Dout <= Dout;
    
endmodule
