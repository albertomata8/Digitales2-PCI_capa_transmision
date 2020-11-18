module probador_fifo#(
                    parameter data_width = 6,
					parameter address_width = 2)
					(
                    output reg clk, wr_enable, rd_enable, reset,
					output reg [data_width-1:0] data_in,
                    input full_fifo, empty_fifo, error, almost_empty_fifo, almost_fifo_full,
					input [data_width-1:0] data_out,
					input [data_width-1:0] data_out_synth
                    );

	initial begin
	$dumpfile("fifo.vcd");
	$dumpvars;

	{wr_enable, rd_enable, reset} <= 0;
	data_in <= 0;

	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	
    @(posedge clk);
    wr_enable <= 1;
	reset <= 1;
	data_in <= 6'b000001;
	

	@(posedge clk);
	data_in <= 6'b000010;

	@(posedge clk);
	data_in <= 6'b000011;

	@(posedge clk);
	data_in <= 6'b000100;
/////////////
	@(posedge clk);
	data_in <= 6'b000100;
	@(posedge clk);
	data_in <= 6'b000100;
////////////
	@(posedge clk);
    wr_enable <= 0;
    rd_enable <= 1;

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	$finish;
	end
	initial clk <= 1;
	always #1 clk <= ~clk;
endmodule