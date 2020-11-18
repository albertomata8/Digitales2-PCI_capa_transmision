all: initial_logic

initial_logic:
	yosys -s initial_logic.ys
	sed -i 's/VC0_fifo/VC0_fifo_synth/' initial_logic_synth.v
	sed -i 's/VC1_fifo/VC1_fifo_synth/' initial_logic_synth.v
	sed -i 's/comb_initial/comb_initial_synth/' initial_logic_synth.v
	sed -i 's/demux_initial/demux_initial_synth/' initial_logic_synth.v
	sed -i 's/initial_logic/initial_logic_synth/' initial_logic_synth.v
	sed -i 's/main_fifo/main_fifo_synth/' initial_logic_synth.v
	sed -i 's/empty_main_fifo_synth/empty_main_fifo/' initial_logic_synth.v
	sed -i 's/pop_main_fifo_synth/pop_main_fifo/' initial_logic_synth.v
	sed -i 's/data_in_demux_initial_synth/data_in_demux_initial/' initial_logic_synth.v
	sed -i 's/data_out_demux_initial_synth_vc0/data_out_demux_initial_vc0/' initial_logic_synth.v
	sed -i 's/data_out_demux_initial_synth_vc1/data_out_demux_initial_vc1/' initial_logic_synth.v
	sed -i 's/pop_VC0_fifo_synth/pop_VC0_fifo/' initial_logic_synth.v
	sed -i 's/pop_VC1_fifo_synth/pop_VC1_fifo/' initial_logic_synth.v
	iverilog -o prueba banco_initial_logic.v ../lib/cmos_cells.v
	vvp prueba
	gtkwave prueba_initial_logic.vcd