`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/25 10:33:31
// Design Name: 
// Module Name: top_tb
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


module top_tb(

    );
    
    reg clk_200m;
    reg resetn;
    
    reg[7:0] data_test = 8'd0;
    
    
    
    always 
    begin
        #2.5 clk_200m = 0;
        #2.5 clk_200m = 1;
    end
    
    
    initial
    begin
        #100 resetn = 1;
    end
    
//    uart_Baudrate u_uart_Baudrate
//    (
    //    .clk(clk_200m),
    //    .uart_clk()
//    );

    wire buff_full;
    wire buff_wr_en;
    wire tx;
    uart_model U_uart_model
    (
        .clk(clk_200m),
        .data_send(data_test),
        .wr_en(buff_wr_en),
        .buff_full(buff_full),
        .tx(tx),
        .rx(tx)
    );
    
    assign buff_wr_en = ~buff_full;
    always@(posedge clk_200m)
    begin
        if(buff_wr_en)
        begin
            data_test <= data_test + 1'b1;
        end
    end
    
    
    
    
    
    
    
    

    


    
    
endmodule
