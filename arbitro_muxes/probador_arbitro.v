module probador_arbitro(output reg [5:0] VC0, VC1,
                output reg clk, reset_L,
                output reg VC0_empty, VC1_empty,
                output reg D0_pause, D1_pause,
                input [5:0] arbitro_D0_out, arbitro_D1_out, arbitro_D0_out_synth, arbitro_D1_out_synth, 
                input VC0_pop, VC1_pop, VC1_pop_synth, VC0_pop_synth, D0_push, D1_push);

	initial begin
	$dumpfile("arbitro.vcd");
	$dumpvars;

    reset_L <= 0;
    D0_pause <= 0;
    D1_pause <= 0;
    VC0_empty <= 0;
    VC1_empty <= 0;

	@(posedge clk);
	@(posedge clk);
    reset_L <= 1;
    VC0 <= 6'b110100;
    VC1 <= 6'b110110;
    @(posedge clk);

    VC0 <= 6'b100101;
    VC1 <= 6'b101100;

    @(posedge clk);
    VC0_empty <= 1;
    VC0 <= 6'b110100;
    VC1 <= 6'b110100;

    @(posedge clk);
    D0_pause <= 1;
    D1_pause <= 0;
    VC0 <= 6'b110110;
    VC1 <= 6'b110101;

    @(posedge clk);
    D0_pause <= 0;
    D1_pause <= 0;
    VC0 <= 6'b110110;
    VC1 <= 6'b110100;

    @(posedge clk);
    VC0 <= 6'b111101;
    VC1 <= 6'b010110;
    @(posedge clk);
    @(posedge clk);



	$finish;
	end
	initial clk <= 1;
	always #1 clk <= ~clk;
endmodule 