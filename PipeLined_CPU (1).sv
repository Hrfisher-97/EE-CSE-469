module PipeLined_CPU(clk, reset);
	input logic clk, reset;

	logic [31:0] instr;

	// Registered output wires //stage 1
	logic [31:0] RegInstr; // registered intruction after stage 1
	// stage 2
	logic [63:0] RegA, RegB; // registered data from regfile after stage 2
	logic [31:0] RegInstr1;
	//stage 3
	logic [63:0] RegALUResult; // registered ALU result after stage 3
	logic [63:0] RegDataIn;   // next registered from read data B going into data memory
	logic [31:0] RegInstr2;
	//stage 4 before writeback
	logic [63:0] RegMemToRegOut; //regitstered output from memToReg
	logic [31:0] RegInstr3;
	
	// Control Logic opcodes
	logic [10:0] opcode11;
	logic [9:0]  opcode10;
	logic [7:0]  opcode8;
	logic [5:0]  opcode6;
	
	assign opcode11 = RegInstr[31:21];
	assign opcode10 = RegInstr[31:22];
	assign opcode8 = RegInstr[31:24];
	assign opcode6 = RegInstr[31:26];
	
	// control logic variables 
	logic Reg2Loc, AluSrc, MemToReg, RegWrite, MemWrite, BranchTaken, UncondBr, LSRShift, ImmCntr, SetFlag;
	logic [2:0] ALuOp;
	
	logic [12:0] controls, controls0, controls1, controls2, controls3;
	
	assign controls = {Reg2Loc, AluSrc, MemToReg, RegWrite, MemWrite, BranchTaken, UncondBr, LSRShift, ImmCntr, SetFlag, ALuOp};
	
	logic [4:0] RD, RM, RN, Ab;
	
	// DAddr's of different instructions types
	logic [8:0] imm9;
	logic [11:0] imm12;
	logic [18:0] imm19;
	logic [25:0] imm26;

	assign imm9 = RegInstr[20:12];
	assign imm12 = RegInstr[21:10];
	assign imm19 = RegInstr[23:5];
	assign imm26 = RegInstr[25:0];
	 
	
	
	assign RD = RegInstr3[4:0];
	assign RN = RegInstr[9:5];
	assign RM = RegInstr[20:16];
	
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
	assign shamt = RegInstr2[15:10];
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
	
	
	logic [63:0] UncondAdderOut;
	logic [63:0] NextInstr; // out of BrTaken
	logic [63:0] Adder4BitOUt;
	
	
	
	mux2_1_Inbit64 BrTakenMux5(.in1(UncondAdderOut), .in2(Adder4BitOUt), .sel(BranchTaken), .out(NextInstr));
	
	
	
	// program counter
	// ***************************************************************************************************
	
	Program_Counter PCount(.clk(clk), .reset(reset), .instruction_in(NextInstr), .instruction_out(OutputPC));
	
	
	mux2_1_Inbit64 UncodBRMux6(.in1(BrAddr26), .in2(CondADr19), .sel(UncondBr), .out(UncodMuxOut));
	
	
	shifter shift2(.value(UncodMuxOut), .direction(1'b0), .distance(6'b000010), .result(shift2Out));
	
	
	
	Adder64Bit UncondAdder(.A(shift2Out), .B(OutputPC), .Sum(UncondAdderOut));
	
	
	Adder64Bit Adder4Bit(.A(OutputPC), .B({60'b0, 4'b0100}), .Sum(Adder4BitOUt));
	
	
	instructmem instructiOUt(.address(OutputPC), .instruction(instr), .clk(clK));
	
	// ***************************************************************************************************
	// Stage 1: Instruction Fetch
	// ***************************************************************************************************
	
	// pipeline rigstere
	parallel_register32  stage1(.clk(clk), .inbits(instr), .out(RegInstr)); // register 1
	parallel_register13 stage2d(.clk(clk), .inbits(controls), .out(controls0)); // controls signals

	signextender9 extension1(.unextended(imm9), .extended(DAddr9));  //imm19, D-type Instruction
	UnSignextender12 extension2(.unextended(imm12), .extended(Imm12)); //imm12 Unsigned, I-Type instruction
	signextender19 extension3(.unextended(imm19), .extended(CondADr19)); // imm19 signed, CB-type Instruction
	signextender26 extension4(.unextended(imm26), .extended(BrAddr26)); // imm26 signed, B-type Instruction
 
	
	// Regfile| ALU | Data Memmory
	
	// Reg2Loc mux
	mux2_1_Inbit5 RegToLocMux1(.in1(RM), .in2(RD), .sel(Reg2Loc), .out(Ab)); 

	
	// ***************************************************************************************************
	// Stage 2: Register Fetch
	// ***************************************************************************************************
	// Regfile
	regfile FileRegister(.ReadData1(A), .ReadData2(BRegOut), .WriteData(DW), .ReadRegister1(RN),  .ReadRegister2(Ab), .WriteRegister(RD), 
	.RegWrite(RegWrite), .clk(clk));
	
	//comparator forwarding controls
	logic sel1, sel2, sel3, sel4, sel5, sel6;
	
	or or1(sel5, sel1, sel2);
	or or2(sel6, sel3, sel4);
	
	logic [63:0] Anext, Bnext;
	logic [63:0] ALUSel, ALUSel2;
	
	// pipeline rigsteres
	parallel_register64 stage2A(.clk(clk), .inbits(Anext), .out(RegA)); // Registered A port into ALU
	parallel_register64 stage2B(.clk(clk), .inbits(Bnext), .out(RegB)); // Registered B port into ALU
	
	parallel_register32  stage2C(.clk(clk), .inbits(RegInstr), .out(RegInstr1)); // insruction
	parallel_register13 stage2D(.clk(clk), .inbits(controls0), .out(controls1)); // controls signals
	
	
	// compare Rd from stage 4 to Rn from stage 2
   comparator compRnRd4(.RN(RegInstr[9:5]), .RD(RegInstr2[4:0]), .Regwrite(controls2[9]), .selectSignal(sel1));
	
	// compare Rd from stage 4 to Rn from stage 2
	comparator compRnRd2(.RN(RegInstr[9:5]), .RD(RegInstr1[4:0]), .Regwrite(controls1[9]), .selectSignal(sel2));
	
	// compare Rd from stage 3 to Rm from stage 2
   comparator compRmRd4(.RN(RegInstr[20:16]), .RD(RegInstr2[4:0]), .Regwrite(controls2[9]), .selectSignal(sel3));
	
	// compare Rd from stage 3 to Rm from stage 2
	comparator compRmRd2(.RN(RegInstr[20:16]), .RD(RegInstr1[4:0]), .Regwrite(controls1[9]), .selectSignal(sel4));
	
	mux2_1_Inbit64 MuxALU3ALU2A(.in1(result), .in2(MemToRegOUt), .sel(sel2), .out(ALUSel1));
	mux2_1_Inbit64 MuxALU3ALU2B(.in1(result), .in2(MemToRegOUt), .sel(sel4), .out(ALUSel2)); 
	
	mux2_1_Inbit64 MuxDbALU1A(.in1(ALUSel1), .in2(A), .sel(sel5), .out(Anext));
	mux2_1_Inbit64 MuxDbALU1B(.in1(ALUSel2), .in2(BRegOut), .sel(sel6), .out(Bnext));
	
//	//forwarding mux for exeution stage after ALU
//	mux2_1_Inbit64 MuxDaALU1(.in1(RegALUResult), .in2(A), .sel(select1), .out(Anext)); 
//	mux2_1_Inbit64 MuxDbALU1(.in1(RegALUResult), .in2(BRegOut), .sel(select2), .out(Bnext));
			
	// passed RegB for in2 instead of BRegOut from regfile
	mux2_1_Inbit64  ALUScrMux2(.in1(ImmCntrlOut), .in2(RegB), .sel(AluSrc), .out(B)); //AluSrc mux
	
	
		// ***************************************************************************************************
	// Stage 3: ALU Execute
	// ***************************************************************************************************
	
	// ALuOp mux |pass RegA for input A instead of A from regfile
	alu AluOperator(.A(RegA), .B(B), .cntrl(ALuOp), .result(result), .negative(negative), .zero(zero), .overflow(overflow), .carry_out(AluCout));
	
	// pipeline rigsteres
	parallel_register64 stage3A(.clk(clk), .inbits(result), .out(RegALUResult)); // ALU register
	parallel_register64 stage3B(.clk(clk), .inbits(RegB), .out(RegDataIn));
	
	parallel_register32  stage3C(.clk(clk), .inbits(RegInstr1), .out(RegInstr2)); // insruction
	parallel_register13 stage3d(.clk(clk), .inbits(controls1), .out(controls2)); // controls signals
	
	
	// SetFlag mux for overflow and negative flags
	logic SetNegOut, SetOverOut;
	mux2_1 SetFlagNegative(.in({negative, NegFlag}), .sel(SetFlag), .out(SetNegOut)); 
	
	mux2_1 SetFlagOverFlow(.in({overflow, OverFlag}), .sel(SetFlag), .out(SetOverOut));
	
	
	// Output Flags for ADDS and SUBS instr
	D_FF NegFlags(.q(NegFlag), .d(SetNegOut), .clk(clk));
	D_FF OverFlow(.q(OverFlag), .d(SetOverOut), .clk(clk));
	
	
	// ***************************************************************************************************
	// Stage 4: Mem Data Memory
	// ***************************************************************************************************
	
	// Data memory | pass RegALUResult for address instead of result
	datamem Mem(.address(RegALUResult), .write_enable(MemWrite), .read_enable(1'b1), .write_data(RegDataIn), .clk(clk), .xfer_size(4'b1000), .read_data(memOut) );
	
	
	// pipeline rigsteres
//	parallel_register64 stage4A(.clk(clk), .inbits(RegALUResult), .out(RegALUAddr)); // ALU register
//	parallel_register64 stage4B(.clk(clk), .inbits(memOut), .out(RegMemOut));
//	parallel_register32  stage4C(.clk(clk), .inbits(RegInstr2), .out(RegInstr3)); // insruction
//	parallel_register13 stage4d(.clk(clk), .inbits(controls2), .out(controls3)); // controls signals
	
	
	
	// ***************************************************************************************************
	// Stage 5: Write Back
	// ***************************************************************************************************
	// mux MemToReg, pass RegMemOut for in1 instead of memOut and RegALUAddr instead of result
	mux2_1_Inbit64 MemToRegMux3(.in1(memOut), .in2(RegALUResult), .sel(MemToReg), .out(MemToRegOUt));
	
	parallel_register64 stage4A(.clk(clk), .inbits(MemToRegOUt), .out(RegMemToRegOut));
	parallel_register32  stage4C(.clk(clk), .inbits(RegInstr2), .out(RegInstr3)); // insruction
	parallel_register13 stage4d(.clk(clk), .inbits(controls2), .out(controls3)); // controls signals
	
	
	// LSR shift shift modules      / 0: left, 1: right
	shifter shiftShamnt(.value(A), .direction(1'b1), .distance(shamt), .result(shift3Out));
	
	// LSR controlmux
	mux2_1_Inbit64 LSRMux4(.in1(shift3Out), .in2(RegMemToRegOut), .sel(LSRShift), .out(DW));
	
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
	
module comparator( 
			input logic [4:0] RN, 
			input logic [4:0] RD,
			input logic        Regwrite,
			output logic      selectSignal);

	logic [4:0] temp;
	
	logic signal; // compare signal
	
		genvar k;
	
	generate
	
	for (k = 0; k < 5; k++) begin :	Adder64
			xor xor1(temp[k], RN[k], RD[k]) ;
		end
	endgenerate
	
	nor nor1(signal, temp[0], temp[1], temp[2], temp[3], temp[4]);
	and and1(selectSignal, Regwrite, signal);
endmodule

