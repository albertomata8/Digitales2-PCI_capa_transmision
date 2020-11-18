all: fifo

fifo:
	yosys -s fifo.ys
	sed -i "s/fifo/fifo_synth/g" fifo_synth.v
	sed -i "s/data_out/data_out_synth/g" fifo_synth.v
	iverilog bancopruebas_fifo.v -o banco
	vvp banco
	rm banco
	gtkwave fifo.vcd
