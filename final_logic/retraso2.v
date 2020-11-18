module retraso2 (
            input clk,D0_push,D1_push,
            input [5:0] arbitro_D0_out ,
            input [5:0] arbitro_D1_out ,
            output reg  D0_push_retrasado,D1_push_retrasado,
            output reg [5:0] arbitro_D0_out_retrasado ,
            output reg [5:0] arbitro_D1_out_retrasado 
            );

// WRITE //
    always @(posedge clk) begin
       arbitro_D0_out_retrasado[5:0] <= arbitro_D0_out[5:0];
	   arbitro_D1_out_retrasado[5:0] <= arbitro_D1_out[5:0];
       D0_push_retrasado <= D0_push;
       D1_push_retrasado <= D1_push;
    end
  
       
endmodule