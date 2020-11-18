module memoria#(parameter data_width = 6,
				parameter address_width = 2)
				(input [data_width-1:0] FIFO_data_in,
				input clk, reset, wr_enable, rd_enable,
				input [address_width-1:0] wr_ptr, rd_ptr,
				output reg [data_width-1:0] FIFO_data_out);

	reg [data_width-1:0] mem [2**address_width-1:0];
	reg [data_width-1:0] data_reg;

	integer i;

	always@(posedge clk) begin
		if (~reset) begin
			for(i = 0; i<2**address_width; i=i+1) begin
				mem[i] <= 0;
			end
		end
		else begin
			if (wr_enable) begin
				mem[wr_ptr] <= FIFO_data_in;
			end
			// if (rd_enable) begin
			// 	FIFO_data_out[data_width-1:0] <= mem[rd_ptr];
			// end
		end
	end

	always@ (*) begin
		FIFO_data_out = 0;
		if (~reset) begin
			FIFO_data_out = 0;
		end
		else if (rd_enable) begin
			FIFO_data_out[data_width-1:0] = mem[rd_ptr];
		end
	end

endmodule