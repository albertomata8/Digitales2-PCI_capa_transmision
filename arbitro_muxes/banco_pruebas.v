`include "./arbitro_muxes/arbitro_enrutamiento.v"
`include "./arbitro_muxes/probador_arbitro.v"
`include "./arbitro_muxes/arbitro_enrutamiento_synth.v"
`include "./lib/cmos_cells.v"

module bancopruebas();

    wire [5:0] VC0, VC1;
    wire [5:0] arbitro_D0_out, arbitro_D1_out, arbitro_D0_out_synth, arbitro_D1_out_synth;

arbitro_enrutamiento u_arbitro_enrutamiento(
    .VC0       ( VC0 [5:0]      ),
    .VC1       ( VC1 [5:0]      ),
    .clk       ( clk       ),
    .reset_L   ( reset_L   ),
    .VC0_empty ( VC0_empty ),
    .VC1_empty ( VC1_empty ),
    .VC1_pop   ( VC1_pop   ),
    .VC0_pop   ( VC0_pop   ),
    .arbitro_D0_out    ( arbitro_D0_out [5:0]       ),
    .arbitro_D1_out    ( arbitro_D1_out [5:0]       ),
    .D0_pause  ( D0_pause      ),
    .D1_pause  ( D1_pause      ),
    .D0_push   (D0_push),
    .D1_push   (D1_push)
);


probador_arbitro u_probador_arbitro(
    .VC0           ( VC0 [5:0]          ),
    .VC1           ( VC1 [5:0]          ),
    .clk           ( clk           ),
    .reset_L       ( reset_L       ),
    .D0_pause      ( D0_pause      ),
    .D1_pause      ( D1_pause      ),
    .VC0_pop       ( VC0_pop       ),
    .VC1_pop       ( VC1_pop       ),
    .VC0_empty     ( VC0_empty     ),
    .VC1_empty     ( VC1_empty     ),
    .VC1_pop_synth  ( VC1_pop_synth  ),
    .VC0_pop_synth  ( VC0_pop_synth  ),
    .arbitro_D0_out_synth       ( arbitro_D0_out_synth [5:0]      ),
    .arbitro_D1_out_synth       ( arbitro_D1_out_synth [5:0]      ),
    .D0_push   (D0_push),
    .D1_push   (D1_push)
);

arbitro_enrutamiento_synth u_arbitro_enrutamiento_synth(
    .VC0            ( VC0 [5:0]           ),
    .VC1            ( VC1 [5:0]           ),
    .clk            ( clk            ),
    .reset_L        ( reset_L        ),
    .VC0_empty      ( VC0_empty      ),
    .VC1_empty      ( VC1_empty      ),
    .D1_pause ( D1_pause ),
    .D0_pause ( D0_pause ),
    .VC1_pop_synth  ( VC1_pop_synth  ),
    .VC0_pop_synth  ( VC0_pop_synth  ),
    .arbitro_D0_out_synth       ( arbitro_D0_out_synth [5:0]      ),
    .arbitro_D1_out_synth       ( arbitro_D1_out_synth [5:0]      )
);


endmodule