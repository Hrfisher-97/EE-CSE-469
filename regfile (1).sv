module regfile(ReadData1, ReadData2, WriteData, ReadRegister1, 
						ReadRegister2, WriteRegister,RegWrite, clk);
						
  output [63:0] ReadData1, ReadData2;
  input [63:0] WriteData;
  input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
  input RegWrite;
  input clk;
  
  reg [63:0] registers [31:0]; // array of 32 registers each of 64 bits
  
  wire [31:0] decOut;
  
  decoder_5to32 decoder(RegWrite, WriteRegister, decOut);
  // need to work on
  
  genvar k;
	generate
	  for (k = 0; k < 31; k++) begin : loop_gen_block
		 parallel_register register(clk, WriteData, decOut[k], registers[k]); // instantiation module need parameters
	  end
	endgenerate
  
  assign registers[31] = 64'b0;
  
  mux32_64_64 mux1(registers, ReadRegister1, ReadData1);
  mux32_64_64 mux2(registers, ReadRegister2, ReadData2);
endmodule


module parallel_register(clk, inbits, writeEnable, out);
	output [63:0] out;
	input  [63:0] inbits;
	input       clk, writeEnable;
	
	
	wire [63:0] connect_Wire;
	//wire reset;
	
	//assign reset = 0;
	
	//assign out = connect_Wire[DEPTH];
	//assign connect_Wire[0] = inbits[0];
	
	genvar k;
	generate
	  for (k = 0; k < 64; k++) begin : loop_gen_block
		 mux2_1   loadMux({inbits[k], out[k]}, writeEnable, connect_Wire[k]);
		  D_FF      flipFlop(.q(out[k]), .d(connect_Wire[k]), .clk);
//		 D_FF      flipFlop(.q(out[k]), .d(connect_Wire[k]), .reset, .clk);
	  end
	endgenerate
endmodule 