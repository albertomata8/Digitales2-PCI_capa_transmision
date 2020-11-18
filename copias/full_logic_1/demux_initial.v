module demux_initial(input clk,
				    input [5:0] data_in_demux_initial,
				    input valid_pop_out,
				    input reset,
				    output reg [5:0] data_out_demux_initial_vc0,
				    output reg [5:0] data_out_demux_initial_vc1,
                    output reg push_vc0,
                    output reg push_vc1);

    always@(posedge clk)begin
        if (reset == 0 || valid_pop_out == 0) begin
            data_out_demux_initial_vc0  <= 0;
            data_out_demux_initial_vc1  <= 0;
            push_vc0                    <= 0;
            push_vc1                    <= 0;
        end
        else if (reset == 1)begin
            if (valid_pop_out == 1) begin
                if(data_in_demux_initial[5] == 0)begin
                    data_out_demux_initial_vc0  <= data_in_demux_initial;
                    data_out_demux_initial_vc1  <= 0;
                    push_vc0                    <= 1;
                    push_vc1                    <= 0;
                end
                else if(data_in_demux_initial[5] == 1) begin
                    data_out_demux_initial_vc1  <= data_in_demux_initial;
                    data_out_demux_initial_vc0  <= 0;
                    push_vc1                    <= 1;
                    push_vc0                    <= 0;
                end
            end
        end
    end

endmodule