module main_fifo #(
            parameter data_width = 6,
			parameter address_width = 2
            )
            (
            input clk, reset, wr_enable, rd_enable, init,
            input [data_width-1:0] data_in,
            input [3:0] Umbral_Main,
            output full_fifo,
            output empty_fifo,
            output almost_full_fifo,
            output almost_empty_fifo,
            output error,
            output reg [data_width-1:0] data_out
            );

    parameter size_fifo = 2**address_width;
    reg [data_width-1:0] mem [0:size_fifo-1];
    reg [address_width-1:0] wr_ptr;
    reg [address_width-1:0] rd_ptr;
    reg [address_width:0] cnt;

    assign full_fifo = (cnt == size_fifo);
    assign empty_fifo = (cnt == 0);  
    assign error = (cnt > size_fifo);
    assign almost_empty_fifo = (cnt == Umbral_Main);
    assign almost_full_fifo = (cnt == size_fifo-Umbral_Main);


// WRITE //
    always @(posedge clk) begin
       if (reset == 0) begin
       wr_ptr <= 0;
       end
       if (init == 0) begin
       wr_ptr <= 0;
       end
       if (reset == 1 && init==1) begin
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
       data_out <=0;
       end
       if (init == 0) begin
       rd_ptr <= 0;
       data_out <=0;
       end
       if (reset==1 && init==1) begin
           if (rd_enable == 1) begin
                data_out <= mem[rd_ptr];
                rd_ptr <= rd_ptr+1;
           end
           else data_out <=0;
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