module VC1_fifo #(
            parameter data_width = 6,
			parameter address_width = 2
            )
            (
            input clk, reset, wr_enable, rd_enable,
            input [data_width-1:0] data_in,
            input [3:0] Umbral_VC1,
            output full_fifo_VC1,
            output empty_fifo_VC1,
            output almost_full_fifo_VC1,
            output almost_empty_fifo_VC1,
            output error_VC1,
            output reg [data_width-1:0] data_out_VC1
            );

    parameter size_fifo = 2**address_width;
    reg [data_width-1:0] mem [0:size_fifo-1];
    reg [address_width-1:0] wr_ptr;
    reg [address_width-1:0] rd_ptr;
    reg [address_width:0] cnt;

    assign full_fifo_VC1 = (cnt == size_fifo);
    assign empty_fifo_VC1 = (cnt == 0);  
    assign error_VC1 = (cnt > size_fifo);
    assign almost_empty_fifo_VC1 = (cnt == Umbral_VC1);
    assign almost_full_fifo_VC1 = (cnt == size_fifo-Umbral_VC1);


// WRITE //
    always @(posedge clk) begin
       if (reset == 0) begin
       wr_ptr <= 0;
       end
       else begin
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
       data_out_VC1 <=0;
       end
       else begin
           if (rd_enable == 1) begin
                data_out_VC1 <= mem[rd_ptr];
                rd_ptr <= rd_ptr+1;
           end
           else data_out_VC1 <=0;
       end  
    end

//COUNTERS//
    always @(posedge clk) begin
       if (reset == 0) begin
            cnt <= 0;
       end
       else begin
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