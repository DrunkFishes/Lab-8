`timescale 1ns / 1ps
 /*******************************************************************************
 * Author:   Steven Phan
 * Email:	 1anh21@gmail.com
 * Filename: ram.v
 * Date:     November 26, 2017
 * Version:  1.4
 * Purpose:  Module is the memory source that is 256 wide and 16 bits deep.
 *					
 * Notes:	 
 *******************************************************************************/
module ram(
    input clk,
    input we,
    input [7:0] addr,
    input [15:0] din,
    output [15:0] dout
    );
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
ram_256x16 dut(
  .clka(clk), // input clka
  .wea(we), // input [0 : 0] wea
  .addra(addr), // input [7 : 0] addra
  .dina(din), // input [15 : 0] dina
  .douta(dout) // output [15 : 0] douta
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

endmodule
