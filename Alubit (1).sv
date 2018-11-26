// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

//`timescale 1ns/10ps

module Alubit(A, B, Cin, COut, zin, zout, Sel, out);
	input A, B, Cin, zin;
	input [2:0] Sel;
	output out, COut, zout;
	
	wire adderOut, andOut, orOut, muxOut, bBar;
	wire xorout, z; // AxorB
	
	// not not1(bBar, B);
	or    or1(orOut, A, B);
	and   and1(andOut, A, B);
	xor   xor1(xorout, A, B);
	
	// checks zero output
	not not2(z, out);
	and and2(zout, z, zin);
	
	//mux2_1 mux1({bBar, B}, sel[0], muxOut); mux and inverter input into adder is same as an xor gate with b and s[0] input
	xor  xor2(muxOut, B, Sel[0]);
	
	fullAdder adder1(A, muxOut, Cin, COut, adderOut);
//	fullAdder adder1(A, muxOut, Sel[0], COut, Sum);
	
	//mux4_1 mux2({orOut, andOut, adderOut, adderOut}, Sel, out);
	
	mux8_1 mux2({1'b0, xorout, orOut, andOut, adderOut, adderOut,1'b0, B}, Sel, out); // 8:1 mux
endmodule 	
	

//// Full adder module
//module fullAdder (A, B, Cin, Co, Sum);
//	input A, B, Cin;
//	output Co, Sum;
//	
//	wire D, E, F, G, H;
//	
//	xor   XOR1(D, A, B);
//	xor   XOR2(Sum, D, C);
//	
//	and   and1(E, A, B);
//	and   and2(F, A, Cin);
//	and   and3(G, B, Cin);
//	
//	or    or1(H, E, F);
//	or    or2(Co, H,G);
//	
//endmodule

module fullAdder(A,B,C,Carry, Sum);

input A,B,C;
output Sum, Carry;
wire D,E,F;

xor XOR1(D,A,B);
xor XOR2(Sum,D,C);
nand NAND1(E,D,C);
nand NAND2(F,A,B);
nand NAND3(Carry,E,F);

endmodule 

// Mux 8:1
module mux8_1(in, sel, out);
	output out;
	input [7:0] in;
	input [2:0] sel;
	
	wire outMux1, outMux2;
	
	mux4_1 mux1(in[7:4], sel[1:0], outMux1);
	mux4_1 mux2(in[3:0], sel[1:0], outMux2);
	mux2_1 mux3({outMux1, outMux2}, sel[2], out);
endmodule


////4:1 mux built from 2:1 mux
//module mux4_1(in, sel, out);
//	output       out;
//	input  [3:0] in;
//	input  [1:0] sel;
//	
//	wire temp1, temp2;
//	
//	mux2_1 a1(in[3:2], sel[0], temp1);
//	mux2_1 a2(in[1:0], sel[0], temp2);
//	mux2_1 a3({temp1, temp2}, sel[1], out);
//endmodule

//// 2:1 mux
//module mux2_1(in, sel, out);
//	output      out;
//	input [1:0] in;
//	input       sel;
//
//	wire selBar, temp1, temp2;
//	
//	not  a1(selBar, sel);
//	and  a2(temp1, in[1], sel);
//	and  a3(temp2, in[0], selBar);
//	or   a4(out, temp1, temp2);
//endmodule
