all: arb

arb:
	#yosys -s arbitro_enrutamiento.ys
	#sed -i "s/arbitro_enrutamiento/arbitro_enrutamiento_synth/g" arbitro_enrutamiento_synth.v
	#sed -i "s/arbitro_demux/arbitro_demux_synth/g" arbitro_enrutamiento_synth.v
	#sed -i "s/arbitro_mux/arbitro_mux_synth/g" arbitro_enrutamiento_synth.v
	#sed -i "s/logica_pops/logica_pops_synth/g" arbitro_enrutamiento_synth.v
	#sed -i "s/VC0_pop/VC0_pop_synth/g" arbitro_enrutamiento_synth.v
	#sed -i "s/VC1_pop/VC1_pop_synth/g" arbitro_enrutamiento_synth.v
	#sed -i "s/D0_out/D0_out_synth/g" arbitro_enrutamiento_synth.v
	#sed -i "s/D1_out/D1_out_synth/g" arbitro_enrutamiento_synth.v
	iverilog banco_pruebas.v -o bancopruebas
	vvp bancopruebas
	gtkwave arbitro.vcd
