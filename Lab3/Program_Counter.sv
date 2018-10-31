module Program_Counter(clk, reset, instruction_in, instruction_out);
	input logic clk, reset;
	input logic [63:0] instruction_in;
	output reg [63:0] instruction_out;
	
	genvar k;
	
	generate 
	
		for (k = 0; k < 64; k++) begin :	programCounter
			D_FF programCounter(.clk(clk), .reset(reset), .d(instruction_in[k]), .q(instruction_out[k]));
		end
	endgenerate
	
endmodule
