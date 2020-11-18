`include "memoria.v"
`include "probador_memoria.v"
`include "memoria_synth.v"
`include "../lib/cmos_cells.v"

module bancopruebas_memoria();
	parameter address_width = 2;
	parameter data_width = 6;

	wire [data_width-1:0] FIFO_data_in;
	wire [data_width-1:0] FIFO_data_out, FIFO_data_out_synth;
	wire [address_width-1:0] rd_ptr, wr_ptr;

	probador_memoria#(
		.data_width   ( 6 ),
		.address_width ( 2 )
	)u_probador_memoria(
		.clk          ( clk          ),
		.wr_enable    ( wr_enable    ),
		.rd_enable    ( rd_enable    ),
		.reset        ( reset        ),
		.FIFO_data_in ( FIFO_data_in [data_width-1:0] ),
		.wr_ptr       ( wr_ptr [address_width-1:0]      ),
		.rd_ptr       ( rd_ptr [address_width-1:0]      ),
		.FIFO_data_out ( FIFO_data_out [data_width-1:0] ),
		.FIFO_data_out_synth (FIFO_data_out_synth [data_width-1:0])
	);


	memoria#(
		.data_width   ( 6 ),
		.address_width ( 2 )
	)u_memoria(
		.FIFO_data_in ( FIFO_data_in [data_width-1:0]),
		.clk          ( clk          ),
		.reset        ( reset        ),
		.wr_enable    ( wr_enable    ),
		.rd_enable    ( rd_enable    ),
		.wr_ptr       ( wr_ptr [address_width-1:0]),
		.rd_ptr       ( rd_ptr [address_width-1:0]),
		.FIFO_data_out ( FIFO_data_out [data_width-1:0])
	);

	memoria_synth u_memoria_synth(
		.FIFO_data_in ( FIFO_data_in [data_width-1:0]),
		.clk          ( clk          ),
		.reset        ( reset        ),
		.wr_enable    ( wr_enable    ),
		.rd_enable    ( rd_enable    ),
		.wr_ptr       ( wr_ptr      [address_width-1:0]),
		.rd_ptr       ( rd_ptr      [address_width-1:0]),
		.FIFO_data_out_synth ( FIFO_data_out_synth [data_width-1:0])
	);



endmodule
