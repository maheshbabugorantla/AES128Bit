onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Test Bench}
add wave -noupdate -radix unsigned /tb_decryption_block/test_case_number
add wave -noupdate -radix binary /tb_decryption_block/tb_clk
add wave -noupdate -radix binary /tb_decryption_block/tb_n_rst
add wave -noupdate -radix binary /tb_decryption_block/tb_decryptEnable
add wave -noupdate -radix hexadecimal /tb_decryption_block/tb_key
add wave -noupdate -radix hexadecimal /tb_decryption_block/tb_inputData
add wave -noupdate -radix hexadecimal /tb_decryption_block/tb_outputData
add wave -noupdate -divider {Decryption Block}
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/tempInputData
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/InvByteSubData
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/InvShiftRowData
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/mix_cols_Out
add wave -noupdate -radix unsigned /tb_decryption_block/DECRYPTION_BLK/count
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/rollover_flag
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/inv_sub_bytes_enable
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/inv_shift_rows_enable
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/inv_mix_cols_enable
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/inv_key_addition_enable
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/start
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/clear
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/count_enable
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/control_output
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/decryptedOutput
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/done
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/tempOutputData
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/tempOutputData1
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/tempOutputData2
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/tempOutputData3
add wave -noupdate -divider {Key Addition}
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/KEY_ADDITION/dataIn
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/KEY_ADDITION/enable
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/KEY_ADDITION/dataOut
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/KEY_ADDITION/roundKey
add wave -noupdate -radix unsigned /tb_decryption_block/DECRYPTION_BLK/KEY_ADDITION/count
add wave -noupdate -divider {Counter Logic}
add wave -noupdate /tb_decryption_block/DECRYPTION_BLK/COUNTER_TEN/clear
add wave -noupdate /tb_decryption_block/DECRYPTION_BLK/COUNTER_TEN/count_enable
add wave -noupdate /tb_decryption_block/DECRYPTION_BLK/COUNTER_TEN/rollover_val
add wave -noupdate /tb_decryption_block/DECRYPTION_BLK/COUNTER_TEN/count_out
add wave -noupdate /tb_decryption_block/DECRYPTION_BLK/COUNTER_TEN/rollover_flag
add wave -noupdate -divider {Decryption Controller}
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/decryptEnable
add wave -noupdate -radix unsigned /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/count
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/dataIn
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/inv_mix_cols_enable
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/inv_shift_rows_enable
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/inv_sub_bytes_enable
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/inv_key_addition_enable
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/start
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/clear
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/count_enable
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/control_output
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/decryptedOutput
add wave -noupdate -radix binary /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/done
add wave -noupdate -radix hexadecimal /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/temp_decryptedOut
add wave -noupdate /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/currentState
add wave -noupdate /tb_decryption_block/DECRYPTION_BLK/DECRYPTION_CONTROLLER/nextState
add wave -noupdate /tb_decryption_block/DECRYPTION_BLK/COUNTER_TEN/rollflag_1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {204166 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 190
configure wave -valuecolwidth 273
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
configure wave -timelineunits ps
update
WaveRestoreZoom {68766 ps} {312171 ps}
