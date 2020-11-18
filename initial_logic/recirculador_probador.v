module recirculador(input [5:0] data_in,
                    input full_fifo,
                    input almost_full_fifo,
                    output push_main_fifo);


always @(*) begin
    if (full_fifo || almost_full_fifo) push_main_fifo = 0;
    else push_main_fifo = 1;
end

endmodule
