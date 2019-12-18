`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/25 16:53:25
// Design Name: 
// Module Name: uart_model
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_model
    (
        input clk,
        input[7:0] data_send,
        input  wr_en,
        input  rx,
        
        output buff_full,
        output tx,
        output[7:0] data_rev,
        output data_err,
        output rd_valid

    );
    
    reg[7:0] data_send_dly;
    reg wr_en_dly;
    reg send_cmd ;
    reg send_plus1;
    reg send_plus2;
    reg send_plus3;
    
    wire[7:0] send_data; 
    wire uart_clk;
    wire send_empt;
    wire send_idle;
    
    always@(posedge clk)
    begin
        data_send_dly <= data_send;
        wr_en_dly     <= wr_en;
    end
    
    // generate send_plus and send_cmd
    always@(posedge uart_clk)
    begin
        if((send_idle == 1'b1)&&(send_empt == 1'b0))
        begin
            send_plus1 <= 1'b1;    
        end
        else
        begin
            send_plus1 <= 1'b0;  
        end
    end
    
    always@(posedge uart_clk)
    begin
        send_plus2 <= send_plus1;
        send_plus3 <= (~send_plus2)&send_plus1;
        send_cmd   <= send_plus3; 
    end
    
    
    uart_Baudrate u_Baudrate
    (
        .clk(clk),
        .uart_clk(uart_clk)
    );

    fifo_uart uart_sendBuff
    (
        .wr_clk (clk),
        .rd_clk (uart_clk),
        .din    (data_send_dly),
        .wr_en  (wr_en_dly),
        .rd_en  (send_plus3),
        .dout   (send_data),
        .full   (),
        .almost_full(buff_full),
        .empty  (send_empt)
    );

    uart_tx u_tx
    (
        .clk        (uart_clk   ),
        .send_cmd   (send_cmd   ),
        .data       (send_data  ),
        .idle       (send_idle  ),
        .tx         (tx         )
    );

    
     uart_rx u_rx
    (
        .clk(uart_clk   ),
        .rx(rx),
        .data_rev(data_rev),
        .data_err(data_err),
        .rdsig(rd_valid)
    );
    
    
endmodule
