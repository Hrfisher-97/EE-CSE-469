 // 26-bit sign Extension
module signextender26(unextended, extended); 
  input  logic signed [25:0] unextended;//the msb bit is the sign bit
  output reg signed [63:0] extended ;
  
  
	assign extended = unextended;
	
//	wire mostSigBit, checkBit;
//	wire [15:0] bitHold;
//	
//	mostSigBit = unextended[7];
//	wire [15:0] signExtenNeg, signExtenPos;  
//	
//	signExtenNeg = {8'b1, unextended};
//	signExtenPos {8'b0, unextended};
//	
//	and #0.05 and1(checkBit, 1'b, mostSigBit);
//	
//	genvar k;
//	generate
//	  for (k = 0; k < 16; k++) begin : loop_gen_block
//		 mux2_1 muxBit (signExtenNeg[k], checkBit, out[k]);
//	  end
//	endgenerate
  
endmodule

 // 19-bit sign Extension
module signextender19(unextended, extended); 
  input  logic signed [18:0] unextended;//the msb bit is the sign bit
  output reg signed [63:0] extended ;
  
  
	assign extended = unextended;
  
endmodule

 // 9-bit sign Extension
module signextender9(unextended, extended); 
  input  logic signed [8:0] unextended;//the msb bit is the sign bit
  output reg signed [63:0] extended ;
  
  
	assign extended = unextended;
  
endmodule

 // 12-bit Unsigned Extension
module UnSignextender12(unextended, extended); 
  input  logic [11:0] unextended;//the msb bit is the sign bit
  output reg [63:0] extended ;
  
	assign extended = {52'b0, unextended};
  
endmodule
