module D1_fifo #(
            parameter data_width = 6,
			parameter address_width = 2
            )
            (
            input clk, reset_L, wr_enable, rd_enable, init,
            input [data_width-1:0] data_in,
            input [3:0] Umbral_D1,
            output reg full_fifo_D1,
            output reg empty_fifo_D1,
            output reg almost_full_fifo_D1,
            output reg almost_empty_fifo_D1,
            output reg error_D1,
            output reg [data_width-1:0] data_out_D1
            );

    parameter size_fifo = 2**address_width;
    reg [data_width-1:0] mem [0:size_fifo-1];
    reg [address_width-1:0] wr_ptr;
    reg [address_width-1:0] rd_ptr;
    reg [address_width:0] cnt;

    wire full_fifo_D1_reg, empty_reg;

    always@(*)begin
        if (reset_L == 0 || init == 0) begin
            full_fifo_D1 = 0;
            empty_fifo_D1 = 1;
            almost_empty_fifo_D1 = 0;
            almost_full_fifo_D1 = 0;
        end
        else begin
            full_fifo_D1 = (cnt == size_fifo || cnt > size_fifo);
            empty_fifo_D1 = (cnt == 0);                                                  
            almost_empty_fifo_D1 = (cnt <= Umbral_D1 && cnt > 0);         
            almost_full_fifo_D1 = (cnt >= size_fifo-Umbral_D1 && cnt < size_fifo); 
        end
        
    end         
    assign  full_fifo_D1_reg = full_fifo_D1;
    assign empty_reg = empty_fifo_D1;

    integer i;


// WRITE //
    always @(posedge clk) begin
       if (reset_L == 0 || init == 0) begin
            wr_ptr <= 0;
       		rd_ptr <= 4'b0;
            data_out_D1 <=0;
            cnt <= 0;
            error_D1 <= 0;
            for(i = 0; i<2**address_width; i=i+1) begin
				mem[i] <= 0;
			end
       end
        else begin
            if (reset_L == 1 && init == 1 && ~full_fifo_D1_reg) begin
                if (wr_enable == 1) begin
                     mem[wr_ptr] <= data_in;
                     wr_ptr <= wr_ptr+1;
                end

                if (~empty_reg) begin
                    if (rd_enable == 1) begin
                         data_out_D1 <= mem[rd_ptr];
                         rd_ptr <= rd_ptr+1;
                    end
                    else data_out_D1 <=0;
                end
                else data_out_D1 <= 0;

            end
            if (reset_L == 1 && init == 1 && full_fifo_D1_reg) begin
                 if (rd_enable == 1) begin
                     data_out_D1 <= mem[rd_ptr];
                     rd_ptr <= rd_ptr+1;
                     cnt <= cnt-1;
                 end
            end
            if (wr_enable && ~rd_enable && ~full_fifo_D1_reg) cnt <= cnt+1'b1;
            else if (~wr_enable && rd_enable && ~empty_reg) cnt <= cnt-1'b1;
            else if (wr_enable && rd_enable && empty_reg) cnt <= cnt+1'b1; 
            if (full_fifo_D1 && wr_enable && !rd_enable) begin
                error_D1 <= 1;
            end
            else if (empty_reg && ~wr_enable && rd_enable) begin
                error_D1 <= 1;
            end
        end
    end
       
       
endmodule