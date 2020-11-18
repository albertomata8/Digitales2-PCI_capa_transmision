module D0_fifo #(
            parameter data_width = 6,
			parameter address_width = 2
            )
            (
            input clk, reset_L, wr_enable, rd_enable,init,
            input [data_width-1:0] data_in,
            input [3:0] Umbral_D0,
            output full_fifo_D0,
            output empty_fifo_D0,
            output almost_full_fifo_D0,
            output almost_empty_fifo_D0,
            output error_D0,
            output reg [data_width-1:0] data_out_D0
            );

    parameter size_fifo = 2**address_width;
    reg [data_width-1:0] mem [0:size_fifo-1];
    reg [address_width-1:0] wr_ptr;
    reg [address_width-1:0] rd_ptr;
    reg [address_width:0] cnt;
    wire full_fifo_D0_reg;

    assign full_fifo_D0 = (cnt == size_fifo);
    assign empty_fifo_D0 = (cnt == 0);  
    assign error_D0 = (cnt > size_fifo);
    assign almost_empty_fifo_D0 = (cnt == Umbral_D0);
    assign almost_full_fifo_D0 = (cnt >= size_fifo-Umbral_D0 && cnt < size_fifo);
    assign  full_fifo_D0_reg = full_fifo_D0;
    integer i;



// WRITE //
    always @(posedge clk) begin
       if (reset_L == 0 || init == 0) begin
            wr_ptr <= 0;
       		rd_ptr <= 4'b0;
            data_out_D0 <=0;
            cnt <= 0;
            for(i = 0; i<2**address_width; i=i+1) begin
				mem[i] <= 0;
			end
       end
        else begin
            if (reset_L == 1 && init == 1 && ~full_fifo_D0_reg) begin
                if (wr_enable == 1) begin
                     mem[wr_ptr] <= data_in;
                     wr_ptr <= wr_ptr+1;
                end

                if (rd_enable == 1) begin
                     data_out_D0 <= mem[rd_ptr];
                     rd_ptr <= rd_ptr+1;
                end
                else data_out_D0 <=0;

                case ({wr_enable, rd_enable})
                    2'b00: cnt <= cnt;
                    2'b01: cnt <= cnt-1;
                    2'b10: cnt <= cnt+1;
                    2'b11: cnt <= cnt;
                    default: cnt <= cnt;
                endcase
            end
            if (reset_L == 1 && init == 1 && full_fifo_D0_reg) begin
                 if (rd_enable == 1) begin
                     data_out_D0 <= mem[rd_ptr];
                     rd_ptr <= rd_ptr+1;
                     cnt <= cnt-1;
                 end
            end
        end
    end
  
       
endmodule