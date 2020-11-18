module state_machine(
    input clk,
    input reset,
    input init,
    input [U_MFS-1:0] umbral_MFs,
    input [U_VCS-1:0] umbral_VCs,
    input [U_DS-1:0] umbral_Ds,
    input empty_main_fifo,
    input empty_fifo_VC0,
    input empty_fifo_VC1,
    input empty_fifo_D0,
    input empty_fifo_D1,
    input error_main,
    input error_VC0,
    input error_VC1,
    input error_D0,
    input error_D1,
    output reg error_out,
    output reg next_error,
    output reg active_out,
    output reg next_active,
    output reg idle_out,
    output reg next_idle,
    output reg [3:0] present_state,
    output reg [3:0] next_state,
    output reg [U_MFS-1:0] umbral_MFs_out,
    output reg [U_VCS-1:0] umbral_VCs_out,
    output reg [U_DS-1:0] umbral_Ds_out,
    output reg [U_MFS-1:0] next_umbral_MFs,
    output reg [U_VCS-1:0] next_umbral_VCs,
    output reg [U_DS-1:0] next_umbral_Ds
    );
    parameter U_MFS=4;
    parameter U_VCS=4;
    parameter U_DS=4;
    reg [4:0] FIFO_empties;
    reg [4:0] FIFO_errors;

    //Estados One-hot
    parameter RESET = 0;    //0000
    parameter INIT =1; //0001
    parameter IDLE = 2;  //0010
    parameter ACTIVE = 4;    //0100
    parameter ERROR = 8;  //1000

    always @(posedge clk) begin
        if (!reset) begin
            error_out <= 0;
            present_state <= RESET;
            active_out <= 0;
            idle_out <= 0;
            umbral_MFs_out<=0;
            umbral_VCs_out<=0;
            umbral_Ds_out<=0;
        end
        else begin
            present_state <= next_state;
            error_out <= next_error;
            active_out <= next_active;
            idle_out <= next_idle;
            umbral_MFs_out <= next_umbral_MFs;
            umbral_VCs_out <= next_umbral_VCs;
            umbral_Ds_out <= next_umbral_Ds;
            
        end
    end

    always @(*) begin
        // Unir errores y empities de FIFOS:
        FIFO_empties[0] = empty_fifo_D1; 
        FIFO_empties[1] = empty_fifo_D0;
        FIFO_empties[2] = empty_fifo_VC1;
        FIFO_empties[3] = empty_fifo_VC0;
        FIFO_empties[4] = empty_main_fifo;

        FIFO_errors[0] = error_D1; 
        FIFO_errors[1] = error_D0;
        FIFO_errors[2] = error_VC1;
        FIFO_errors[3] = error_VC0;
        FIFO_errors[4] = error_main;
        // Declarar estados:
        next_state = present_state;
        next_error = error_out;
        next_active = active_out;
        next_idle = idle_out;
        next_umbral_MFs = umbral_MFs_out;
        next_umbral_VCs = umbral_VCs_out;
        next_umbral_Ds = umbral_Ds_out;
        case(present_state)
            RESET:begin
                    next_error = 0;
                    if (reset) next_state = INIT;  
                     
                    else next_state = RESET;
                    
                end 

            INIT: begin

                    if (init) begin
                        next_state = IDLE;
                        
                    end
                    else if (!reset) next_state = RESET;  
                    else begin
                        next_umbral_MFs = umbral_MFs;
                        next_umbral_VCs = umbral_VCs;
                        next_umbral_Ds = umbral_Ds;
                        next_state = INIT; 
                    end 

                end 
            IDLE: begin
                    next_idle = 1;
                    if (FIFO_empties == 'b11111) begin
                        next_state = IDLE;
                        
                    end
                    else if (!reset) next_state = RESET;
                    else begin
                        next_state = ACTIVE;
                    end
                end

            ACTIVE: begin
                    if (!FIFO_errors) begin
                        next_state = ACTIVE;
                        next_active = 1;
                        next_idle = 0;
                    end
                    else if (!reset) next_state = RESET;
                    else begin
                        next_state = ERROR;
                    end
                end
            ERROR: begin
                    if (reset) begin
                        next_state = ERROR;
                        next_error = 1;
                        next_active = 0;
                    end
                    
                    else begin
                        next_state = RESET;
                    end
                end
            default: begin
                next_state = RESET;
            end 
        endcase    
    end
    
endmodule