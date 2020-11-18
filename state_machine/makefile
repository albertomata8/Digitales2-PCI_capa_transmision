all: sm
sm:
	yosys -s state_machine.ys
	sed -i 's/state_machine/state_machine_synth/' state_machine_synth.v
	iverilog -o prueba.vvp BancoPruebas.v ../lib/cmos_cells.v
	vvp prueba.vvp
	gtkwave probador.vcd
	
