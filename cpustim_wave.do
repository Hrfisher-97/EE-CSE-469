onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpustim/cpu/clk
add wave -noupdate /cpustim/cpu/reset
add wave -noupdate /cpustim/cpu/instr
add wave -noupdate /cpustim/cpu/RegInstr
add wave -noupdate /cpustim/cpu/RegInstr1
add wave -noupdate /cpustim/cpu/RegInstr2
add wave -noupdate /cpustim/cpu/RegInstr3
add wave -noupdate /cpustim/cpu/controls
add wave -noupdate /cpustim/cpu/controls0
add wave -noupdate /cpustim/cpu/controls1
add wave -noupdate /cpustim/cpu/controls2
add wave -noupdate /cpustim/cpu/controls3
add wave -noupdate /cpustim/cpu/sel1
add wave -noupdate /cpustim/cpu/sel2
add wave -noupdate /cpustim/cpu/sel3
add wave -noupdate /cpustim/cpu/sel4
add wave -noupdate /cpustim/cpu/sel5
add wave -noupdate /cpustim/cpu/sel6
add wave -noupdate /cpustim/cpu/opcode11
add wave -noupdate /cpustim/cpu/opcode10
add wave -noupdate /cpustim/cpu/opcode8
add wave -noupdate /cpustim/cpu/opcode6
add wave -noupdate /cpustim/cpu/Reg2Loc
add wave -noupdate /cpustim/cpu/AluSrc
add wave -noupdate /cpustim/cpu/MemToReg
add wave -noupdate /cpustim/cpu/RegWrite
add wave -noupdate /cpustim/cpu/MemWrite
add wave -noupdate /cpustim/cpu/BranchTaken
add wave -noupdate /cpustim/cpu/UncondBr
add wave -noupdate /cpustim/cpu/LSRShift
add wave -noupdate /cpustim/cpu/ALuOp
add wave -noupdate /cpustim/cpu/RD
add wave -noupdate /cpustim/cpu/RM
add wave -noupdate /cpustim/cpu/RN
add wave -noupdate /cpustim/cpu/Ab
add wave -noupdate -childformat {{{/cpustim/cpu/FileRegister/registers[31]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[30]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[29]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[28]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[27]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[26]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[25]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[24]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[23]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[22]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[21]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[20]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[19]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[18]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[17]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[16]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[15]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[14]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[13]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[12]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[11]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[10]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[9]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[8]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[7]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[6]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[5]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[4]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[3]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[2]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[1]} -radix decimal} {{/cpustim/cpu/FileRegister/registers[0]} -radix decimal}} -subitemconfig {{/cpustim/cpu/FileRegister/registers[31]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[30]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[29]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[28]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[27]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[26]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[25]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[24]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[23]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[22]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[21]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[20]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[19]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[18]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[17]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[16]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[15]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[14]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[13]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[12]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[11]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[10]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[9]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[8]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[7]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[6]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[5]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[4]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[3]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[2]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[1]} {-height 15 -radix decimal} {/cpustim/cpu/FileRegister/registers[0]} {-height 15 -radix decimal}} /cpustim/cpu/FileRegister/registers
add wave -noupdate /cpustim/cpu/RegA
add wave -noupdate /cpustim/cpu/RegB
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[88]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[87]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[86]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[85]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[84]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[83]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[82]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[81]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[80]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[79]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[78]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[77]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[76]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[75]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[74]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[73]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[72]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[71]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[70]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[69]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[68]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[67]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[66]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[65]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[64]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[63]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[62]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[61]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[60]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[59]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[58]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[57]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[56]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[55]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[54]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[53]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[52]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[51]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[50]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[49]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[48]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[47]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[46]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[45]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[44]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[43]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[42]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[41]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[40]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[39]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[38]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[37]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[36]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[35]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[34]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[33]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[32]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[31]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[30]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[29]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[28]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[27]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[26]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[25]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[24]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[23]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[22]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[21]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[20]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[19]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[18]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[17]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[16]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[15]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[14]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[13]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[12]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[11]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[10]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[9]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[8]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[7]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[6]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[5]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[4]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[3]}
add wave -noupdate -group Mem {/cpustim/cpu/Mem/mem[2]}
add wave -noupdate /cpustim/cpu/imm9
add wave -noupdate /cpustim/cpu/imm12
add wave -noupdate /cpustim/cpu/imm19
add wave -noupdate /cpustim/cpu/imm26
add wave -noupdate /cpustim/cpu/DW
add wave -noupdate /cpustim/cpu/A
add wave -noupdate /cpustim/cpu/B
add wave -noupdate /cpustim/cpu/BRegOut
add wave -noupdate /cpustim/cpu/DAddr9
add wave -noupdate /cpustim/cpu/Imm12
add wave -noupdate /cpustim/cpu/CondADr19
add wave -noupdate /cpustim/cpu/BrAddr26
add wave -noupdate /cpustim/cpu/NextInstr
add wave -noupdate /cpustim/cpu/UncondAdderOut
add wave -noupdate /cpustim/cpu/Adder4BitOUt
add wave -noupdate /cpustim/cpu/OutputPC
add wave -noupdate /cpustim/cpu/UncodMuxOut
add wave -noupdate /cpustim/cpu/shift2Out
add wave -noupdate /cpustim/cpu/clK
add wave -noupdate /cpustim/cpu/result
add wave -noupdate /cpustim/cpu/ImmCntr
add wave -noupdate /cpustim/cpu/SetFlag
add wave -noupdate /cpustim/cpu/zero
add wave -noupdate /cpustim/cpu/overflow
add wave -noupdate /cpustim/cpu/negative
add wave -noupdate /cpustim/cpu/AluCout
add wave -noupdate /cpustim/cpu/ZeroFlag
add wave -noupdate /cpustim/cpu/NegFlag
add wave -noupdate /cpustim/cpu/OverFlag
add wave -noupdate /cpustim/cpu/memOut
add wave -noupdate /cpustim/cpu/MemToRegOUt
add wave -noupdate /cpustim/cpu/shamt
add wave -noupdate /cpustim/cpu/shift3Out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19736036 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {31538 ps}
