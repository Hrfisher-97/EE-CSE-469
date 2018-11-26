# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./alu.sv"
vlog "./Alubit.sv"
# vlog "./alustim.sv"

vlog "./regfile.sv"
vlog "./DFF.sv"
vlog "./decoder.sv"
vlog "./mux32_64_64.sv"
# vlog "./regstim.sv"

vlog "./DFF.sv"
vlog "./datamem.sv"
vlog "./instructmem.sv"
vlog "./SignExtensions.sv"
vlog "./shifters.sv"
vlog "./PipeLined_CPU.sv"
vlog "./Single_Cycle_CPU_stim.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work cpustim

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do cpustim_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
