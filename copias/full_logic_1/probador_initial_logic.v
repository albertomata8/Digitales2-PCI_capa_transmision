module probador_initial_logic#(
            parameter data_width = 6,
			parameter address_width = 2
            )
            (
            input full_fifo_VC0,
            input empty_fifo_VC0,
            input almost_full_fifo_VC0,
            input almost_empty_fifo_VC0,
            input error_VC0,
            input [5:0] data_out_VC0,
            input full_fifo_VC1,
            input empty_fifo_VC1,
            input almost_full_fifo_VC1,
            input almost_empty_fifo_VC1,
            input error_VC1,
            input [5:0] data_out_VC1,
			input full_fifo_VC0_synth,
            input empty_fifo_VC0_synth,
            input almost_full_fifo_VC0_synth,
            input almost_empty_fifo_VC0_synth,
            input error_VC0_synth,
            input [5:0] data_out_VC0_synth,
            input full_fifo_VC1_synth,
            input empty_fifo_VC1_synth,
            input almost_full_fifo_VC1_synth,
            input almost_empty_fifo_VC1_synth,
            input error_VC1_synth,
            input [5:0] data_out_VC1_synth,
			input error_main,
            input empty_main_fifo,
			input error_main_synth,
            input empty_main_fifo_synth,
			output reg clk, reset, wr_enable,
            output reg [data_width-1:0] data_in,
            output reg pop_VC0_fifo, pop_VC1_fifo, 
			output reg Umbral_Main,
			output reg Umbral_VC0,
			output reg Umbral_VC1);

	initial begin
	$dumpfile("prueba_initial_logic.vcd");
	$dumpvars;

	{wr_enable, reset} <= 0;
	Umbral_Main<=1;
	Umbral_VC0<=1;
	Umbral_VC1<=1;
	data_in <= 0;
	pop_VC0_fifo <= 0;
	pop_VC1_fifo <= 0;

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
    wr_enable <= 1;
	reset <= 1;
	data_in <= 6'b100001;

	@(posedge clk);
	data_in <= 6'b100010;


	@(posedge clk);
	data_in <= 6'b100011;

	@(posedge clk);
	data_in <= 6'b100100;
/////////////
	@(posedge clk);
	data_in <= 6'b100100;
	pop_VC0_fifo <= 1;
	@(posedge clk);
	data_in <= 6'b100100;
////////////
	@(posedge clk);
    wr_enable <= 0;

	@(posedge clk);

	@(posedge clk);
	pop_VC0_fifo <= 0;
	pop_VC1_fifo <= 1;
	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	pop_VC1_fifo <= 0;
	@(posedge clk);

	@(posedge clk);

	@(posedge clk);

	$finish;
	end
	initial clk <= 1;
	always #1 clk <= ~clk;
endmodule