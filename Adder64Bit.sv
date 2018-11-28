module Adder64Bit(A, B, Sum);
	input logic [63:0] A, B;
	output logic [63:0] Sum; 
	
	
	logic [63:0] c;
	
	fullAdder addr0(.A(A[0]), .B(B[0]), .C(1'b0) ,.Carry(c[0]), .Sum(Sum[0]));
	
	genvar k;
	
	generate
	
	for (k = 1; k < 64; k++) begin :	Adder64
			fullAdder addrContinous(.A(A[k]), .B(B[k]), .C(c[k - 1]), .Carry(c[k]), .Sum(Sum[k]));
		end
	endgenerate
endmodule
