`timescale 1ns / 1ps
/***************************************************************************
 * Author:   Benjamin Adinata
 * Email:	 benjaminadinata@yahoo.com
 * Filename: 
 * Date:     October 12, 2017
 * Version:  1.2
 * Purpose:  The purpose of this module is to iterate through 8 states. At
 *           every clock tick, the current state changes to the next state.
 *					
 * Notes:    This module implements a moore type finite state machine.
 **************************************************************************/
module pixel_controller(clk, reset, seg_sel, An);
    input        clk, reset;
    output reg [2:0] seg_sel;
    output reg [7:0] An;
    
    reg [2:0] present_state, next_state;

//**********************************//
//  Next State Combinational Logic  //
//**********************************//
    always @(present_state)
        case(present_state)
            3'b000: next_state = 3'b001;
            3'b001: next_state = 3'b010;
            3'b010: next_state = 3'b011;
            3'b011: next_state = 3'b100;
            3'b100: next_state = 3'b101;
            3'b101: next_state = 3'b110;
            3'b110: next_state = 3'b111;
            3'b111: next_state = 3'b000;
           default: next_state = 3'b000;
        endcase
        
//************************//
//  State Register Logic  //
//************************//
    always @(posedge clk or posedge reset)
        if(reset == 1'b1)
            present_state = 1'b0;
        else
            present_state = next_state;
            
//******************************//
//  Output Combinational Logic  //
//******************************//
    always @(present_state)
        case(present_state)
            3'b000: {An, seg_sel} = 11'b11111110_000;
            3'b001: {An, seg_sel} = 11'b11111101_001;
            3'b010: {An, seg_sel} = 11'b11111011_010;
            3'b011: {An, seg_sel} = 11'b11110111_011;
            3'b100: {An, seg_sel} = 11'b11101111_100;
            3'b101: {An, seg_sel} = 11'b11011111_101;
            3'b110: {An, seg_sel} = 11'b10111111_110;
            3'b111: {An, seg_sel} = 11'b01111111_111;
           default: {An, seg_sel} = 11'b11111111_000;
        endcase

endmodule
