`timescale 1ns / 1ps
 /*******************************************************************************
 * Author:   Steven Phan
 * Email:	 1anh21@gmail.com
 * Filename: reg16.v
 * Date:     October 23, 2017
 * Version:  1.0
 * Purpose:  Module takes in a synchronous load for the 16-bit Din. When the 
 * 	         asynchronous reset is high, 16-bit Dout outputs 0. DA and DB are
 *	         16-bit and tri-state outputs. The outputs are governed by oeA and
 *           oeB
 *					
 * Notes:	 
 *******************************************************************************/
module reg16(clk, reset, ld, Din, DA, DB, oeA, oeB);
	input 		  clk, reset, ld, oeA, oeB;
	input  [15:0] Din;
	output [15:0] DA, DB;
	reg    [15:0] Dout;
	
    // behavioral section for writing to the register
    always@ (posedge clk or posedge reset)
        if (reset)
            Dout <= 16'b0;
	    else
            if (ld)
		        Dout <= Din;
            else
		        Dout <= Dout;
	
    // conditional continout assignments for reading the register
    assign DA = oeA ? Dout : 16'hz;
    assign DB = oeB ? Dout : 16'hz;

endmodule
