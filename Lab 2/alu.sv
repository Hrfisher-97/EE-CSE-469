`timescale 1ns/10ps

module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	input [63:0] A, B;
	input [2:0]  cntrl;
	output [63:0] result;
	output zero, overflow, negative, carry_out;
	
	wire [63:0] COut, zout;
	
	genvar k;
	
	Alubit dut(A[0], B[0], cntrl[0], COut[0], 1'b1, zout[0], cntrl, result[0]);
	generate
	  for (k = 1; k < 64; k++) begin : loop_gen_block
		 Alubit alu_slice(A[k], B[k], COut[k-1], COut[k], zout[k-1], zout[k], cntrl, result[k]); // instantiation module need parameters
	  end
	endgenerate
	
	xor  #0.05 xor1(overflow, COut[63], COut[62]);
	assign negative = result[63];
	assign carry_out = COut[63];
	assign  zero = zout[63];
	
endmodule 
