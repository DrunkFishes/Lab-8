`timescale 1ns / 1ps
 /*******************************************************************************
 * Author:   Benjamin Adinata
 * Email:	 benjaminadinata@yahoo.com
 * Filename: ad_mux.v
 * Date:     October 12, 2017
 * Version:  1.0
 * Purpose:	 The purpose of this module is to output specific bits from the input
 *           depending on the select input.
 *					
 * Notes:    This module has inputs Sel and D, and it has outputs Y. Sel is a 3
 *           bit input used to select between 8 different sets of 4 bits from D.
 *           Output Y outputs 4 bits of the selected output.
 *******************************************************************************/
module ad_mux(Sel, D, Y);
    input   [2:0]   Sel;
    input   [31:0]   D;
    output  [3:0]   Y;  reg [3:0] Y;
    
    //Will run whenever the Sel input changes
    always@ (Sel)
        //Checks each case for the following bits in the Sel input
        case (Sel)
             3'b000: Y = D[ 3:0 ];  //D0
             3'b001: Y = D[ 7:4 ];  //D1
             3'b010: Y = D[11:8 ];  //D2
             3'b011: Y = D[15:12];  //D3
             3'b100: Y = D[19:16];  //D4
             3'b101: Y = D[23:20];  //D5
             3'b110: Y = D[27:24];  //D6
             3'b111: Y = D[31:28];  //D7
            default: Y = 4'b0000;   //Defaults to 0
        endcase

endmodule
