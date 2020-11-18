`include "./arbitro_muxes/arbitro_mux.v"
`include "./arbitro_muxes/logica_pops.v"
`include "./arbitro_muxes/retraso1.v"


module arbitro_enrutamiento(input [5:0]VC0, VC1, data_arbitro_VC0, data_arbitro_VC1,
                            input clk, reset_L, almost_full_fifo_D0, almost_full_fifo_D1, full_fifo_D0, full_fifo_D1,
                            input VC0_empty, VC1_empty,
                            output VC1_pop, VC0_pop, D0_push, D1_push,
                            output [5:0] arbitro_D0_out, arbitro_D1_out);

    wire pop_delay_VC0, pop_delay_VC1;
    wire [5:0] data_arbitro_VC0_retrasado;
    wire [5:0] data_arbitro_VC1_retrasado;
    wire VC0_empty_retrasado, VC1_empty_retrasado ; 

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
        .arbitro_D0_out        ( arbitro_D0_out       [5:0] ),
        .arbitro_D1_out        ( arbitro_D1_out       [5:0] ),
        .D0_push       ( D0_push ),
        .D1_push       ( D1_push ),
        .full_fifo_D0        ( full_fifo_D0        ),
        .full_fifo_D1        ( full_fifo_D1        ),
        .almost_full_fifo_D0  ( almost_full_fifo_D0  ),
        .almost_full_fifo_D1 ( almost_full_fifo_D1 )
    );

    //retraso1 retraso1a(
    //    .reset_L       ( reset_L       ),
    //    .clk           ( clk           ),
    //    .VC0           ( VC0 [5:0]          ),
    //    .VC1           ( VC1 [5:0]          ),
    //    .pop_delay_VC0 ( pop_delay_VC0 ),
    //    .pop_delay_VC1 ( pop_delay_VC1 ),
    //    .VC0_empty (VC0_empty),
    //    .VC1_empty (VC1_empty),
    //    .VC0           ( VC0 [5:0]          ),
    //    .VC1           ( VC1 [5:0]          ),
    //    .VC0_empty (VC0_empty),
    //    .VC1_empty (VC1_empty)
//
    //);
    //retraso3 retraso3a(
    //    .clk           ( clk           ),
    //    .VC0_empty (VC0_empty),
    //    .VC1_empty (VC1_empty),
    //    .VC0_empty (VC0_empty),
    //    .VC1_empty (VC1_empty)
    //);


retraso1 retraso1a(
    .clk                 ( clk                 ),
    .reset_L             ( reset_L             ),
    .VC0_empty           ( VC0_empty           ),
    .VC1_empty           ( VC1_empty           ),
    .full_fifo_D0        ( full_fifo_D0        ),
    .full_fifo_D1        ( full_fifo_D1        ),
    .almost_full_fifo_D0  ( almost_full_fifo_D0  ),
    .almost_full_fifo_D1 ( almost_full_fifo_D1 ),
    .data_arbitro_VC0    ( data_arbitro_VC0 [5:0]),
    .data_arbitro_VC1    ( data_arbitro_VC1 [5:0]),
    .VC0_empty_retrasado           ( VC0_empty_retrasado           ),
    .VC1_empty_retrasado           ( VC1_empty_retrasado           ),
    .data_arbitro_VC0_retrasado    ( data_arbitro_VC0_retrasado [5:0]),
    .data_arbitro_VC1_retrasado    ( data_arbitro_VC1_retrasado [5:0])
);

logica_pops u_logica_pops(
    .VC0_empty           ( VC0_empty_retrasado           ),
    .VC1_empty           ( VC1_empty_retrasado           ),
    .full_fifo_D0        ( full_fifo_D0        ),
    .full_fifo_D1        ( full_fifo_D1        ),
    .almost_full_fifo_D0 ( almost_full_fifo_D0  ),
    .almost_full_fifo_D1 ( almost_full_fifo_D1 ),
    .clk                 ( clk                 ),
    .reset_L             ( reset_L             ),
    .VC0_pop             ( VC0_pop             ),
    .VC1_pop             ( VC1_pop             ),
    .pop_delay_VC0       ( pop_delay_VC0       ),
    .pop_delay_VC1       ( pop_delay_VC1       ),
    .data_arbitro_VC0    ( data_arbitro_VC0_retrasado [5:0]),
    .data_arbitro_VC1    ( data_arbitro_VC1_retrasado [5:0])
);



endmodule