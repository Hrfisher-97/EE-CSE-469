module regfile(ReadData1, ReadData2, WriteData, ReadRegister1, 
						ReadRegister2, WriteRegister,RegWrite, clk);
						
	output [63:0] ReadData1, ReadData2;
	input [63:0] WriteData;
	input [4:0] ReadReg1, ReadReg2;
	input [4:0] WriteReg;
	input WrEn;
	input clk;
	
	wire [31:0] decOut;
	wire [31:0] writeSel;
	wire [31:0] ReadSel1, ReadSel2;
  
	reg [63:0] registers [31:0];  // array of 32 registers each of 64 bits

	decoder_5to32 write(.enable(1'b1), .input_select(writeSel), .output_select(WriteReg));
	decoder_5to32 read0(.enable(1'b1), .input_select(ReadSel1), .output_select(ReadReg1));
	decoder_5to32 read1(.enable(1'b1), .input_select(ReadSel2), .output_select(ReadReg2));

	assign registers[0][31:0] = 32'b0;
	
		genvar k;
		generate
			for(k = 0; k < 32; k++) begin: create_reg
				and(decOut[k], RegWrite, writeSel[k]);
				generalReg Reg(.result(registers[i][31:0], .writeEn([i]), .clk(clk), .writeData(writeData));
		end generate
		
	
	genvar j;
		generate
			for(j = 0; j < 32; j++) begin: parallel
				mux32_1 read1(.in({registers[31][j]; registers[30][j]; registers[29][j]; registers[28][j]; registers[27][j]; registers[26][j];  
							registers[25][j]; registers[24][j]; registers[23][j]; registers[22][j]; registers[21][j]; registers[20][j]; 
							registers[19][j]; registers[18][j]; registers[17][j]; registers[16][j]; registers[15][j]; registers[14][j];  
							registers[13][j]; registers[12][j]; registers[11][j]; registers[10][j]; registers[9][j]; registers[8][j];
							registers[7][j]; registers[6][j]; registers[5][j]; registers[4][j]; registers[3][j]; registers[2][j];  
							registers[1][j]; registers[0][j]}),.sel(ReadReg1), .out(ReadData1));

				mux32_1 read2(.in({registers[31][j]; registers[30][j]; registers[29][j]; registers[28][j]; registers[27][j]; registers[26][j];  
							registers[25][j]; registers[24][j]; registers[23][j]; registers[22][j]; registers[21][j]; registers[20][j]; 
							registers[19][j]; registers[18][j]; registers[17][j]; registers[16][j]; registers[15][j]; registers[14][j];  
							registers[13][j]; registers[12][j]; registers[11][j]; registers[10][j]; registers[9][j]; registers[8][j];
							registers[7][j]; registers[6][j]; registers[5][j]; registers[4][j]; registers[3][j]; registers[2][j];  
							registers[1][j]; registers[0][j]}),.sel(ReadReg2), .out(ReadData2));			
				
		endgenerate
		
endmodule
	
	
module generalReg(clk, result, WrEn, writeDataOut);
	input clk, WrEn;
	input [31:0] WriteDataOut;
	output [31:0] result;
	
	wire [31:0] enData;
	
	genvar k;
		generate 
			for(k = 0; k < 32; k++) begin: generalRegisters
				mux2_1 (.in({WriteDataOut[i]; result[i]}), .sel(WrEn), .out(enData[i]));
				D_FF flipreg(.q(enData[i]), .d(result[i]), .clk(clk));
		endgenerate 
endmodule

