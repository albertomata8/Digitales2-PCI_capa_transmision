module arbitro_mux(input reset_L, clk,
					input [5:0] VC0,
					input [5:0] VC1,
					input pop_delay_VC0, pop_delay_VC1,
					input almost_full_fifo_D0, almost_full_fifo_D1, full_fifo_D0, full_fifo_D1,
					input VC0_empty, VC1_empty,
					output reg [5:0] arbitro_D0_out, arbitro_D1_out, 
					output reg D0_push, D1_push);

	always@(posedge clk) begin
		if(~reset_L) begin
			arbitro_D0_out <= 0;
			arbitro_D1_out <= 0;
			D0_push <= 0;
			D1_push <= 0;
		end
		else begin
			if (~VC0_empty ) begin
				if(pop_delay_VC0 ) begin
					if(!almost_full_fifo_D0 || !almost_full_fifo_D1 || !full_fifo_D0 || !full_fifo_D1)begin
						if (VC0[4] == 0) begin
							arbitro_D0_out <= VC0;
							arbitro_D1_out <= 0;
							D0_push <= 1;
							D1_push <= 0;
						end
						else begin
							arbitro_D1_out <= VC0;
							arbitro_D0_out <= 0;
							D1_push <= 1;
							D0_push <= 0;
						end
					end	
						
				end
				else begin
					arbitro_D0_out <= 0;
					arbitro_D1_out <= 0;
					D0_push <= 0;
					D1_push <= 0;
				end
			end
			else if (~VC1_empty ) begin
				if(pop_delay_VC1  ) begin
					if (!almost_full_fifo_D0 || !almost_full_fifo_D1 || !full_fifo_D0 || !full_fifo_D1) begin
						if (VC1[4] == 0) begin 
							arbitro_D0_out <= VC1;
							arbitro_D1_out <= 0;
							D0_push <= 1;
							D1_push <= 0;
						end
						else begin
							arbitro_D1_out <= VC1;
							arbitro_D0_out <= 0;
							D0_push <= 0;
							D1_push <= 1;
						end
					end
						
				end
				else begin
					arbitro_D0_out <= 0;
					arbitro_D1_out <= 0;
					D0_push <= 0;
					D1_push <= 0;
				end
			end
			else begin
				arbitro_D0_out <= 0;
				arbitro_D1_out <= 0;
				D0_push <= 0;
				D1_push <= 0;
			end
		end 
	end


endmodule