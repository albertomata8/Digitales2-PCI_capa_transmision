`include "initial_logic.v"
`include "initial_logic_synth.v"
`include "probador_initial_logic.v"

module banco_initial_logic();

	parameter address_width = 2;
	parameter data_width = 6;
	wire Umbral_Main,Umbral_VC0,Umbral_VC1;
    wire clk, reset, wr_enable;
    wire [data_width-1:0] data_in;
    wire pop_VC0_fifo, pop_VC1_fifo;
    wire full_fifo_VC0;
    wire empty_fifo_VC0;
    wire almost_full_fifo_VC0;
    wire almost_empty_fifo_VC0;
    wire error_VC0;
    wire [5:0] data_out_VC0;
    wire full_fifo_VC1;
    wire empty_fifo_VC1;
    wire almost_full_fifo_VC1;
    wire almost_empty_fifo_VC1;
    wire error_VC1;
    wire [5:0] data_out_VC1;
	wire full_fifo_VC0_synth;
    wire empty_fifo_VC0_synth;
    wire almost_full_fifo_VC0_synth;
    wire almost_empty_fifo_VC0_synth;
    wire error_VC0_synth;
    wire [5:0] data_out_VC0_synth;
    wire full_fifo_VC1_synth;
    wire empty_fifo_VC1_synth;
    wire almost_full_fifo_VC1_synth;
    wire almost_empty_fifo_VC1_synth;
    wire error_VC1_synth;
    wire [5:0] data_out_VC1_synth;
	wire error_main;
    wire empty_main_fifo;
	wire error_main_synth;
    wire empty_main_fifo_synth;

    initial_logic initial_logic1(/*AUTOINST*/
				 // Outputs
				 .full_fifo_VC0		(full_fifo_VC0),
				 .empty_fifo_VC0	(empty_fifo_VC0),
				 .almost_full_fifo_VC0	(almost_full_fifo_VC0),
				 .almost_empty_fifo_VC0	(almost_empty_fifo_VC0),
				 .error_VC0		(error_VC0),
				 .data_out_VC0		(data_out_VC0[5:0]),
				 .full_fifo_VC1		(full_fifo_VC1),
				 .empty_fifo_VC1	(empty_fifo_VC1),
				 .almost_full_fifo_VC1	(almost_full_fifo_VC1),
				 .almost_empty_fifo_VC1	(almost_empty_fifo_VC1),
				 .error_VC1		(error_VC1),
				 .data_out_VC1		(data_out_VC1[5:0]),
				 .empty_main_fifo (empty_main_fifo),
				 .error_main (error_main),
				 // Inputs
				 .clk			(clk),
				 .reset			(reset),
				 .wr_enable		(wr_enable),
				 .data_in		(data_in[data_width-1:0]),
				 .pop_VC0_fifo		(pop_VC0_fifo),
				 .pop_VC1_fifo		(pop_VC1_fifo),
				 .Umbral_Main 	(Umbral_Main),
				 .Umbral_VC0	(Umbral_VC0),
				 .Umbral_VC1 	(Umbral_VC1));

	initial_logic_synth initial_logic1_synth(/*AUTOINST*/
				 // Outputs
				 .full_fifo_VC0		(full_fifo_VC0_synth),
				 .empty_fifo_VC0	(empty_fifo_VC0_synth),
				 .almost_full_fifo_VC0	(almost_full_fifo_VC0_synth),
				 .almost_empty_fifo_VC0	(almost_empty_fifo_VC0_synth),
				 .error_VC0		(error_VC0_synth),
				 .data_out_VC0		(data_out_VC0_synth[5:0]),
				 .full_fifo_VC1		(full_fifo_VC1_synth),
				 .empty_fifo_VC1	(empty_fifo_VC1_synth),
				 .almost_full_fifo_VC1	(almost_full_fifo_VC1_synth),
				 .almost_empty_fifo_VC1	(almost_empty_fifo_VC1_synth),
				 .error_VC1		(error_VC1_synth),
				 .data_out_VC1		(data_out_VC1_synth[5:0]),
				 .empty_main_fifo (empty_main_fifo_synth),
				 .error_main (error_main_synth),
				 // Inputs
				 .clk			(clk),
				 .reset			(reset),
				 .wr_enable		(wr_enable),
				 .data_in		(data_in[data_width-1:0]),
				 .pop_VC0_fifo		(pop_VC0_fifo),
				 .pop_VC1_fifo		(pop_VC1_fifo),
				 .Umbral_Main 	(Umbral_Main),
				 .Umbral_VC0	(Umbral_VC0),
				 .Umbral_VC1	(Umbral_VC1));

    probador_initial_logic probador_initial_logic_1(/*AUTOINST*/
						    // Outputs
						    .clk		(clk),
						    .reset		(reset),
						    .wr_enable		(wr_enable),
						    .data_in		(data_in[data_width-1:0]),
						    .pop_VC0_fifo	(pop_VC0_fifo),
						    .pop_VC1_fifo	(pop_VC1_fifo),
							.Umbral_Main 	(Umbral_Main),
							.Umbral_VC0		(Umbral_VC0),
							.Umbral_VC1		(Umbral_VC1),
						    // Inputs
							.error_main (error_main),
							.empty_main_fifo (empty_main_fifo),
						    .full_fifo_VC0	(full_fifo_VC0),
						    .empty_fifo_VC0	(empty_fifo_VC0),
						    .almost_full_fifo_VC0(almost_full_fifo_VC0),
						    .almost_empty_fifo_VC0(almost_empty_fifo_VC0),
						    .error_VC0		(error_VC0),
						    .data_out_VC0	(data_out_VC0[5:0]),
						    .full_fifo_VC1	(full_fifo_VC1),
						    .empty_fifo_VC1	(empty_fifo_VC1),
						    .almost_full_fifo_VC1(almost_full_fifo_VC1),
						    .almost_empty_fifo_VC1(almost_empty_fifo_VC1),
						    .error_VC1		(error_VC1),
						    .data_out_VC1	(data_out_VC1[5:0]));
    
endmodule
