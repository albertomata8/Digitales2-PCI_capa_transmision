all: full_logic

full_logic:
	yosys -s full_logic.ys
	sed -i 's/data_out_D0/data_out_D0_synth/g' full_logic_synth.v
	sed -i 's/data_out_D1/data_out_D1_synth/g' full_logic_synth.v
	sed -i 's/state_machine/state_machine_synth/g' full_logic_synth.v
	sed -i 's/main_fifo/main_fifo_synth/g' full_logic_synth.v
	sed -i 's/D0_fifo/D0_fifo_synth/g' full_logic_synth.v
	sed -i 's/D1_fifo/D1_fifo_synth/g' full_logic_synth.v
	sed -i 's/VC0_fifo/VC0_fifo_synth/g' full_logic_synth.v
	sed -i 's/VC1_fifo/VC1_fifo_synth/g' full_logic_synth.v
	sed -i 's/arbitro_enrutamiento/arbitro_enrutamiento_synth/g' full_logic_synth.v
	sed -i 's/arbitro_mux/arbitro_mux_synth/g' full_logic_synth.v
	sed -i 's/comb_initial/comb_initial_synth/g' full_logic_synth.v
	sed -i 's/demux_initial/demux_initial_synth/g' full_logic_synth.v
	sed -i 's/final_logic/final_logic_synth/g' full_logic_synth.v
	sed -i 's/full_logic/full_logic_synth/g' full_logic_synth.v
	sed -i 's/initial_logic/initial_logic_synth/g' full_logic_synth.v
	sed -i 's/logica_pops/logica_pops_synth/g' full_logic_synth.v
	sed -i 's/pop_main_fifo_synth/pop_main_fifo/g' full_logic_synth.v
	sed -i 's/data_in_demux_initial_synth/data_in_demux_initial/g' full_logic_synth.v
	sed -i 's/data_out_demux_initial_synth_vc0/data_out_demux_initial_vc0/g' full_logic_synth.v
	sed -i 's/data_out_demux_initial_synth_vc1/data_out_demux_initial_vc1/g' full_logic_synth.v
	sed -i 's/empty_main_fifo_synth/empty_main_fifo/g' full_logic_synth.v
	iverilog -o prueba banco_full_logic.v cmos_cells.v

	vvp prueba
	gtkwave prueba_full_logic.vcd