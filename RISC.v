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
module RISC_16(clk, reset, addr, Dout, Din, status, mw_en);

	input         clk, reset; 
	input  [15:0] Din;
    output        mw_en;
	output [15:0] addr, Dout;
    output  [7:0] status;
	
	wire        pc_sel, s_sel, pc_ld, pc_inc, addr_sel, ir_ld, rw_en, C, N, Z;
	wire  [2:0] W_addr, R_addr, S_addr;
	wire  [3:0] Alu_Op;
    wire [15:0] IR;
    
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
