module probador_full_logic#(
            parameter data_width = 6,
      parameter address_width = 2
            )
            (output reg clk, reset, wr_enable,
            output reg[data_width-1:0] data_in,
            output reg D0_pop, D1_pop,
      output reg init,
            output reg [3:0] umbral_MFs,
            output reg [3:0] umbral_VCs,
            output reg [3:0] umbral_Ds,
            input [5:0] data_out_D0, data_out_D1,data_out_D0_synth, data_out_D1_synth,
      input empty_fifo_D0, empty_fifo_D1,
            input error_D0, error_D1, error_D0_synth, error_D1_synth,
      input error_out,
            input active_out,
            input idle_out,
      input error_out_synth,
            input active_out_synth,
            input idle_out_synth,
      input empty_fifo_D0_synth, empty_fifo_D1_synth
            );

initial begin
  $dumpfile("prueba_full_logic_errores.vcd");
  $dumpvars;

  {wr_enable, reset} <= 0;
  data_in <= 0;
    D0_pop <= 0;
    D1_pop <= 0;
  init<=0;
  umbral_MFs [3:0] <= 1 ;
    umbral_VCs [3:0] <= 2 ;
    umbral_Ds  [3:0] <= 2 ;

  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  //wr_enable <= 1;
  reset <= 1;
  data_in <= 6'b110000;

  @(posedge clk);
  data_in <= 6'b110101;

  @(posedge clk);
  init<=1;
  data_in <= 6'b111111;
/////////////
  @(posedge clk);
  //D0_pop = 1;
  //D1_pop = 1;
  //wr_enable <= 1;

  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  data_in <= 6'b110100;
  reset <= 0;
  init <= 0;

  @(posedge clk);
  @(posedge clk);
  @(posedge clk);
  reset <= 1;

  @(posedge clk);
  data_in <= 6'b110101;

  @(posedge clk);
  init <= 1;
  wr_enable = 1;
  data_in <= 6'b110100;



  repeat (8) begin
    @(posedge clk);
    data_in <= 6'b110101;
    @(posedge clk);
    data_in <= 6'b110110;
    @(posedge clk);
    data_in <= 6'b111110;
  end
  
  @(posedge clk);
  data_in <= 6'b110010;
  D0_pop <= 1;
  D1_pop <= 1;

  @(posedge clk);
  data_in <= 6'b110011;

  repeat (10) begin
    @(posedge clk);
  end


  $finish;
  end
  initial clk <= 1;
  always #1 clk <= ~clk;
endmodule
