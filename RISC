`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:27:18 12/04/2017 
// Design Name: 
// Module Name:    RISC_16 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RISC_16(clk, reset, addr, Dout, Din, mw_en);

	input clk, reset, mw_en; 
	input [15:0] Din;
	output [15:0] addr, Dout;
	
	wire        pc_sel,s_sel, pc_ld, pc_inc, addr_sel, ir_ld, rw_en, addr,
		         C, N, Z;
	wire [2:0]  W_addr, R_addr, S_addr, ALU_Status;
	wire [3:0]  Alu_Op;
	wire [15:0] IR;
	 
	          //(clk, reset, Din, we,    addr_sel, pc_sel, sel,   pc_ld, pc_inc,
CPU_EU Exceute (clk, reset, Din, rw_en, addr_sel, pc_sel, s_sel, pc_ld, pc_inc,
						
						//ir_ld, C, N, Z, Addr_out, Dout);
						  ir_ld, C, N, Z, addr,     Dout);
						  
						
			    //(clk, reset, IR,     N, Z, C, W_addr, R_addr, S_addr,    
CPU_CU Control (clk, reset, IR, N, Z, C, W_addr, R_addr, S_addr,
			     //adr_sel,  s_sel, pc_ld, pc_inc, pc_sel, ir_ld, mw_en, rw_en, alu_op,  
				    addr_sel, s_sel, pc_ld, pc_inc, pc_sel, ir_ld, mw_en, rw_en, alu_op,
			      //status); 
					 ALU_status);
endmodule
