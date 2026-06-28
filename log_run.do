#--> Compilation:-
vlog memory_tb.v

#--> Elaboration:- 
set testname test_nwr_nrd
set timestamp [clock format [clock seconds] -format "%d_%m_%y_%H_%M_%S"]
vsim -novopt -suppress 12110 top +testname=$testname -l "${testname}_${timestamp}.log" 

#--> Adding the waveform:-
add wave -position insertpoint sim:/top/dut/*

#--> Simulation:-
run -all 


