module Single_Cycle_CPU(instr);
	input logic [31:0] instr;

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


	// Control Logic

	wire [10:0] opcode11;
	wire [9:0]  opcode10;
	wire [7:0]  opcode8;
	wire [5:0]  opcode6;
	
	
	
	wire Reg2Loc, AluSrc, MemToReg, RegWrite, MemWrite, BranchTaken, UncondBr;
	wire [2:0] ALupOp;
	wire 

	always_comb begin
		case(opcode6)
			//B
			11'b000101:
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
				
			default: case(opcope8)
					//CBZ
					11'b10110100:
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
										UncondBr    = 1'b0;
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
										UncondBr    = 1'b0;
										ALupOp      = 3'b010;
										end
									//LDUR
									11'b11111000010:
										begin 
										Reg2Loc     = 1'b1;
										AluSrc      = 1'b0;
										MemToReg    = 1'b0;
										RegWrite    = 1'b1;
										MemWrite    = 1'b0;
										BranchTaken = 1'b0;
										UncondBr    = 1'b0;
										ALupOp      = 3'b010;
										end
									//STUR
									11'b11111000000:
										begin 
										Reg2Loc     = 1'b1;
										AluSrc      = 1'b0;
										MemToReg    = 1'b0;
										RegWrite    = 1'b1;
										MemWrite    = 1'b0;
										BranchTaken = 1'b0;
										UncondBr    = 1'b0;
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
	
 // 16-bit sign Extension
module signextender16(
  input [7:0] unextended,//the msb bit is the sign bit
  input clk,
  output reg [15:0] extended );

always@(posedge clk)
  begin 
    extended <= $signed(unextended);
  end
  
endmodule
