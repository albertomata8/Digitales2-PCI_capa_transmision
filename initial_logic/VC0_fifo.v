module VC0_fifo #(
            parameter data_width = 6,
			parameter address_width = 4
            )
            (
            input clk, reset, wr_enable, rd_enable,
            input [data_width-1:0] data_in, init,
            input [3:0] Umbral_VC0,
            output reg full_fifo_VC0,
            output reg empty_fifo_VC0,
            output reg almost_full_fifo_VC0,
            output reg almost_empty_fifo_VC0,
            output reg error_VC0,
            output reg [data_width-1:0] data_out_VC0,
            output reg [data_width-1:0] data_arbitro_VC0
            );

    parameter size_fifo = 2**address_width;
    reg [data_width-1:0] mem [0:size_fifo-1];
    reg [address_width-1:0] wr_ptr;
    reg [address_width-1:0] rd_ptr;
    reg [address_width:0] cnt;
    wire full_fifo_VC0_reg, empty_reg;
    assign  empty_reg = empty_fifo_VC0;

    integer i;


    always@(*)begin
        if (reset == 0 || init == 0) begin
            full_fifo_VC0 = 0;
            empty_fifo_VC0 = 1;
            error_VC0 = 0;
            almost_empty_fifo_VC0 = 0;
            almost_full_fifo_VC0 = 0;
        end
        else begin
            full_fifo_VC0 = (cnt == size_fifo);
            empty_fifo_VC0 = (cnt == 0);                          
            error_VC0 = (cnt > size_fifo);                        
            almost_empty_fifo_VC0 = (cnt == Umbral_VC0);         
            almost_full_fifo_VC0 = (cnt >= size_fifo-Umbral_VC0 && cnt < size_fifo); 
        end
        
    end         
    assign full_fifo_VC0_reg = full_fifo_VC0;

    always @(posedge clk) begin
       if (reset == 0 || init == 0) begin
            wr_ptr <= 0;
       		rd_ptr <= 4'b0;
            data_out_VC0 <=0;
            cnt <= 0;
            for(i = 0; i<2**address_width; i=i+1) begin
				mem[i] <= 0;
			end
       end
        else begin
            if (reset == 1 && init == 1 && ~full_fifo_VC0_reg) begin
                if (wr_enable == 1) begin
                     mem[wr_ptr] <= data_in;
                     wr_ptr <= wr_ptr+1;
                end

                if(~empty_reg) begin 
                    if (rd_enable == 1) begin
                         data_out_VC0 <= mem[rd_ptr];
                         rd_ptr <= rd_ptr+1;
                    end
                    else data_out_VC0 <=0;
                end
                
                //case ({wr_enable, rd_enable})
                //    2'b00: cnt <= cnt;
                //    2'b01: cnt <= cnt-1;
                //    2'b10: cnt <= cnt+1;
                //    2'b11: cnt <= cnt;
                //    default: cnt <= cnt;
                //endcase

            end
            else if (reset == 1 && init == 1 && full_fifo_VC0_reg) begin
                 if (rd_enable == 1) begin
                     data_out_VC0 <= mem[rd_ptr];
                     rd_ptr <= rd_ptr+1;
                     cnt <= cnt-1;
                 end
            end
            
            if (wr_enable && ~rd_enable && ~full_fifo_VC0_reg) cnt <= cnt+1'b1;
            else if (~wr_enable && rd_enable && ~empty_reg) cnt <= cnt-1'b1;
            else if (wr_enable && rd_enable && empty_reg) cnt <= cnt+1'b1;


            data_arbitro_VC0 <= mem[rd_ptr]; //Se saca el siguiente dato para ver si es neceario pushearlo al arbitro
        end
    end
       
endmodule