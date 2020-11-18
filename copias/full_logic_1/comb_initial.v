module comb_initial(input clk,
                    input reset,
				    input pause_vc0,
				    input pause_vc1,
                    input empty_main_fifo,
                    output reg pop_main_fifo, //read enable del main fifo 
                    output reg valid_pop_out);

reg valid_pop_delay;

    always @ (*) begin
        if(reset==0) pop_main_fifo = 0;
        else pop_main_fifo = ((!(pause_vc0 | pause_vc1))&(!(empty_main_fifo)));
        //valid_pop_out = pop_main_fifo;
    end

    always @(posedge clk) begin
        if (reset==0) begin
            valid_pop_out <= 0;
        end
        //valid_pop_delay <= pop_main_fifo;
        valid_pop_out <= pop_main_fifo;
    end

endmodule
