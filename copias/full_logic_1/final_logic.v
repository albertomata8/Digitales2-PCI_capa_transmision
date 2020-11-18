`include "arbitro_enrutamiento.v"
`include "D0_fifo.v"
`include "D1_fifo.v"

module final_logic#(
            parameter data_width = 6,
			parameter address_width = 2
            )
            (input [5:0] data_out_VC0, data_out_VC1,
            input clk, reset_L, empty_fifo_VC0, empty_fifo_VC1,init,
            input D0_pop, D1_pop,
            input [3:0] Umbral_D0,
            input [3:0] Umbral_D1,
            output [5:0] data_out_D0, data_out_D1,
            output pop_VC0_fifo, pop_VC1_fifo,
            output error_D1, error_D0, empty_fifo_D1, empty_fifo_D0);

wire fulloralmostfull_D0, fulloralmostfull_D1, D0_push, D1_push;
wire [5:0] D0_out, D1_out;

arbitro_enrutamiento u_arbitro_enrutamiento(
    .VC0       ( data_out_VC0      ),
    .VC1       ( data_out_VC1      ),
    .clk       ( clk               ),
    .reset_L   ( reset_L           ),
    .VC0_empty ( empty_fifo_VC0    ),
    .VC1_empty ( empty_fifo_VC1    ),
    .D1_pause  ( fulloralmostfull_D1),
    .D0_pause  ( fulloralmostfull_D0),
    .VC1_pop   (pop_VC1_fifo       ),
    .VC0_pop   (pop_VC0_fifo       ),
    .D0_out    ( D0_out [5:0]      ),
    .D1_out    ( D1_out [5:0]      ),
    .D0_push   ( D0_push           ),
    .D1_push   ( D1_push           )
);

D0_fifo u_D0_fifo(
    .clk                  ( clk                  ),
    .reset_L              ( reset_L              ),
    .init                 (init),
    .wr_enable            ( D0_push              ),
    .rd_enable            ( D0_pop               ),
    .data_in              ( D0_out [5:0]         ),
    .full_fifo_D0         ( full_fifo_D0         ),
    .empty_fifo_D0        ( empty_fifo_D0        ),
    .almost_full_fifo_D0  ( fulloralmostfull_D0  ),
    .almost_empty_fifo_D0 ( almost_empty_fifo_D0 ),
    .error_D0             ( error_D0             ),
    .data_out_D0          ( data_out_D0          ),
    .Umbral_D0            (Umbral_D0)
);

D1_fifo u_D1_fifo(
    .clk                  ( clk                  ),
    .reset_L              ( reset_L              ),
    .init                 (init),
    .wr_enable            ( D1_push              ),
    .rd_enable            ( D1_pop               ),
    .data_in              ( D1_out [5:0]         ),
    .full_fifo_D1         ( full_fifo_D1         ),
    .empty_fifo_D1        ( empty_fifo_D1        ),
    .almost_full_fifo_D1  ( fulloralmostfull_D1  ),
    .almost_empty_fifo_D1 ( almost_empty_fifo_D1 ),
    .error_D1             ( error_D1             ),
    .data_out_D1          ( data_out_D1          ),
    .Umbral_D1            (Umbral_D1)
);

endmodule
