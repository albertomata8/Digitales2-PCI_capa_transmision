module VC0_fifo #(
            parameter data_width = 6,
			parameter address_width = 4
            )
            (
            input clk, reset, wr_enable, rd_enable,
            input [data_width-1:0] data_in, init,
            input [3:0] Umbral_VC0,
            output full_fifo_VC0,
            output empty_fifo_VC0,
            output almost_full_fifo_VC0,
            output almost_empty_fifo_VC0,
            output error_VC0,
            output reg [data_width-1:0] data_out_VC0
            );

    parameter size_fifo = 2**address_width;
    reg [data_width-1:0] mem [0:size_fifo-1];
    reg [address_width-1:0] wr_ptr;
    reg [address_width-1:0] rd_ptr;
    reg [address_width:0] cnt;

    assign full_fifo_VC0 = (cnt == size_fifo);
    assign empty_fifo_VC0 = (cnt == 0);  
    assign error_VC0 = (cnt > size_fifo);
    assign almost_empty_fifo_VC0 = (cnt == Umbral_VC0);
    assign almost_full_fifo_VC0 = (cnt == size_fifo-Umbral_VC0);


// WRITE //
    always @(posedge clk) begin
       if (reset == 0) begin
       wr_ptr <= 0;
       end
       if (init == 0) begin
       wr_ptr <= 0;
       end
       if (reset==1 && init==1) begin
           if (wr_enable == 1) begin
                mem[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr+1;
           end
       end  
    end

// READ //
    always @(posedge clk) begin
       if (reset == 0) begin
       rd_ptr <= 0;
       data_out_VC0 <=0;
       end
       if (init == 0) begin
       rd_ptr <= 0;
       data_out_VC0 <=0;
       end
       if (reset==1 && init==1) begin
            if(rd_enable == 1) begin
                data_out_VC0 <= mem[rd_ptr];
                rd_ptr <= rd_ptr+1;
           end
           else data_out_VC0 <=0;
       end  
    end

//COUNTERS//
    always @(posedge clk) begin
       if (reset == 0) begin
            cnt <= 0;
       end
       if (init == 0) begin
            cnt <= 0;
       end
       if (reset==1 && init==1) begin
           case ({wr_enable, rd_enable})
               2'b00: cnt <= cnt;
               2'b01: cnt <= cnt-1;
               2'b10: cnt <= cnt+1;
               2'b11: cnt <= cnt;
               default: cnt <= cnt;
           endcase
           end
       end  

  
       
endmodule