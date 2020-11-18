`include "arbitro_mux.v"
`include "logica_pops.v"


module arbitro_enrutamiento(input [5:0]VC0, VC1,
                            input clk, reset_L,
                            input VC0_empty, VC1_empty, D1_pause, D0_pause,
                            output VC1_pop, VC0_pop, D0_push, D1_push,
                            output [5:0] D0_out, D1_out);

    wire pop_delay_VC0, pop_delay_VC1;

    arbitro_mux u_arbitro_muxes(
        .reset_L       ( reset_L       ),
        .clk           ( clk           ),
        .VC0           ( VC0 [5:0]          ),
        .VC1           ( VC1 [5:0]          ),
        .pop_delay_VC0 ( pop_delay_VC0 ),
        .pop_delay_VC1 ( pop_delay_VC1 ),
        .VC0_empty (VC0_empty),
        .VC1_empty (VC1_empty),
        //.mux_arbitro_1 ( mux_arbitro_1 [5:0] ),
        .D0_out        ( D0_out       [5:0] ),
        .D1_out        ( D1_out       [5:0] ),
        .D0_push       ( D0_push ),
        .D1_push       ( D1_push )
    );

    logica_pops u_logica_pops(
        .VC0_empty     ( VC0_empty     ),
        .VC1_empty     ( VC1_empty     ),
        .D0_pause      ( D0_pause      ),
        .D1_pause      ( D1_pause      ),
        .clk           ( clk           ),
        .VC0_pop       ( VC0_pop       ),
        .VC1_pop       ( VC1_pop       ),
        .pop_delay_VC0 ( pop_delay_VC0 ),
        .pop_delay_VC1 ( pop_delay_VC1 ),
        .reset_L       ( reset_L       )
    );


endmodule