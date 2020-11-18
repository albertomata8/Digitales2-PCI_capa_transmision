module logica_pops(input VC0_empty, VC1_empty, D0_pause, D1_pause, clk, reset_L,
                    output reg VC0_pop, VC1_pop, pop_delay_VC0, pop_delay_VC1);

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


    always@(*) begin
        if (reset_L) begin 
            if(~(D0_pause||D1_pause)) begin
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