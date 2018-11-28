module shift2Left (in, out);
	input logic [63:0] in;
	output logic [63:0] out;
	
	assign out = {in[61:0], 2'b0};
	
endmodule

module shiftShamt (in, out, shamt); // shamt = 6-bit shift amount
	input logic [63:0] in;
	input logic [5:0] shamt;
	output logic [63:0] out;
	
	
	wire [63:0] wire0, wire1, wire2, wire3, wire4, wire5;
	
	wire [63:0] Out0, Out1, Out2, Out3, Out4, Out5;
	
	assign wire5 = {32'b0, in[63:32]};
	
	mux2_1_Inbit64 mux5(in, wire5, shamt[5], Out5);
	
	assign wire4 = {16'b0, Out5[63:16]};
	
	mux2_1_Inbit64 mux4(Out5, wire4, shamt[4], Out4);
	
	assign wire3 = {8'b0, Out4[63:8]};
	
	mux2_1_Inbit64 mux3(Out4, wire3, shamt[3], Out3);
	
	assign wire2 = {4'b0, Out3[63:4]};
	
	mux2_1_Inbit64 mux2(Out3, wire2, shamt[2], Out2);
	
	assign wire1 = {2'b0, Out4[63:2]};
	
	mux2_1_Inbit64 mux1(Out2, wire1, shamt[1], Out1);
	
	assign wire0 = {1'b0, Out4[63:1]};
	
	mux2_1_Inbit64 mux0(Out1, wire0, shamt[0], Out0);
	
	assign out = Out0;

endmodule

module shifter(
	input logic		[63:0]	value,
	input logic					direction, // 0: left, 1: right
	input	logic		[5:0]		distance,
	output logic	[63:0]	result
	);
	
	always_comb begin
		if (direction == 0)
			result = value << distance;
		else
			result = value >> distance;
	end
endmodule
