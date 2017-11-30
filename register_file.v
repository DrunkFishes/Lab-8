`timescale 1ns / 1ps
 /***************************************************************************
 * Author:   Benjamin Adinata
 *           Steven Phan
 * Email:    benjaminadinata@yahoo.com
 *           1anh21@gmail.com
 * Filename: register_file.v
 * Date:     October 23, 2017
 * Version:  1.0
 * Purpose:  The purpose of this module is to instantiate the 8 16-bit
 *           registers and 3 3-to-8 decoders to create the 8x16 register file.
 *           The 3 decoders are used to select registers for the Write address,
 *           R address, and S address. The R and S address are used to select
 *           which register the 16-bit output should come from.
 *					
 * Notes:    
 **************************************************************************/
module register_file(clk, reset, W, W_Adr, we, R_Adr, S_Adr, R, S);
    input         clk, reset, we;
    input  [ 2:0] W_Adr, R_Adr, S_Adr;
    input  [15:0] W;
    output [15:0] R, S;
    
    wire    [7:0] w_out, r_out, s_out;
    
    // dec3to8.v     (  X  ,  En ,   Y  )
    dec3to8     w_dec(W_Adr,   we, w_out);
    dec3to8     r_dec(R_Adr, 1'b1, r_out);
    dec3to8     s_dec(S_Adr, 1'b1, s_out);
    
    // reg16.v    (clk, reset,    ld   ,Din, DA, DB,   oeA   ,    oeB  )
    reg16       r7(clk, reset, w_out[7],  W,  R,  S, r_out[7], s_out[7]);
    reg16       r6(clk, reset, w_out[6],  W,  R,  S, r_out[6], s_out[6]);
    reg16       r5(clk, reset, w_out[5],  W,  R,  S, r_out[5], s_out[5]);
    reg16       r4(clk, reset, w_out[4],  W,  R,  S, r_out[4], s_out[4]);
    reg16       r3(clk, reset, w_out[3],  W,  R,  S, r_out[3], s_out[3]);
    reg16       r2(clk, reset, w_out[2],  W,  R,  S, r_out[2], s_out[2]);
    reg16       r1(clk, reset, w_out[1],  W,  R,  S, r_out[1], s_out[1]);
    reg16       r0(clk, reset, w_out[0],  W,  R,  S, r_out[0], s_out[0]);

endmodule
