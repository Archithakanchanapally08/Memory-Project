#--> Compilation:-
vlog memory_tb.v

#--> Elaboration:- 
vsim -novopt -suppress 12110 top +testname=test_rand_wr_rd

#--> Adding the waveform:-
#add wave -position insertpoint sim:/top/dut/*
do wave.do

#--> Simulation:-
run -all 
