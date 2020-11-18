`include "probador.v"
`include "state_machine.v"
`include "state_machine_synth.v"
module BancoPruebas();

  parameter U_MFS=4;
  parameter U_VCS=4;
  parameter U_DS=4;

  wire reset,clk,init,error_out,active_out,idle_out,next_error,error_out_synth, next_error_synth,active_out_synth,idle_out_synth;
  wire [U_MFS-1:0] umbral_MFs;
  wire [U_VCS-1:0] umbral_VCs;
  wire [U_DS-1:0]  umbral_Ds;
  wire empty_main_fifo, empty_fifo_VC0, empty_fifo_VC1,empty_fifo_D0,empty_fifo_D1;
  wire error_main, error_VC0, error_VC1, error_D0, error_D1;
  wire [3:0] present_state;
  wire [3:0] next_state;
  wire [3:0] present_state_synth;
  wire [3:0] next_state_synth;
  wire [U_MFS-1:0] umbral_MFs_out;
  wire [U_VCS-1:0] umbral_VCs_out;
  wire [U_DS-1:0] umbral_Ds_out;
  wire [U_MFS-1:0] next_umbral_MFs;
  wire [U_VCS-1:0] next_umbral_VCs;
  wire [U_DS-1:0] next_umbral_Ds;
  wire [U_MFS-1:0] umbral_MFs_out_synth;
  wire [U_VCS-1:0] umbral_VCs_out_synth;
  wire [U_DS-1:0] umbral_Ds_out_synth;
  wire [U_MFS-1:0] next_umbral_MFs_synth;
  wire [U_VCS-1:0] next_umbral_VCs_synth;
  wire [U_DS-1:0] next_umbral_Ds_synth;

  state_machine sm(/*AUTOINST*/
		   // Outputs
		   .error_out		(error_out),
		   .next_error		(next_error),
		   .active_out	(active_out),
		   .idle_out		(idle_out),
		   .present_state	(present_state[3:0]),
		   .next_state		(next_state[3:0]),
		   .umbral_MFs_out	(umbral_MFs_out[U_MFS-1:0]),
		   .umbral_VCs_out	(umbral_VCs_out[U_VCS-1:0]),
		   .umbral_Ds_out	(umbral_Ds_out[U_DS-1:0]),
		   .next_umbral_MFs	(next_umbral_MFs[U_MFS-1:0]),
		   .next_umbral_VCs	(next_umbral_VCs[U_VCS-1:0]),
		   .next_umbral_Ds	(next_umbral_Ds[U_DS-1:0]),
		   // Inputs
		   .clk			(clk),
		   .reset		(reset),
		   .init		(init),
		   .umbral_MFs		(umbral_MFs[U_MFS-1:0]),
		   .umbral_VCs		(umbral_VCs[U_VCS-1:0]),
		   .umbral_Ds		(umbral_Ds[U_DS-1:0]),
		   .empty_main_fifo (empty_main_fifo),
		   .empty_fifo_VC0 (empty_fifo_VC0),
		   .empty_fifo_VC1 (empty_fifo_VC1),
		   .empty_fifo_D0 (empty_fifo_D0),
		   .empty_fifo_D1 (empty_fifo_D1),
		   .error_main (error_main),
		   .error_VC0 (error_VC0),
		   .error_VC1 (error_VC1),
		   .error_D0 (error_D0),
		   .error_D1 (error_D1)
			);
  state_machine_synth synth(/*AUTOINST*/
			    // Outputs
			    .active_out		(active_out_synth),
			    .error_out		(error_out_synth),
				.next_error		(next_error_synth),
			    .idle_out		(idle_out_synth),
			    .next_state		(next_state_synth[3:0]),
			    .present_state	(present_state_synth[3:0]),
			    .umbral_Ds_out	(umbral_Ds_out_synth[3:0]),
			    .umbral_MFs_out	(umbral_MFs_out_synth[3:0]),
			    .umbral_VCs_out	(umbral_VCs_out_synth[3:0]),
				.next_umbral_MFs	(next_umbral_MFs_synth[U_MFS-1:0]),
		   		.next_umbral_VCs	(next_umbral_VCs_synth[U_VCS-1:0]),
		   		.next_umbral_Ds		(next_umbral_Ds_synth[U_DS-1:0]),
			    // Inputs
			    .clk		(clk),
			    .init		(init),
			    .reset		(reset),
			    .umbral_Ds		(umbral_Ds[3:0]),
			    .umbral_MFs		(umbral_MFs[3:0]),
			    .umbral_VCs		(umbral_VCs[3:0]),
				.empty_main_fifo (empty_main_fifo),
		   		.empty_fifo_VC0 (empty_fifo_VC0),
		   		.empty_fifo_VC1 (empty_fifo_VC1),
		   		.empty_fifo_D0 (empty_fifo_D0),
		   		.empty_fifo_D1 (empty_fifo_D1),
		   		.error_main (error_main),
		   		.error_VC0 (error_VC0),
		   		.error_VC1 (error_VC1),
		   		.error_D0 (error_D0),
		   		.error_D1 (error_D1)
		   		);


  probador probador1 (/*AUTOINST*/
		      // Outputs
		      .reset		(reset),
		      .clk		(clk),
		      .init		(init),
		      .umbral_MFs	(umbral_MFs[U_MFS-1:0]),
		      .umbral_VCs	(umbral_VCs[U_VCS-1:0]),
		      .umbral_Ds	(umbral_Ds[U_DS-1:0]),
		      .empty_main_fifo (empty_main_fifo),
		   	  .empty_fifo_VC0 (empty_fifo_VC0),
		   	  .empty_fifo_VC1 (empty_fifo_VC1),
		   	  .empty_fifo_D0 (empty_fifo_D0),
		   	  .empty_fifo_D1 (empty_fifo_D1),
		   	  .error_main (error_main),
		   	  .error_VC0 (error_VC0),
		   	  .error_VC1 (error_VC1),
		   	  .error_D0 (error_D0),
		   	  .error_D1 (error_D1),
		      // Inputs
		      .error_out	(error_out),
			  .next_error	(next_error),
		      .active_out	(active_out),
		      .idle_out		(idle_out),
		      .present_state	(present_state[3:0]),
		      .next_state	(next_state[3:0]),
		      .umbral_MFs_out	(umbral_MFs_out[U_MFS-1:0]),
		      .umbral_VCs_out	(umbral_VCs_out[U_VCS-1:0]),
		      .umbral_Ds_out	(umbral_Ds_out[U_DS-1:0]),
			  .next_umbral_MFs	(next_umbral_MFs[U_MFS-1:0]),
		      .next_umbral_VCs	(next_umbral_VCs[U_VCS-1:0]),
		      .next_umbral_Ds	(next_umbral_Ds[U_DS-1:0]),
		      .error_out_synth	(error_out_synth),
			  .next_error_synth	(next_error_synth),
		      .active_out_synth	(active_out_synth),
		      .idle_out_synth	(idle_out_synth),
		      .present_state_synth(present_state_synth[3:0]),
		      .next_state_synth	(next_state_synth[3:0]),
		      .umbral_MFs_out_synth(umbral_MFs_out_synth[U_MFS-1:0]),
		      .umbral_VCs_out_synth(umbral_VCs_out_synth[U_VCS-1:0]),
		      .umbral_Ds_out_synth(umbral_Ds_out_synth[U_DS-1:0]),
			  .next_umbral_MFs_synth	(next_umbral_MFs_synth[U_MFS-1:0]),
		      .next_umbral_VCs_synth	(next_umbral_VCs_synth[U_VCS-1:0]),
		      .next_umbral_Ds_synth		(next_umbral_Ds_synth[U_DS-1:0]));

endmodule
