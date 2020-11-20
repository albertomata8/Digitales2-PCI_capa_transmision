module VC1_fifo #(
            parameter data_width = 6,
			parameter address_width = 4
            )
            (
            input clk, reset, wr_enable, rd_enable, init,
            input [data_width-1:0] data_in,
            input [3:0] Umbral_VC1,
            output reg full_fifo_VC1,
            output reg empty_fifo_VC1,
            output reg almost_full_fifo_VC1,
            output reg almost_empty_fifo_VC1,
            output reg error_VC1,
            output reg [data_width-1:0] data_out_VC1,
            output reg [data_width-1:0] data_arbitro_VC1
            );

    parameter size_fifo = 2**address_width;
    reg [data_width-1:0] mem [0:size_fifo-1];
    reg [address_width-1:0] wr_ptr;
    reg [address_width-1:0] rd_ptr;
    reg [address_width:0] cnt;
    wire full_fifo_VC1_reg, empty_reg;
    assign  empty_reg = empty_fifo_VC1;

    integer i;
    
    always@(*)begin
        if (reset == 0 || init == 0) begin
            full_fifo_VC1 = 0;
            empty_fifo_VC1 = 1;
            almost_empty_fifo_VC1 = 0;
            almost_full_fifo_VC1 = 0;
        end
        else begin
            full_fifo_VC1 = (cnt == size_fifo || cnt > size_fifo );
            empty_fifo_VC1 = (cnt == 0);                          
            almost_empty_fifo_VC1 = (cnt == Umbral_VC1);         
            almost_full_fifo_VC1 = (cnt >= size_fifo-Umbral_VC1 && cnt < size_fifo); 
        end
        
    end         
    assign full_fifo_VC1_reg = full_fifo_VC1;

    always @(posedge clk) begin
       if (reset == 0 || init == 0) begin
            wr_ptr <= 0;
       		rd_ptr <= 4'b0;
            data_out_VC1 <=0;
            cnt <= 0;
            error_VC1 <= 0;
            for(i = 0; i<2**address_width; i=i+1) begin
				mem[i] <= 0;
			end
       end
        else begin
            if (reset == 1 && init == 1 && ~full_fifo_VC1_reg) begin
                if (wr_enable == 1) begin
                     mem[wr_ptr] <= data_in;
                     wr_ptr <= wr_ptr+1;
                end

                if (~empty_reg) begin
                    if (rd_enable == 1) begin
                         data_out_VC1 <= mem[rd_ptr];
                         rd_ptr <= rd_ptr+1;
                    end
                    else data_out_VC1 <=0;
                end

                //case ({wr_enable, rd_enable})
                //    2'b00: cnt <= cnt;
                //    2'b01: cnt <= cnt-1;
                //    2'b10: cnt <= cnt+1;
                //    2'b11: cnt <= cnt;
                //    default: cnt <= cnt;
                //endcase
            end
            if (reset == 1 && init == 1 && full_fifo_VC1_reg) begin
                 if (rd_enable == 1) begin
                    data_out_VC1 <= mem[rd_ptr];
                    rd_ptr <= rd_ptr+1;
                    cnt <= cnt-1;
                 end
            end
            if (wr_enable && ~rd_enable && ~full_fifo_VC1_reg) cnt <= cnt+1'b1;
            else if (~wr_enable && rd_enable && ~empty_reg) cnt <= cnt-1'b1;
            else if (wr_enable && rd_enable && empty_reg) cnt <= cnt+1'b1;
            if (full_fifo_VC1 && wr_enable && !rd_enable) begin
                error_VC1 <= 1;
            end
            data_arbitro_VC1 <= mem[rd_ptr];
        end
    end

  
       
endmodule