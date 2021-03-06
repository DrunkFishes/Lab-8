`timescale 1ns / 1ps
 /*******************************************************************************
 * Author:   Benjamin Adinata
 *           Steven Phan
 * Email:	 benjaminadinata@yahoo.com
 *           1anh21@gmail.com
 * Filename: lab8_toplvl.v
 * Date:     December 5, 2017
 * Version:  1.5
 * Purpose:  The purpose of this module is to allow us to test the RISC Processor
 *           with the memory file and verify that it is functioning correctly. This
 *           module instantiates the RISC Processor module, the memory module, the
 *           Display Controller Module, the one shot module, and the clk_500Hz
 *           module. We also created a counter to allow us to step through memory.
 *           		
 * Notes:    This module only requires the use of the step clk and step mem buttons
 *           and the dump mem switch. All instructions are contained in memory and
 *           are translated by the Control Unit.
 *******************************************************************************/
module lab8_toplvl(clk, reset, step_mem, step_clk, dump_mem, An, a, b, c, d, e, f,
                   g, status);
    input        clk, reset, step_mem, step_clk, dump_mem;
    output       a, b, c, d, e, f, g;
    output [7:0] An, status;
    wire         clk_500, mem_we, stepm_out, stepc_out;
    wire  [15:0] mem_addr, addr, RISC_Din, Mem_Din;
    reg   [15:0] mem_counter;
    
    //clk_500Hz       (clk_in, reset, clk_out);
    clk_500Hz   clk500(clk, reset, clk_500);
    
    //one_shot       (D_in, clk_in, reset, D_out);
    one_shot    stepm(step_mem, clk_500, reset, stepm_out);
    one_shot    stepc(step_clk, clk_500, reset, stepc_out);
    
    //RISC_16       (clk, reset,   addr  ,   Dout ,    Din  , status, mw_en)
    RISC_16     RISC(stepc_out, reset, addr, Mem_Din, RISC_Din, status, mem_we);
    
    //ram          (clk,   we  ,   addr  ,   din  ,   dout  )
    ram         mem(clk, mem_we, mem_addr, Mem_Din, RISC_Din);
    
    //display_controller    (clk, reset, An,           D,          
    display_controller    dc(clk, reset, An, {mem_addr, RISC_Din},
    //                       a, b, c, d, e, f, g)
                             a, b, c, d, e, f, g);
    
    always@(posedge stepm_out or posedge reset)
    if(reset)
        mem_counter <= 16'b0;
    else
        mem_counter <= mem_counter + 16'b1;
        
    // mem_mux
	// mem_addr=mem_counter if 1, mem_addr=addr if 0
	assign mem_addr = (dump_mem)? mem_counter : addr;

endmodule
