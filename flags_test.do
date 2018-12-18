vsim work.alu
# vsim work.alu 
# Start time: 02:16:32 on Dec 18,2018
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.alu(structural_behavioural)
# Loading work.parta(structural)
# Loading work.my_nadder(a_my_adder)
# Loading work.my_adder(a_my_adder)
# Loading work.partb(basic)
# Loading work.partc(rights)
# Loading work.partd(lefts)
add wave -position end sim:/alu/*
force -freeze sim:/alu/A UUUUUUUUUUUUUUU 0
# Value length (15) does not equal array index length (16).
# 
# ** Error: (vsim-4011) Invalid force value: UUUUUUUUUUUUUUU 0.
# 
force -freeze sim:/alu/A 0111111111111111 0
force -freeze sim:/alu/B 0111111111111111 0
force -freeze sim:/alu/Cin 0 0
force -freeze sim:/alu/Sel 0001 0
run
force -freeze sim:/alu/A 0000000000000000 0
force -freeze sim:/alu/Sel 0000 0
run
force -freeze sim:/alu/A 1001110000000000 0
force -freeze sim:/alu/Sel 0010 0
run