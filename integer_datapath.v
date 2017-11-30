`timescale 1ns / 1ps
 /***************************************************************************
 * Author:   Benjamin Adinata
 * Email:    benjaminadinata@yahoo.com
 * Filename: integer_datapath.v
 * Date:     November 5, 2017
 * Version:  1.0
 * Purpose:  The purpose of this module is to instantiate the register file
 *           and the ALU to create the integer datapath module. This module
 *           allows us to perform functions specified in the ALU using the
 *           registers in the register file.
 *					
 * Notes:    
 **************************************************************************/
module integer_datapath(clk, reset, W_En, S_Sel, W_Adr, R_Adr, S_Adr, Alu_Op, DS,
                        C, N, Z, Reg_Out, Alu_Out);
    input         clk, reset, W_En, S_Sel;
    input  [ 2:0] W_Adr, R_Adr, S_Adr;
    input  [ 3:0] Alu_Op;
    input  [15:0] DS;
    output        C, N, Z;
    output [15:0] Reg_Out, Alu_Out;
    
    wire   [15:0] Reg_S, S_Mux;
    
    //register_file        (clk, reset,    W   , W_Adr,  we , R_Adr, S_Adr,
    register_file   regfile(clk, reset, Alu_Out, W_Adr, W_En, R_Adr, S_Adr,
    //                         R   ,   S  )  
                            Reg_Out, Reg_S);
    
    //alu16                (   R   ,   S  , Alu_Op,    Y   , N, Z, C)
    alu16               alu(Reg_Out, S_Mux, Alu_Op, Alu_Out, N, Z, C);
    
    assign S_Mux = S_Sel ? DS : Reg_S;

endmodule
