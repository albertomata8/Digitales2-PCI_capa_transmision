FINAL = ./final_logic/
ARBITRO = ./arbitro_muxes/
FULL = ./full_logic/
all: final_logic_mod arbitro full_logic

final_logic_mod:
	yosys -s ./final_logic/final_logic.ys
	sed -i "s/final_logic/final_logic_synth/g" $(FINAL)final_logic_synth.v
	sed -i "s/arbitro_enrutamiento/arbitro_enrutamiento_synth/g" $(FINAL)final_logic_synth.v
	sed -i "s/logica_pops/logica_pops_synth/g" $(FINAL)final_logic_synth.v
	sed -i "s/D0_fifo/D0_fifo_synth/g" $(FINAL)final_logic_synth.v
	sed -i "s/D1_fifo/D1_fifo_synth/g" $(FINAL)final_logic_synth.v
	sed -i "s/arbitro_mux/arbitro_mux_synth/g" $(FINAL)final_logic_synth.v
	sed -i "s/data_out_D0/data_out_D0_synth/g" $(FINAL)final_logic_synth.v
	sed -i "s/data_out_D1/data_out_D1_synth/g" $(FINAL)final_logic_synth.v
	sed -i "s/pop_VC0_fifo/pop_VC0_fifo_synth/g" $(FINAL)final_logic_synth.v
	sed -i "s/pop_VC1_fifo/pop_VC1_fifo_synth/g" $(FINAL)final_logic_synth.v
	sed -i "s/error_D0/error_D0_synth/g" $(FINAL)final_logic_synth.v
	sed -i "s/error_D1/error_D1_synth/g" $(FINAL)final_logic_synth.v
	iverilog ./final_logic/banco_final_logic.v -o final
	vvp final
	gtkwave final_logic.vcd

arbitro:
	yosys -s $(ARBITRO)arbitro_enrutamiento.ys
	sed -i "s/arbitro_enrutamiento/arbitro_enrutamiento_synth/g" $(ARBITRO)arbitro_enrutamiento_synth.v
	sed -i "s/arbitro_mux/arbitro_mux_synth/g" $(ARBITRO)arbitro_enrutamiento_synth.v
	sed -i "s/logica_pops/logica_pops_synth/g" $(ARBITRO)arbitro_enrutamiento_synth.v
	sed -i "s/VC0_pop/VC0_pop_synth/g" $(ARBITRO)arbitro_enrutamiento_synth.v
	sed -i "s/VC1_pop/VC1_pop_synth/g" $(ARBITRO)arbitro_enrutamiento_synth.v
	sed -i "s/D0_out/D0_out_synth/g" $(ARBITRO)arbitro_enrutamiento_synth.v
	sed -i "s/D1_out/D1_out_synth/g" $(ARBITRO)arbitro_enrutamiento_synth.v
	iverilog $(ARBITRO)banco_pruebas.v -o bancopruebas_arbitro
	vvp bancopruebas_arbitro
	gtkwave arbitro.vcd

full_logic_make:
	yosys -s $(FULL)full_logic.ys
	sed -i 's/data_out_D0/data_out_D0_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/data_out_D1/data_out_D1_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/state_machine/state_machine_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/main_fifo/main_fifo_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/D0_fifo/D0_fifo_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/D1_fifo/D1_fifo_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/VC0_fifo/VC0_fifo_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/VC1_fifo/VC1_fifo_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/arbitro_enrutamiento/arbitro_enrutamiento_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/arbitro_mux/arbitro_mux_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/comb_initial/comb_initial_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/demux_initial/demux_initial_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/final_logic/final_logic_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/full_logic/full_logic_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/initial_logic/initial_logic_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/logica_pops/logica_pops_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/pop_main_fifo_synth/pop_main_fifo/g' $(FULL)full_logic_synth.v
	sed -i 's/data_in_demux_initial_synth/data_in_demux_initial/g' $(FULL)full_logic_synth.v
	sed -i 's/data_out_demux_initial_synth_vc0/data_out_demux_initial_vc0/g' $(FULL)full_logic_synth.v
	sed -i 's/data_out_demux_initial_synth_vc1/data_out_demux_initial_vc1/g' $(FULL)full_logic_synth.v
	sed -i 's/empty_main_fifo_synth/empty_main_fifo/g' $(FULL)full_logic_synth.v
	sed -i 's/empty_fifo_D0/empty_fifo_D0_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/empty_fifo_D1/empty_fifo_D1_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/error_D0/error_D0_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/error_D1/error_D1_synth/g' $(FULL)full_logic_synth.v
	sed -i 's/retraso1/retraso1_synth/g' $(FULL)full_logic_synth.v
	iverilog -o $(FULL)prueba $(FULL)banco_full_logic.v
	vvp $(FULL)prueba
	gtkwave prueba_full_logic.vcd
	#rm $(FULL)prueba prueba_full_logic.vcd