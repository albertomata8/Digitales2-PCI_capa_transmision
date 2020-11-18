`include "fifo.v"
`include "probador_fifo.v"
`include "fifo_synth.v"
`include "../lib/cmos_cells.v"

module bancopruebas_fifo();

	parameter address_width = 2;
	parameter data_width = 6;

	wire [data_width-1:0] data_in;
	wire [data_width-1:0] data_out, data_out_synth;
    wire full_fifo, empty_fifo, almost_full_fifo,  almost_empty_fifo, error;

    fifo #(
        .data_width(6),
        .address_width(2))
        fifo1 (/*AUTOINST*/
	       // Outputs
		   .almost_empty_fifo	(almost_empty_fifo),
		   .almost_full_fifo	(almost_full_fifo),
	       .full_fifo		(full_fifo),
	       .empty_fifo		(empty_fifo),
	       .error			(error),
	       .data_out		(data_out[data_width-1:0]),
	       // Inputs
	       .clk			(clk),
	       .reset			(reset),
	       .wr_enable		(wr_enable),
	       .rd_enable		(rd_enable),
	       .data_in			(data_in[data_width-1:0]));

    fifo_synth fifo2 (/*AUTOINST*/
	       // Outputs
		   .almost_empty_fifo_synth	(almost_empty_fifo_synth),
		   .almost_full_fifo_synth	(almost_full_fifo_synth),
	       .full_fifo_synth		(full_fifo_synth),
	       .empty_fifo_synth	(empty_fifo_synth),
	       .error				(error),
	       .data_out_synth		(data_out_synth[data_width-1:0]),
	       // Inputs
	       .clk			(clk),
	       .reset			(reset),
	       .wr_enable		(wr_enable),
	       .rd_enable		(rd_enable),
	       .data_in			(data_in[data_width-1:0]));

    probador_fifo #(
        .data_width(6),
        .address_width(2))
        probador_fifo1 (/*AUTOINST*/
			// Outputs
			.clk		(clk),
			.wr_enable	(wr_enable),
			.rd_enable	(rd_enable),
			.reset		(reset),
			.data_in	(data_in[data_width-1:0]),
			// Inputs
			.full_fifo	(full_fifo),
			.empty_fifo	(empty_fifo),
			.error		(error),
			.data_out	(data_out[data_width-1:0]),
			.data_out_synth	(data_out_synth[data_width-1:0]));
endmodule
