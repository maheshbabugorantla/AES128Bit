onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/clk
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/n_rst
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/encryptEnable
add wave -noupdate -radix hexadecimal /tb_encryption_block/ENCRYPT_BLK/inputData
add wave -noupdate -radix hexadecimal /tb_encryption_block/ENCRYPT_BLK/key
add wave -noupdate -radix hexadecimal /tb_encryption_block/ENCRYPT_BLK/outputData
add wave -noupdate -radix hexadecimal /tb_encryption_block/ENCRYPT_BLK/byteSubData
add wave -noupdate -radix hexadecimal /tb_encryption_block/ENCRYPT_BLK/shiftRowData
add wave -noupdate -radix hexadecimal /tb_encryption_block/ENCRYPT_BLK/mix_cols_Out
add wave -noupdate -radix hexadecimal /tb_encryption_block/ENCRYPT_BLK/roundKeys
add wave -noupdate -radix unsigned /tb_encryption_block/ENCRYPT_BLK/count
add wave -noupdate /tb_encryption_block/ENCRYPT_BLK/sub_bytes_enable
add wave -noupdate /tb_encryption_block/ENCRYPT_BLK/shift_rows_enable
add wave -noupdate /tb_encryption_block/ENCRYPT_BLK/mix_cols_enable
add wave -noupdate /tb_encryption_block/ENCRYPT_BLK/start
add wave -noupdate /tb_encryption_block/ENCRYPT_BLK/clear
add wave -noupdate /tb_encryption_block/ENCRYPT_BLK/count_enable
add wave -noupdate /tb_encryption_block/ENCRYPT_BLK/control_output
add wave -noupdate /tb_encryption_block/ENCRYPT_BLK/done
add wave -noupdate -radix hexadecimal /tb_encryption_block/ENCRYPT_BLK/tempOutputData
add wave -noupdate -radix hexadecimal /tb_encryption_block/ENCRYPT_BLK/tempOutputData1
add wave -noupdate -radix hexadecimal /tb_encryption_block/ENCRYPT_BLK/tempOutputData2
add wave -noupdate -divider Encryption
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/clk
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/n_rst
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/encryptEnable
add wave -noupdate -radix unsigned /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/count
add wave -noupdate -radix hexadecimal /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/dataIn
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/mix_cols_enable
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/sub_bytes_enable
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/shift_rows_enable
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/start
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/clear
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/count_enable
add wave -noupdate -radix binary /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/control_output
add wave -noupdate -radix hexadecimal /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/encryptedOut
add wave -noupdate /tb_encryption_block/ENCRYPT_BLK/ENCRYPTION_CONTROLLER/currentState
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {Encrypted_Value_1 {375623 ps} 1} {Encrypted_Value_2 {719547 ps} 1} {Encrypted_Value_3 {1035916 ps} 1} {Encrypted_Value_4 {1323396 ps} 1} {Encrypted_Value_5 {1645132 ps} 1} {OutputValue {3597736 ps} 0}
quietly wave cursor active 6
configure wave -namecolwidth 188
configure wave -valuecolwidth 348
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
WaveRestoreZoom {0 ps} {4200 ns}
