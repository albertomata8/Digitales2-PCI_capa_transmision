all: memoria

memoria:
	yosys -s memoria.ys
	sed -i "s/memoria/memoria_synth/g" memoria_synth.v
	sed -i "s/FIFO_data_out/FIFO_data_out_synth/g" memoria_synth.v
	iverilog bancopruebas_memoria.v -o banco
	vvp banco
	rm banco
	gtkwave memoria.vcd
