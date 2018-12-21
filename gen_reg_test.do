vsim work.generalregisters

add wave -position insertpoint  \
sim:/generalregisters/REGS_COUNT \
sim:/generalregisters/BUS_WIDTH \
sim:/generalregisters/clk \
sim:/generalregisters/rst \
sim:/generalregisters/src \
sim:/generalregisters/dst \
sim:/generalregisters/bus_A \
sim:/generalregisters/bus_B \
sim:/generalregisters/temp
force -freeze sim:/generalregisters/rst 1 0
run
force -freeze sim:/generalregisters/rst 0 0
run
force -freeze sim:/generalregisters/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/generalregisters/dst 01 0 -cancel 100
force -freeze sim:/generalregisters/bus_B 0010 0

