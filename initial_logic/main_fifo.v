module main_fifo #(
            parameter data_width = 6,
			parameter address_width = 2
            )
            (
            input clk, reset, wr_enable, rd_enable,init,
            input [data_width-1:0] data_in,
            input [3:0] Umbral_Main,
            output reg full_fifo,
            output reg empty_fifo,
            output reg almost_full_fifo,
            output reg almost_empty_fifo,
            output reg error,
            output reg [data_width-1:0] data_out
            );

    parameter size_fifo = 2**address_width;
    reg [data_width-1:0] mem [0:size_fifo-1];
    reg [address_width-1:0] wr_ptr;
    reg [address_width-1:0] rd_ptr;
    reg [address_width:0] cnt;
    wire full_fifo_main_reg;
    always@(*)begin
        if (reset == 0 || init == 0) begin
            full_fifo = 0;
            empty_fifo = 1;
            error = 0;
            almost_empty_fifo = 0;
            almost_full_fifo = 0;
        end
        else begin
            full_fifo = (cnt == size_fifo);
            empty_fifo = (cnt == 0);                          
            error = (cnt > size_fifo);                        
            almost_empty_fifo = (cnt == Umbral_Main);         
            almost_full_fifo = (cnt >= size_fifo-Umbral_Main && cnt < size_fifo); 
        end
        
    end                                         
    assign full_fifo_main_reg = full_fifo;                      
    integer i;

// WRITE //
    always @(posedge clk) begin
       if (reset == 0 || init == 0) begin
            wr_ptr <= 0;
       		rd_ptr <= 4'b0;
            data_out <=0;
            cnt <= 0;
            for(i = 0; i<2**address_width; i=i+1) begin
				mem[i] <= 0;
			end
       end
        else begin
            if (reset == 1 && init == 1 && ~full_fifo_main_reg) begin
                if (wr_enable == 1) begin
                     mem[wr_ptr] <= data_in;
                     wr_ptr <= wr_ptr+1;
                end
                if (rd_enable == 1) begin
                     data_out <= mem[rd_ptr];
                     rd_ptr <= rd_ptr+1;
                end
                else data_out <=0;

            end
            else if (reset == 1 && init == 1 && full_fifo_main_reg) begin
                if (rd_enable == 1) begin
                    data_out <= mem[rd_ptr];
                    rd_ptr <= rd_ptr+1;
                end
            end
            if (wr_enable && ~rd_enable && ~full_fifo_main_reg) cnt <= cnt+1'b1;
            else if (~wr_enable && rd_enable) cnt <= cnt-1'b1;

        end
    end
       
endmodule