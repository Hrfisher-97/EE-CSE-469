// 32X64:64 mux which takes inputs from the registers and outputs a 64-bit data
module mux32_64_64(regbits, sel, out);
	output [63:0] out;
	input  [63:0] regbits[31:0]; //// array of 32 register input each of 64 bits
	input  [4:0] sel;
	
	reg [31:0]temp [63:0] ;
	
		always_comb begin
		for (int i = 0; i < 64; i++) begin
			for(int j = 0; j< 32; j++) begin
				temp[i][j] = regbits[j][i];
			end
		end
	end
	
	genvar k;
	generate
	  for (k = 0; k < 64; k++) begin : loop_gen_block
		 mux32_1 muxBit (temp[k], sel, out[k]);
	  end
	endgenerate
endmodule

// 32:1 mux built from 16:1 and 2:1 muxes
module mux32_1(in, sel, out);
	output        out;
	input  [31:0] in;
	input  [4:0]  sel;
	
	wire temp1, temp2;
	
	mux16_1 a1(in[31:16], sel[3:0], temp1);
	mux16_1 a2(in[15:0], sel[3:0], temp2);
	mux2_1  a3({temp1, temp2}, sel[4], out);
endmodule

// 16:1 mux built from 4:1 muxes
module mux16_1(in, sel, out);
	output       out;
	input [15:0] in;
	input [3:0]  sel;
	
	wire temp1, temp2, temp3, temp4;
	
	mux4_1 #0.05a1(in[15:12], sel[1:0], temp1);
	mux4_1 #0.05a2(in[11:8],  sel[1:0], temp2);
	mux4_1 #0.05a3(in[7:4], sel[1:0], temp3);
	mux4_1 #0.05a4(in[3:0], sel[1:0], temp4);
	mux4_1 a5({temp1, temp2, temp3, temp4}, sel[3:2], out);
endmodule

//4:1 mux built from 2:1 mux
module mux4_1(in, sel, out);
	output       out;
	input  [3:0] in;
	input  [1:0] sel;
	
	wire temp1, temp2;
	
	mux2_1 a1(in[3:2], sel[0], temp1);
	mux2_1 a2(in[1:0], sel[0], temp2);
	mux2_1 a3({temp1, temp2}, sel[1], out);
endmodule

// 2:1 mux
module mux2_1(in, sel, out);
	output      out;
	input [1:0] in;
	input       sel;

	wire selBar, temp1, temp2;
	
	not a1(selBar, sel);
	and a2(temp1, in[1], sel);
	and a3(temp2, in[0], selBar);
	or  a4(out, temp1, temp2);

//	assign temp1 = i[1] & sel;
//	assign temp2 = i[0] & (~sel);
//	assign out = temp1 | temp2;

endmodule


/*
module mux2_1_testbench();
	reg [1:0]i;
	reg sel;
	wire out;

	mux2_1 dut (.out, .i, .sel);

 
	integer j;
	initial begin
		$dumpfile("mux2_1.vcd");
		$dumpvars(1);
	    i = {1'b1, 1'b0};
		sel = 0;
		#10;
		sel = 1;
		#10;
	end
 
endmodule 
*/
