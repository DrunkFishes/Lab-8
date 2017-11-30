`timescale 1ns / 1ps
 /*******************************************************************************
 * Author:   Benjamin Adinata
 *           Steven Phan
 * Email:	 1anh21@gmail.com
 * Filename: reg_PC.v
 * Date:     November 26, 2017
 * Version:  1.0
 * Purpose:  The purpose of this module is to create a register that will count
 *           up when the input count is enabled and will load in a value when
 *           load is enabled.
 *					
 * Notes:	 
 *******************************************************************************/
module reg_PC(clk, reset, ld, inc, Din, Dout);
    input         clk, reset, ld, inc;
    input  [15:0] Din;
    output [15:0] Dout; reg [15:0] Dout;

    // behavioral section for writing to the register
    always@ (posedge clk or posedge reset)
        if(reset)
            Dout <= 16'b0;
        else
            case({ld,inc})
                2'b10: Dout <= Din;
                2'b01: Dout <= Dout + 16'b1;
              default: Dout <= Dout;
		endcase
        
endmodule
