`timescale 1ns / 1ps
 /*******************************************************************************
 * Author:   Benjamin Adinata
 *           Steven Phan
 * Email:	 benjaminadinata@yahoo.com
 *           1anh21@gmail.com
 * Filename: reg_PC.v
 * Date:     November 26, 2017
 * Version:  1.0
 * Purpose:  Module instantiates integer datapath module. Takes a 16-bit input
 *	         and two 16-bit outputs for the Registers and ALU. PC increments 
 *	         every ALU. Multiplexer takes 16-bit but outputs 8-bits. IR takes 
 *	        takes 16-bits.
 *					
 * Notes:
 *******************************************************************************/
module CPU_EU(clk, reset, Din, we, addr_sel, pc_sel, sel, pc_ld, pc_inc, ir_ld,
              C, N, Z, Addr_out, Dout);

	input         clk, reset, we, sel, addr_sel, pc_sel, pc_ld, pc_inc, ir_ld;
	input  [15:0]  Din;
	output        C,N,Z;
	output [15:0] Addr_out, Dout;
	wire   [15:0] Reg_out, Alu_out, ir_Q, pc_Q, ext_out, offset, Pmux_out;
	
	//integer_datapath      (clk, reset, W_En, S_Sel,   W_Adr  ,   R_Adr  ,
	integer_datapath    IDCP(clk, reset,  we ,  sel , ir_Q[8:6], ir_Q[5:3],
    //                         S_Adr  ,   Alu_ Op  ,   DS, C, N, Z, Reg_Out, Alu_Out)
                             ir_Q[2:0], ir_Q[15:12],  Din, C, N, Z, Reg_out,  Dout);
							   
    //reg_PC     (clk, reset,   ld ,   inc ,  Din, Dout)
	reg_PC   PC  (clk, reset, pc_ld, pc_inc, Dout, pc_Q);
    
    //reg_IR     (clk, reset,   ld,  Din, Dout)
	reg_IR   IR  (clk, reset, ir_ld, Din, ir_Q);
	
    // SignExt
    assign ext_out = {{8{IR[7]}}, ir_Q[7:0]};
    
    // Offset
    assign offset = pc_Q + ext_out;
    
    // PC_mux
    // Pmux_out=Dout if 1, Pmux_out=offset if 0
    assign Pmux_out = (pc_sel)? Dout : offset;
    
    // adr_mux
	// Addr_out=Reg_out if 1, Addr_out=pc_Q if 0
	assign Addr_out = (addr_sel)? Reg_out : pc_Q;

endmodule
