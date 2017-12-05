`timescale 1ns / 1ps
 /*******************************************************************************
 * Author:   Steven Phan
 * Email:    1anh21@gmail.com
 * Filename: alu16.v
 * Date:     November 5, 2017
 * Version:  1.0
 * Purpose:  Module takes in 16-bit input of R and S and outputs to Y. ALU can 
 *           have 16 operations, however only uses 13 while pass S as a default.
 *           4-bit Alu-op allows which arithmatic or logic operators will be
 *           applied on R or S. 
 *	    				
 * Notes:    There are three flags that can go high. 
 *           N is when Y is a negative number. 
 *           Z If Y is zero. 
 *           C if there is a carry out in Y.
 *******************************************************************************/
module alu16(R, S, Alu_op, Y, N, Z, C);

	input 	[ 15:0] R, S;
	input 	[ 3:0]  Alu_op;
	
	output 	[ 15:0] Y;          reg [15:0] Y;
	output 			N, Z, C;    reg        N, Z, C;
	
	always @ (R or S or Alu_op) begin
		case (Alu_op)
			4'b0000:	{C,Y} = {1'b0,S};		//pass S
			4'b0001:	{C,Y} = {1'b0,R};		//pass R
			4'b0010:	{C,Y} = S + 1;			//increment S
			4'b0011:	{C,Y} = S - 1;			//decrement S
			4'b0100:	{C,Y} = R + S;			//add
			4'b0101:	{C,Y} = R - S;			//subtract
			4'b0110:	begin				    //right shift s (logic)
							C = S[0];
							Y = S >> 1;
						end
			4'b0111:    begin				    //left shift S (logic)
							C = S[15];
							Y = S << 1;
						end
			4'b1000:	{C,Y} = {1'b0,R & S};   //logic and
			4'b1001:	{C,Y} = {1'b0,R | S};   //logic or
			4'b1010:	{C,Y} = {1'b0,R ^ S};   //logic xor
			4'b1011:	{C,Y} = {1'b0,~S};	    //logic not S (1's comp)
			4'b1100:	{C,Y} = 0-S;			//negate S	  (2's comp)
			default:	{C,Y} = {1'b0,S};		//pass S for default
		endcase
        
		//handle last two status flags
		N = Y[15];
		if (Y == 16'b0)
			Z = 1'b1;
		else
			Z = 1'b0;
			
	end
			

endmodule
