module retraso1(input VC0_empty, VC1_empty, full_fifo_D0, full_fifo_D1, almost_full_fifo_D0, almost_full_fifo_D1,  clk, reset_L,
                input [5:0] data_arbitro_VC0, data_arbitro_VC1,
				output reg VC0_empty_retrasado, VC1_empty_retrasado, full_fifo_D0_retrasado, full_fifo_D1_retrasado, almost_full_fifo_D0_retrasado, almost_full_fifo_D1_retrasado,
                output reg [5:0] data_arbitro_VC0_retrasado, data_arbitro_VC1_retrasado
				);
					

	always@(posedge clk) begin

		VC0_empty_retrasado <= VC0_empty;
		VC1_empty_retrasado <= VC1_empty;
		data_arbitro_VC0_retrasado [5:0] <= data_arbitro_VC0 [5:0]; 
		data_arbitro_VC1_retrasado [5:0] <= data_arbitro_VC1 [5:0]; 

	end


endmodule