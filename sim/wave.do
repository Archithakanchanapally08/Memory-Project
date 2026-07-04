onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/dut/clk_i
add wave -noupdate /top/dut/rst_i
add wave -noupdate -group Handshake /top/dut/valid_i
add wave -noupdate -group Handshake /top/dut/ready_o
add wave -noupdate -group Data /top/dut/wr_rd_i
add wave -noupdate -group Data /top/dut/addr_i
add wave -noupdate -group Data -radix hexadecimal /top/dut/wdata_i
add wave -noupdate -group Data /top/dut/rdata_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {51 ns} 0}
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
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {488 ns}
