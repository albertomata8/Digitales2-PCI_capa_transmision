module logica_pops(input VC0_empty, VC1_empty, full_fifo_D0, full_fifo_D1, almost_full_fifo_D0, almost_full_fifo_D1,  clk, reset_L,
                    input [5:0] data_arbitro_VC0, data_arbitro_VC1,
                    output reg VC0_pop, VC1_pop, pop_delay_VC0, pop_delay_VC1);
    wire D0_pause, D1_pause;

    always@(posedge clk) begin
        if (~reset_L) begin
            pop_delay_VC0 <= 0;
            pop_delay_VC1 <= 0;
        end
        else begin
            pop_delay_VC0 <= VC0_pop;
            pop_delay_VC1 <= VC1_pop;
        end
    end

    assign  D0_pause = almost_full_fifo_D0 || full_fifo_D0;
    assign  D1_pause = almost_full_fifo_D0 || full_fifo_D1;


    always@(*) begin
        if (reset_L) begin 
            if(~(almost_full_fifo_D0 || full_fifo_D0 || almost_full_fifo_D0 || full_fifo_D1)) begin
                if(~VC1_empty && VC0_empty) VC1_pop = 1;
                else VC1_pop = 0;

                if (~VC0_empty) VC0_pop = 1;
                else VC0_pop = 0;
            end
            else begin
                VC0_pop = 0;
                VC1_pop = 0;
            end
        end
        else begin
            VC0_pop = 0;
            VC1_pop = 0;
        end
        
    end
                
endmodule