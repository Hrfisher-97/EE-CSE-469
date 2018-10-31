module Single_Cycle_CPU(instr, clk);
	input logic [31:0] instr;
	input logic clk;



	// Control Logic opcodes

	wire [10:0] opcode11;
	wire [9:0]  opcode10;
	wire [7:0]  opcode8;
	wire [5:0]  opcode6;
	
	opcode11 = instr[31:21];
	opcode10 = instr[31:22];
	opcode8 = instr[31:24];
	opcode6 = instr[31:26];
	
	wire Reg2Loc, AluSrc, MemToReg, RegWrite, MemWrite, BranchTaken, UncondBr;
	wire [2:0] ALupOp;
	wire [4:0] RD, RM, RN, Ab;
	
	// DAddr's of different instructions types
	wire [8:0] imm9;
	wire [11:0] imm12;
	wire [18:0] imm19;
	wire [25:0] imm26;

	imm9 = instr[20:12];
	imm12 = instr[21:10];
	imm19 = instr[23:5];
	imm26 = instr[25:0];
	
	
	
	RD = instr[4:0];
	RN = instr[9:0];
	RM = instr[20:16];
	
	wire [63:0] DW, A, B; // output from memToreg mux 64 bit and ALU inputs
	wire [63:0] extended1, extended2, extended3, extended4;
	
	always_comb begin // add logig for EOR, LSR, B.LT, AND
		case(opcode6)
			//B
			6'b000101:
				begin //updates signals for variable
				Reg2Loc     = 1'bx;
				AluSrc      = 1'bx;
				MemToReg    = 1'bx;
				RegWrite    = 1'b0;
				MemWrite    = 1'b0;
				BranchTaken = 1'b1;
				UncondBr    = 1'b1;
				ALupOp      = 3'b010;
				end
				
			default: case(opcode8)
					//CBZ
					8'b10110100:
						begin //updates signals for variable
						Reg2Loc     = 1'b0;
						AluSrc      = 1'b0;
						MemToReg    = 1'bx;
						RegWrite    = 1'b1;
						MemWrite    = 1'b0;
						BranchTaken = 1'b0; // zero signal
						UncondBr    = 1'b0;
						ALupOp      = 3'b010; // test B
						end
					default: case(opcode10)
							// ADDI
							10'b1001000100: 
							begin //updates signals for variable
							Reg2Loc     = 1'b1;
							AluSrc      = 1'b0;
							MemToReg    = 1'b0;
							RegWrite    = 1'b1;
							MemWrite    = 1'b0;
							BranchTaken = 1'b0;
							UncondBr    = 1'b0;
							ALupOp      = 3'b010;
							end
							
							default: case(opcode11)
									// ADD
									11'b10001011000: 
										begin 
										Reg2Loc     = 1'b1;
										AluSrc      = 1'b0;
										MemToReg    = 1'b0;
										RegWrite    = 1'b1;
										MemWrite    = 1'b0;
										BranchTaken = 1'b0;
										UncondBr    = 1'bx;
										ALupOp      = 3'b010;
										end
									//SUB
									11'b11001011000:
										begin 
										Reg2Loc     = 1'b1;
										AluSrc      = 1'b0;
										MemToReg    = 1'b0;
										RegWrite    = 1'b1;
										MemWrite    = 1'b0;
										BranchTaken = 1'b0;
										UncondBr    = 1'b1;
										ALupOp      = 3'b011;
										end
									//LDUR
									11'b11111000010:
										begin 
										Reg2Loc     = 1'bx;
										AluSrc      = 1'b1;
										MemToReg    = 1'b1;
										RegWrite    = 1'b1;
										MemWrite    = 1'b0;
										BranchTaken = 1'b0;
										UncondBr    = 1'bx;
										ALupOp      = 3'b010;
										end
									//STUR
									11'b11111000000:
										begin 
										Reg2Loc     = 1'b0;
										AluSrc      = 1'b1;
										MemToReg    = 1'bx;
										RegWrite    = 1'b0;
										MemWrite    = 1'b1;
										BranchTaken = 1'b0;
										UncondBr    = 1'bx;
										ALupOp      = 3'b010;
										end
									default : // default case 
										begin 
										Reg2Loc     = 1'b0;
										AluSrc      = 1'b0;
										MemToReg    = 1'b0;
										RegWrite    = 1'b0;
										MemWrite    = 1'b0;
										BranchTaken = 1'b0;
										UncondBr    = 1'b0;
										ALupOp      = 3'b000;
										end
						endcase
					endcase
			endcase
		endcase
	end
	

		// Instruction Memory
//	module instructmem (
//	input		logic		[63:0]	address,
//	output	logic		[31:0]	instruction,
//	input		logic					clk	// Memory is combinational, but used for error-checking
//	);

	// Data Memory header
//	module datamem (
//	input logic		[63:0]	address,
//	input logic					write_enable,
//	input logic					read_enable,
//	input logic		[63:0]	write_data,
//	input logic					clk,
//	input logic		[3:0]		xfer_size,
//	output logic	[63:0]	read_data
//	);

//	signextender26 extension1(unextended, extended1); // imm26 signed
//	signextender19 extension2(unextended, extended2); // imm19 signed
 signextender9 extension3(.unextended(imm9), .extend(extended3));  //imm9
//	UnSignextender12 extension4(unextended, extended4); //imm12 Unsigned

  mux2_1_Ex mux1(RD, RM, Reg2Loc, Ab);


regfile FileRegister (.ReadData1, .ReadData2, .WriteData(DW), .ReadRegister1(RN),  .ReadRegister2(Ab), .WriteRegister(RD), 
.RegWrite(RegWrite), .clk(clk));

mux2_1_Inbit64  mux2(.in1(extended3), .in2, .sel(AluSrc), .out(B));

//	alu AluOperator (A, B, cntrl, result, negative, zero, overflow, carry_out);
	
endmodule

	
// 2:1 mux
module mux2_1_Inbit5 (in1, in2, sel, out);
	output [4:0]   out;
	input [4:0]    in1, in2;
	input          sel;

	wire [4:0] temp1, temp2;
	wire selBar;
	
	not a1(selBar, sel);
	and a2(temp1, in1, sel);
	and a3(temp2, in2, selBar);
	or  a4(out, temp1, temp2);
	
endmodule

// 2:1 mux
module mux2_1_Inbit64 (in1, in2, sel, out);
	output [63:0]   out;
	input [63:0]    in1, in2;
	input          sel;

	wire [63:0] temp1, temp2;
	wire selBar;
	
	not a1(selBar, sel);
	and a2(temp1, in1, sel);
	and a3(temp2, in2, selBar);
	or  a4(out, temp1, temp2);
	
endmodule

