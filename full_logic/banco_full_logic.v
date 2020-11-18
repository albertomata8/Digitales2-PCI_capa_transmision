`include "./full_logic/full_logic.v"
`include "./full_logic/full_logic_synth.v"
`include "./full_logic/probador_full_logic.v"

module banco_full_logic();
    wire [5:0] data_out_D0, data_out_D1, data_in,data_out_D0_synth, data_out_D1_synth;
    wire [3:0] Umbral_Main, Umbral_VC0, Umbral_VC1,Umbral_D0, Umbral_D1;
    wire [3:0] umbral_MFs, umbral_VCs, umbral_Ds;
    wire init,error_out,active_out,idle_out;
    wire init_synth,error_out_synth,active_out_synth,idle_out_synth;
    wire empty_fifo_D0, empty_fifo_D1, empty_fifo_D0_synth, empty_fifo_D1_synth;

full_logic full_logic_cond(
    .clk         ( clk         ),
    .reset       ( reset       ),
    .wr_enable   ( wr_enable   ),
    .data_in     ( data_in[5:0]     ),
    .D0_pop      ( D0_pop      ),
    .D1_pop      ( D1_pop      ),
    .data_out_D0 ( data_out_D0[5:0] ),
    .data_out_D1 ( data_out_D1[5:0] ),
    .error_D0    ( error_D0    ),
    .error_D1    ( error_D1    ),
    .umbral_MFs   (umbral_MFs[3:0]),
    .umbral_VCs   (umbral_VCs[3:0]),
    .umbral_Ds    (umbral_Ds),
    .init         (init),
    .error_out    (error_out),
    .active_out   (active_out),
    .idle_out     (idle_out),
    .empty_fifo_D0 (empty_fifo_D0),
    .empty_fifo_D1 (empty_fifo_D1)
);

full_logic_synth full_logic_synth_s(
    .clk         ( clk         ),
    .reset       ( reset       ),
    .wr_enable   ( wr_enable   ),
    .data_in     ( data_in[5:0]     ),
    .D0_pop      ( D0_pop      ),
    .D1_pop      ( D1_pop      ),
    .data_out_D0_synth ( data_out_D0_synth[5:0] ),
    .data_out_D1_synth ( data_out_D1_synth[5:0] ),
    .error_D0_synth    ( error_D0_synth    ),
    .error_D1_synth    ( error_D1_synth    ),
    .umbral_MFs   (umbral_MFs[3:0]),
    .umbral_VCs   (umbral_VCs[3:0]),
    .umbral_Ds    (umbral_Ds),
    .init         (init),
    .error_out    (error_out_synth),
    .active_out   (active_out_synth),
    .idle_out     (idle_out_synth),
    .empty_fifo_D0_synth (empty_fifo_D0_synth),
    .empty_fifo_D1_synth (empty_fifo_D1_synth)
);


probador_full_logic probador_full_logic_1(
    .clk         ( clk         ),
    .reset       ( reset       ),
    .wr_enable   ( wr_enable   ),
    .data_in     ( data_in[5:0]     ),
    .D0_pop      ( D0_pop      ),
    .D1_pop      ( D1_pop      ),
    .data_out_D0 ( data_out_D0[5:0] ),
    .data_out_D1 ( data_out_D1[5:0] ),
    .data_out_D0_synth ( data_out_D0_synth[5:0] ),
    .data_out_D1_synth ( data_out_D1_synth[5:0] ),
    .error_D0    ( error_D0    ),
    .error_D1   ( error_D1   ),
    .error_D0_synth   ( error_D0_synth    ),
    .error_D1_synth   ( error_D1_synth   ),
    .umbral_MFs   (umbral_MFs[3:0]),
    .umbral_VCs   (umbral_VCs[3:0]),
    .umbral_Ds    (umbral_Ds),
    .init         (init),
    .error_out    (error_out),
    .active_out   (active_out),
    .idle_out     (idle_out),
    .error_out_synth    (error_out_synth),
    .active_out_synth   (active_out_synth),
    .idle_out_synth     (idle_out_synth),
    .empty_fifo_D0 (empty_fifo_D0),
    .empty_fifo_D1 (empty_fifo_D1),
    .empty_fifo_D0_synth (empty_fifo_D0_synth),
    .empty_fifo_D1_synth (empty_fifo_D1_synth)
);


endmodule