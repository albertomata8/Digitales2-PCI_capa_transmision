module retraso3(input reset_L, clk,
					input VC0_empty_retrasado, VC1_empty_retrasado,
                    output reg VC0_empty_retrasado_retrasado, VC1_empty_retrasado_retrasado);
					

	always@(posedge clk) begin
		VC0_empty_retrasado_retrasado <= VC0_empty_retrasado ;
        VC1_empty_retrasado_retrasado <= VC1_empty_retrasado ;
	end


endmodule