`include "initial_logic.v"
`include "final_logic.v"
`include "state_machine.v"

module full_logic#(
            parameter data_width = 6,
			parameter address_width = 2
            )
            (input clk, reset, wr_enable,
            input [data_width-1:0] data_in,
            input D0_pop, D1_pop,
            input [3:0] Umbral_Main,
            input [3:0] Umbral_VC0,
            input [3:0]Umbral_VC1,
            input [3:0] Umbral_D0,
            input [3:0]Umbral_D1,
            input init,
            input [3:0] umbral_MFs,
            input [3:0] umbral_VCs,
            input [3:0] umbral_Ds,
            output [5:0] data_out_D0, data_out_D1,
            output error_D0, error_D1,
            output error_out,
            output active_out,
            output idle_out,
            output empty_fifo_D0,
            output empty_fifo_D1
            );

wire pop_VC0_fifo, pop_VC1_fifo;
wire [5:0] data_out_VC0,data_out_VC1;
wire empty_fifo_VC0, empty_fifo_VC1;
wire error_main;
wire empty_main_fifo;
wire next_error;
wire next_active;
wire next_idle;
wire [3:0] present_state;
wire [3:0] next_state;
wire [3:0] umbral_MFs_out;
wire [3:0] umbral_VCs_out;
wire [3:0] umbral_Ds_out;
wire [3:0] next_umbral_MFs;
wire [3:0] next_umbral_VCs;
wire [3:0] next_umbral_Ds;

    initial_logic initial_logic_1(
        .clk                   ( clk                   ),
        .reset                 ( reset                 ),
        .init                  ( init                 ),
        .wr_enable             ( wr_enable             ),
        .data_in               ( data_in[5:0]          ),
        .Umbral_Main 	       (umbral_MFs_out[3:0]),
		.Umbral_VC0	           (umbral_VCs_out),
		.Umbral_VC1 	       (umbral_VCs_out),
        .pop_VC0_fifo          ( pop_VC0_fifo          ),
        .pop_VC1_fifo          ( pop_VC1_fifo          ),
        .full_fifo_VC0         ( full_fifo_VC0         ),
        .empty_fifo_VC0        ( empty_fifo_VC0        ),
        .almost_full_fifo_VC0  ( almost_full_fifo_VC0  ),
        .almost_empty_fifo_VC0 ( almost_empty_fifo_VC0 ),
        .error_VC0             ( error_VC0             ),
        .data_out_VC0          ( data_out_VC0[5:0]          ),
        .full_fifo_VC1         ( full_fifo_VC1         ),
        .empty_fifo_VC1        ( empty_fifo_VC1        ),
        .almost_full_fifo_VC1  ( almost_full_fifo_VC1  ),
        .almost_empty_fifo_VC1 ( almost_empty_fifo_VC1 ),
        .error_VC1             ( error_VC1             ),
        .data_out_VC1          ( data_out_VC1[5:0]     ),
        .empty_main_fifo (empty_main_fifo),
		.error_main (error_main)
    );

    final_logic final_logic_1(
    .data_out_VC0   ( data_out_VC0[5:0]    ),
    .data_out_VC1   ( data_out_VC1[5:0]    ),
    .clk            ( clk            ),
    .reset_L        ( reset          ),
    .init           (init),
    .Umbral_D0	    (umbral_Ds_out),
	.Umbral_D1 	    (umbral_Ds_out),
    .empty_fifo_VC0 ( empty_fifo_VC0 ),
    .empty_fifo_VC1 ( empty_fifo_VC1 ),
    .D0_pop         ( D0_pop         ),
    .D1_pop         ( D1_pop         ),
    .data_out_D0    ( data_out_D0[5:0]     ),
    .data_out_D1    ( data_out_D1[5:0]     ),
    .pop_VC0_fifo   ( pop_VC0_fifo   ),
    .pop_VC1_fifo   ( pop_VC1_fifo   ),
    .error_D1       ( error_D1       ),
    .error_D0       ( error_D0       ),
    .empty_fifo_D0  (empty_fifo_D0),
    .empty_fifo_D1  (empty_fifo_D1)
);
    state_machine state_machine_1(
    .clk            ( clk ),
    .reset        ( reset ),
    .init           (init),
	.umbral_MFs     (umbral_MFs[3:0]),
    .umbral_VCs     (umbral_VCs[3:0]),
    .umbral_Ds      (umbral_Ds[3:0]),
    .empty_main_fifo (empty_main_fifo),
    .empty_fifo_VC0  (empty_fifo_VC0),
    .empty_fifo_VC1  (empty_fifo_VC1),
    .empty_fifo_D0  (empty_fifo_D0),
    .empty_fifo_D1  (empty_fifo_D1),
    .error_main     (error_main),
    .error_VC0      (error_VC0),
    .error_VC1      (error_VC1),
    .error_D0       (error_D0),
    .error_D1       (error_D1),
    .error_out      (error_out),
    .next_error     (next_error),
    .active_out     (active_out),
    .next_active    (next_active),
    .idle_out       (idle_out),
    .next_idle      (next_idle),
    .present_state  (present_state[3:0]),
    .next_state     (next_state[3:0]),
    .umbral_MFs_out (umbral_MFs_out[3:0]),
    .umbral_VCs_out  (umbral_VCs_out),
    .umbral_Ds_out  (umbral_Ds_out),
    .next_umbral_MFs (next_umbral_MFs),
    .next_umbral_VCs (next_umbral_VCs),
    .next_umbral_Ds   (next_umbral_Ds)
);


endmodule