module D_FF (q, d, clk);
	output reg q;
	input d, clk;
 
	always_ff @(posedge clk)
			q <= d; // Otherwise out = d
endmodule 

//module D_FF (q, d, reset, clk);
//	output reg q;
//	input d, reset, clk;
// 
//	always_ff @(posedge clk)
//		 if (reset)
//			q <= 0; // On reset, set to 0
//		 else
//			q <= d; // Otherwise out = d
//endmodule 

module D_FF_Reset (clk, reset, q, d);
	output reg q;
	input d, reset, clk;
	
	always @(posedge clk)
		if(reset)
			q <= 0;
		else
			q <= d;
endmodule

module parallel_register32(clk, inbits, out);
	output [31:0] out;
	input  [31:0] inbits;
	input       clk;
	
	genvar k;
	generate
	  for (k = 0; k < 32; k++) begin : loop_gen_block
		  D_FF      flipFlop(.q(out[k]), .d(inbits[k]), .clk);

	  end
	endgenerate
endmodule 

module parallel_register64(clk, inbits, out);
	output [63:0] out;
	input  [63:0] inbits;
	input       clk;		
	
	genvar k;
	generate
	  for (k = 0; k < 64; k++) begin : loop_gen_block
		  D_FF      flipFlop(.q(out[k]), .d(inbits[k]), .clk);
	  end
	endgenerate
endmodule 

module parallel_register13(clk, inbits, out);
	output [12:0] out;
	input  [12:0] inbits;
	input       clk;		
	
	genvar k;
	generate
	  for (k = 0; k < 13; k++) begin : loop_gen_block
		  D_FF      flipFlop(.q(out[k]), .d(inbits[k]), .clk);
	  end
	endgenerate
endmodule 

//module parallel_register(clk, inbits, writeEnable, out);
//	output [63:0] out;
//	input  [63:0] inbits;
//	input       clk, writeEnable;
//	
//	
//	wire [63:0] connect_Wire;
//	//wire reset;
//	
//	//assign reset = 0;
//	
//	//assign out = connect_Wire[DEPTH];
//	//assign connect_Wire[0] = inbits[0];
//	
//	genvar k;
//	generate
//	  for (k = 0; k < 64; k++) begin : loop_gen_block
//		 mux2_1   loadMux({inbits[k], out[k]}, writeEnable, connect_Wire[k]);
//		  D_FF      flipFlop(.q(out[k]), .d(connect_Wire[k]), .clk);
////		 D_FF      flipFlop(.q(out[k]), .d(connect_Wire[k]), .reset, .clk);
//	  end
//	endgenerate
//endmodule 