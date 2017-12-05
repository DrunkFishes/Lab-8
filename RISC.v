`timescale 1ns / 1ps
 /***************************************************************************
 * Author:   Benjamin Adinata
 *           Steven Phan
 * Email:    benjaminadinata@yahoo.com
 *           1anh21@gmail.com
 * Filename: RISC.v
 * Date:     December 5, 2017
 * Version:  1.2
 * Purpose:  The purpose of this module is to combine the CPU Execution Unit
 *           and CPU Control Unit into one module. So, this module instantiates
 *           these two modules and connects the outputs of the Control Unit to
 *           some of the inputs of the Execution Unit.
 *					
 * Notes:    
 **************************************************************************/
module RISC_16(clk, reset, addr, Dout, Din, status, mw_en);
	input         clk, reset; 
	input  [15:0] Din;
    output        mw_en;
    output  [7:0] status;
    output [15:0] addr, Dout;
	wire          pc_sel, s_sel, pc_ld, pc_inc, addr_sel, ir_ld, rw_en, C, N, Z;
	wire    [2:0] W_addr, R_addr, S_addr;
	wire    [3:0] Alu_Op;
    wire   [15:0] IR;
    
    //CPU_EU           (clk, reset, Din, W_Adr,  R_Adr,  S_Adr,  ALU_Op, rw_en, 
    CPU_EU      Execute(clk, reset, Din, W_addr, R_addr, S_addr, Alu_Op, rw_en,
                    //  addr_sel, pc_sel, S_sel, pc_ld, pc_inc, ir_ld, C, N, Z,
                        addr_sel, pc_sel, s_sel, pc_ld, pc_inc, ir_ld, C, N, Z, 
                    //  Addr_out, Dout, IR_out);
                        addr,     Dout, IR);
                        
    //CPU_CU           (clk, reset, IR, N, Z, C, W_addr, R_addr, S_addr, adr_sel,
    CPU_CU      Control(clk, reset, IR, N, Z, C, W_addr, R_addr, S_addr, addr_sel, 
                    //  s_sel, pc_ld, pc_inc, pc_sel, ir_ld, mw_en, rw_en, alu_op,  
                        s_sel, pc_ld, pc_inc, pc_sel, ir_ld, mw_en, rw_en, Alu_Op,
                    //  status)
                        status);

endmodule
