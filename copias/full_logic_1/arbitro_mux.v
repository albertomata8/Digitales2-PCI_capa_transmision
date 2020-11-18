module arbitro_mux(input reset_L, clk,
					input [5:0] VC0,
					input [5:0] VC1,
					input pop_delay_VC0, pop_delay_VC1,
					input VC0_empty, VC1_empty,
					output reg [5:0] D0_out, D1_out, 
					output reg D0_push, D1_push);

	always@(*) begin
		if(~reset_L) begin
			D0_out = 0;
			D1_out = 0;
			D0_push = 0;
			D1_push = 0;
		end
		else begin
			if(pop_delay_VC0) begin
				if (VC0[4] == 0) begin
					D0_out = VC0;
					D1_out = 0;
					D0_push = 1;
					D1_push = 0;
				end
				else begin
					D1_out = VC0;
					D0_out = 0;
					D1_push = 1;
					D0_push = 0;
				end
			end
			else if(pop_delay_VC1) begin
				if (VC1[4] == 0) begin 
					D0_out = VC1;
					D1_out = 0;
					D0_push = 1;
					D1_push = 0;
				end
				else begin
					D1_out = VC1;
					D0_out = 0;
					D0_push = 0;
					D1_push = 1;
				end
			end
			else begin
				D0_out = 0;
				D1_out = 0;
				D0_push = 0;
				D1_push = 0;
			end
		end

	end


endmodule