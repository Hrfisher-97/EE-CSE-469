module Single_Cycle_CPU(clk, reset);
	input logic clk, reset;

	logic [31:0] instr;

	// Control Logic opcodes

	logic [10:0] opcode11;
	logic [9:0]  opcode10;
	logic [7:0]  opcode8;
	logic [5:0]  opcode6;
	
	assign opcode11 = instr[31:21];
	assign opcode10 = instr[31:22];
	assign opcode8 = instr[31:24];
	assign opcode6 = instr[31:26];
	
	// control logic variables 
	logic Reg2Loc, AluSrc, MemToReg, RegWrite, MemWrite, BranchTaken, UncondBr, LSRShift, ImmCntr, SetFlag;
	logic [2:0] ALuOp;
	
	logic [4:0] RD, RM, RN, Ab;
	
	// DAddr's of different instructions types
	logic [8:0] imm9;
	logic [11:0] imm12;
	logic [18:0] imm19;
	logic [25:0] imm26;

	assign imm9 = instr[20:12];
	assign imm12 = instr[21:10];
	assign imm19 = instr[23:5];
	assign imm26 = instr[25:0];
	
	
	
	assign RD = instr[4:0];
	assign RN = instr[9:5];
	assign RM = instr[20:16];
	
	logic [63:0] DW; // output from memToreg mux 64 bit and ALU inputs
	
	logic [63:0] A, B; // input to ALU
	
	logic [63:0] BRegOut; // Read datat 2 from reg file
	
	logic [63:0] DAddr9, Imm12, CondADr19, BrAddr26; // unsigned and signed extensions output
	
	logic [63:0] OutputPC; // next out of program counter
	
	logic [63:0] UncodMuxOut; // output from unconditionBr mux
	
	logic [63:0] shift2Out; // shift output from unconditionBr mux
	
	logic [63:0] memOut; // output from data memeory
	
	logic [63:0] MemToRegOUt; // output from memToReg mux
	
	logic [63:0] ImmCntrlOut; // output from immediate cntrl mux
	
	// input/output to shifter for LSR logic
	logic [5:0] shamt;
	assign shamt = instr[15:10];
	logic [63:0] shift3Out;
	
	// output form ALu
	logic [63:0] result;
	logic zero, overflow, negative;// flags needed for brank taken control signal
	logic  AluCout; // ALU carry out output
	
	logic ZeroFlag, NegFlag, OverFlag;
	
	// Control Logic
	always_comb begin
		case(opcode6)
			//B
			6'b000101: begin //updates signals for variable
				Reg2Loc     = 1'bx; // x
				AluSrc      = 1'bx; // x
				MemToReg    = 1'bx; // x
				RegWrite    = 1'b0;
				MemWrite    = 1'b0;
				BranchTaken = 1'b1;
				UncondBr    = 1'b1;
				ALuOp       = 3'bxxx;
				LSRShift    = 1'bx;
				ImmCntr		= 1'bx;
				SetFlag		= 1'b0;
				end
				
			default: case(opcode8)
					//CBZ
					8'b10110100: begin //updates signals for variable
						Reg2Loc     = 1'b0;
						AluSrc      = 1'b0;
						MemToReg    = 1'bx; // x
						RegWrite    = 1'b0;
						MemWrite    = 1'b0;
						BranchTaken = zero; // zero signal directly from ALU output
						UncondBr    = 1'b0;
						ALuOp      = 3'b000; // test B
						LSRShift    = 1'bx;
						ImmCntr		= 1'bx;
						SetFlag		= 1'b0;
						end
					//B.LT
					8'b01010100 : begin //updates signals for variable
						Reg2Loc     = 1'bx;
						AluSrc      = 1'bx;
						MemToReg    = 1'bx; // x
						RegWrite    = 1'b0;
						MemWrite    = 1'b0;
						BranchTaken = NegFlag ^ OverFlag; // zero signal
						UncondBr    = 1'b0;
						ALuOp      = 3'bxxx; // don't of whats outputed from ALU
						LSRShift    = 1'bx;
						ImmCntr		= 1'bx;
						SetFlag		= 1'b0;
						end
					default: case(opcode10)
							// ADDI 1001000100
							10'b1001000100:  begin //updates signals for variable
								Reg2Loc     = 1'bx; // not reading from RD or RM
								AluSrc      = 1'b1;
								MemToReg    = 1'b0;
								RegWrite    = 1'b1;
								MemWrite    = 1'b0;
								BranchTaken = 1'b0;
								UncondBr    = 1'bx;
								ALuOp      = 3'b010;
								LSRShift    = 1'b0;
								ImmCntr		= 1'b1;
								SetFlag		= 1'b0;
								end
							
							default: case(opcode11)
									// ADDS
									11'b10101011000:  begin 
										Reg2Loc     = 1'b1;
										AluSrc      = 1'b0;
										MemToReg    = 1'b0;
										RegWrite    = 1'b1;
										MemWrite    = 1'b0;
										BranchTaken = 1'b0;
										UncondBr    = 1'bx; // x
										ALuOp      = 3'b010;
										LSRShift    = 1'b0;
										ImmCntr		= 1'bx; 
										SetFlag		= 1'b1;
										end
									// AND
									11'b10001010000:  begin 
										Reg2Loc     = 1'b1;
										AluSrc      = 1'b0;
										MemToReg    = 1'b0;
										RegWrite    = 1'b1;
										MemWrite    = 1'b0;
										BranchTaken = 1'b0;
										UncondBr    = 1'bx; // x
										ALuOp      = 3'b100;
										LSRShift    = 1'b0;
										ImmCntr		= 1'bx; 
										SetFlag		= 1'b0;
										end
										
									//SUBS
									11'b11101011000: begin 
										Reg2Loc     = 1'b1;
										AluSrc      = 1'b0;
										MemToReg    = 1'b0;
										RegWrite    = 1'b1;
										MemWrite    = 1'b0;
										BranchTaken = 1'b0;
										UncondBr    = 1'bx;
										ALuOp      = 3'b011;
										LSRShift    = 1'b0;
										ImmCntr		= 1'bx;
										SetFlag		= 1'b1;
										end
									//LDUR
									11'b11111000010: begin 
										Reg2Loc     = 1'bx; // x
										AluSrc      = 1'b1;
										MemToReg    = 1'b1;
										RegWrite    = 1'b1;
										MemWrite    = 1'b0;
										BranchTaken = 1'b0;
										UncondBr    = 1'bx; // x
										ALuOp      = 3'b010;
										LSRShift    = 1'b0;
										ImmCntr		= 1'b0; // confirm
										SetFlag		= 1'b0;
										end
									//STUR
									11'b11111000000: begin 
										Reg2Loc     = 1'b0;
										AluSrc      = 1'b1;
										MemToReg    = 1'bx; // x
										RegWrite    = 1'b0;
										MemWrite    = 1'b1;
										BranchTaken = 1'b0;
										UncondBr    = 1'bx; // x
										ALuOp      = 3'b010;
										LSRShift    = 1'bx;
										ImmCntr		= 1'b0; 
										SetFlag		= 1'b0;
										end
									//EOR
									11'b11001010000:
										begin 
										Reg2Loc     = 1'b1;
										AluSrc      = 1'b0;
										MemToReg    = 1'b0; 
										RegWrite    = 1'b1;
										MemWrite    = 1'b0;
										BranchTaken = 1'b0;
										UncondBr    = 1'bx; // x
										ALuOp      = 3'b110; // xor
										LSRShift    = 1'b0;
										ImmCntr		= 1'bx; //confirm
										SetFlag		= 1'b0;
										end
										//LSR
									11'b11010011010: begin 
										Reg2Loc     = 1'b0;
										AluSrc      = 1'b1;
										MemToReg    = 1'bx; // x
										RegWrite    = 1'b0;
										MemWrite    = 1'b1;
										BranchTaken = 1'b0;
										UncondBr    = 1'bx; // x
										ALuOp      = 3'b010;
										LSRShift    = 1'b1;
										ImmCntr		= 1'b0; // confirm
										SetFlag		= 1'b0;
										end
										
									default : begin // default case  
										Reg2Loc     = 1'b1;
										AluSrc      = 1'bx;
										MemToReg    = 1'bx;
										RegWrite    = 1'b1;
										MemWrite    = 1'b0;
										BranchTaken = 1'b0;
										UncondBr    = 1'bx;
										ALuOp      = 3'bxxx;
										LSRShift    = 1'b1;
										ImmCntr		= 1'bx; //confirm
										SetFlag		= 1'b0;
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
	
	logic [63:0] UncondAdderOut;
	logic [63:0] NextInstr; // out of BrTaken
	logic [63:0] Adder4BitOUt;
	
	mux2_1_Inbit64 BrTakenMux5(.in1(UncondAdderOut), .in2(Adder4BitOUt), .sel(BranchTaken), .out(NextInstr));
	
	
	
	// ***************************************************************************************************
	// program counter
	// ***************************************************************************************************
	
	Program_Counter PCount(.clk(clk), .reset(reset), .instruction_in(NextInstr), .instruction_out(OutputPC));
	
	
	mux2_1_Inbit64 UncodBRMux6(.in1(BrAddr26), .in2(CondADr19), .sel(UncondBr), .out(UncodMuxOut));
	
	
	shifter shift2(.value(UncodMuxOut), .direction(1'b0), .distance(6'b000010), .result(shift2Out));
	
	
	
	Adder64Bit UncondAdder(.A(shift2Out), .B(OutputPC), .Sum(UncondAdderOut));
	
	
	Adder64Bit Adder4Bit(.A(OutputPC), .B({60'b0, 4'b0100}), .Sum(Adder4BitOUt));

	
	// Instruction Memory
	instructmem instructiOUt(.address(OutputPC), .instruction(instr), .clk(clK));

	signextender9 extension1(.unextended(imm9), .extended(DAddr9));  //imm19, D-type Instruction
	UnSignextender12 extension2(.unextended(imm12), .extended(Imm12)); //imm12 Unsigned, I-Type instruction
	signextender19 extension3(.unextended(imm19), .extended(CondADr19)); // imm19 signed, CB-type Instruction
	signextender26 extension4(.unextended(imm26), .extended(BrAddr26)); // imm26 signed, B-type Instruction
 
//	// shift modules      / 0: left, 1: right
//	shifter shift1(value, direction, distance, result);
	
	// ***************************************************************************************************
	// Regfile| ALU | Data Memmory
	// ***************************************************************************************************
	
	// Reg2Loc mux
	mux2_1_Inbit5 RegToLocMux1(.in1(RM), .in2(RD), .sel(Reg2Loc), .out(Ab)); 

	// Regfile
	regfile FileRegister (.ReadData1(A), .ReadData2(BRegOut), .WriteData(DW), .ReadRegister1(RN),  .ReadRegister2(Ab), .WriteRegister(RD), 
	.RegWrite(RegWrite), .clk(clk));
	
	//AluSrc mux
	mux2_1_Inbit64  ALUScrMux2(.in1(ImmCntrlOut), .in2(BRegOut), .sel(AluSrc), .out(B));
	
	
	// ALuOp mux
	alu AluOperator(.A(A), .B(B), .cntrl(ALuOp), .result(result), .negative(negative), .zero(zero), .overflow(overflow), .carry_out(AluCout));
	
	// SetFlag mux
	logic SetNegOut, SetOverOut;
	mux2_1 SetFlagNegative(.in({negative, NegFlag}), .sel(SetFlag), .out(SetNegOut)); 
	
	mux2_1 SetFlagOverFlow(.in({overflow, OverFlag}), .sel(SetFlag), .out(SetOverOut));
	
	
	// Output Flags for ADDS and SUBS instr
	D_FF NegFlags(.q(NegFlag), .d(SetNegOut), .clk(clk));
	D_FF OverFlow(.q(OverFlag), .d(SetOverOut), .clk(clk));
	
	
	// Data memory
	datamem Mem(.address(result), .write_enable(MemWrite), .read_enable(1'b1), .write_data(BRegOut), .clk(clk), .xfer_size(4'b1000), .read_data(memOut) );
	
	
	// mux MemToReg
	mux2_1_Inbit64 MemToRegMux3(.in1(memOut), .in2(result), .sel(MemToReg), .out(MemToRegOUt));
	
	
	// LSR shift shift modules      / 0: left, 1: right
	shifter shiftShamnt(.value(A), .direction(1'b1), .distance(shamt), .result(shift3Out));
	
	// LSR controlmux
	mux2_1_Inbit64 LSRMux4(.in1(shift3Out), .in2(MemToRegOUt), .sel(LSRShift), .out(DW));
	
	// Immideate control mux
	mux2_1_Inbit64 ImmCntrMux5(.in1(Imm12), .in2(DAddr9), .sel(ImmCntr), .out(ImmCntrlOut));
endmodule

	
// 2:1 mux for RegTOLoc
module mux2_1_Inbit5 (in1, in2, sel, out);
	output [4:0]   out;
	input [4:0]    in1, in2;
	input          sel;

	logic [4:0] temp1, temp2;
	logic selBar;
	
	not a1(selBar, sel);
	genvar k;
	
	generate
	  for (k = 0; k < 5; k++) begin : loop_gen_block
		and andOne(temp1[k], in1[k], sel);
		and andTwo(temp2[k], in2[k], selBar);
		or  OrOne(out[k], temp1[k], temp2[k]);
	  end
	endgenerate
	
endmodule

// 2:1 mux for BrTaken, UnconBr, MemToReg and ALUSrc, LSRSbit, ImmCntrl
module mux2_1_Inbit64 (in1, in2, sel, out);
	output [63:0]   out;
	input [63:0]    in1, in2;
	input          sel;

	logic [63:0] temp1, temp2;
	logic selBar;
	
	not a1(selBar, sel);
	genvar k;
	
	generate
	  for (k = 0; k < 64; k++) begin : loop_gen_block
		and andOne(temp1[k], in1[k], sel);
		and andTwo(temp2[k], in2[k], selBar);
		or  OrOne(out[k], temp1[k], temp2[k]);
	  end
	endgenerate
	
endmodule

// programCounter
module Program_Counter(clk, reset, instruction_in, instruction_out);
	input logic clk, reset;
	input logic [63:0] instruction_in;
	output reg [63:0] instruction_out;
	
	genvar k;
	
	generate 
	
		for (k = 0; k < 64; k++) begin :	programCounter
			D_FF_Reset programCounter(.clk(clk), .reset(reset), .d(instruction_in[k]), .q(instruction_out[k]));
		end
	endgenerate
	
endmodule



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
	