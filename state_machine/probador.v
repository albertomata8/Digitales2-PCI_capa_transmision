module probador#(
                    parameter U_MFS=4,
                    parameter U_VCS=4,
                    parameter U_DS=4
                    )
    (
    input error_out,
    input next_error,
    input active_out,
    input idle_out,
    input [3:0] present_state,
    input [3:0] next_state,
    input [U_MFS-1:0] umbral_MFs_out,
    input [U_VCS-1:0] umbral_VCs_out,
    input [U_DS-1:0] umbral_Ds_out,
    input [U_MFS-1:0] next_umbral_MFs,
    input [U_VCS-1:0] next_umbral_VCs,
    input [U_DS-1:0] next_umbral_Ds,
    input error_out_synth,
    input next_error_synth,
    input active_out_synth,
    input idle_out_synth,
    input [3:0] present_state_synth,
    input [3:0] next_state_synth,
    input [U_MFS-1:0] umbral_MFs_out_synth,
    input [U_VCS-1:0] umbral_VCs_out_synth,
    input [U_DS-1:0] umbral_Ds_out_synth, 
    input [U_MFS-1:0] next_umbral_MFs_synth,
    input [U_VCS-1:0] next_umbral_VCs_synth,
    input [U_DS-1:0] next_umbral_Ds_synth,
    output reg reset,
    output reg clk,
    output reg init,
    output reg [U_MFS-1:0] umbral_MFs,
    output reg [U_VCS-1:0] umbral_VCs,
    output reg [U_DS-1:0] umbral_Ds,
    output reg empty_main_fifo,
    output reg empty_fifo_VC0,
    output reg empty_fifo_VC1,
    output reg empty_fifo_D0,
    output reg empty_fifo_D1,
    output reg error_main,
    output reg error_VC0,
    output reg error_VC1,
    output reg error_D0,
    output reg error_D1
    );

  initial begin

    $dumpfile("probador.vcd");
    $dumpvars();
    reset <= 0;
    init<=0;
    umbral_MFs<=0000;
    umbral_VCs<=0000;
    umbral_Ds<=0000;
    empty_main_fifo <= 1;
    empty_fifo_VC0 <= 1;
    empty_fifo_VC1 <= 1;
    empty_fifo_D0 <= 1;
    empty_fifo_D1 <= 1;
    error_main <= 0;
    error_VC0 <= 0;
    error_VC1 <= 0;
    error_D0 <= 0;
    error_D1 <= 0;
    @(posedge clk);
    reset <= 0;
    @(posedge clk);
    reset <= 1;
    @(posedge clk);
    umbral_MFs<=1110;
    umbral_VCs<=0111;
    umbral_Ds<=1001;
    @(posedge clk);
    init<=1;
    umbral_MFs<=0001;
    umbral_VCs<=0001;
    umbral_Ds<=0001;
    @(posedge clk);
    init<=1;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    empty_main_fifo <= 0;
    empty_fifo_VC0 <= 0;
    empty_fifo_VC1 <= 1;
    empty_fifo_D0 <= 0;
    empty_fifo_D1 <= 0;
    @(posedge clk);
    @(posedge clk);
    umbral_MFs<=1111;
    umbral_VCs<=1111;
    umbral_Ds<=1111;
    @(posedge clk);
    @(posedge clk);
    error_main <= 1;
    error_VC0 <= 0;
    error_VC1 <= 0;
    error_D0 <= 0;
    error_D1 <= 0;
    @(posedge clk);
    @(posedge clk);
    umbral_MFs<=1010;
    umbral_VCs<=1010;
    umbral_Ds<=1010;
    @(posedge clk);
    @(posedge clk);
    reset <= 0;
    @(posedge clk);
    @(posedge clk);
    $finish;
  end

  initial clk <= 0;
  always #1 clk <= ~clk;
endmodule