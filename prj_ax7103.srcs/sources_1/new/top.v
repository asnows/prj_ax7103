`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/25 09:11:20
// Design Name: 
// Module Name: top
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


module top
(
    input sys_clk_p,
    input sys_clk_n,
    input reset_n,
    output uart_tx,
    input  uart_rx
    
);

    wire sys_clk;

    IBUFDS#(
        .DIFF_TERM("FALSE"),//DifferentialTermination
        .IBUF_LOW_PWR("TRUE"),//Lowpower="TRUE",Highestperformance="FALSE"
        .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
    )IBUFDS_inst(
        .O(sys_clk),//Bufferoutput
        .I(sys_clk_p),//Diff_pbufferinput(connectdirectlytotop-levelport)
        .IB(sys_clk_n)//Diff_nbufferinput(connectdirectlytotop-levelport)
    );
    
    uart_test U_uart_test
    (
        .clk(sys_clk),
        .tx(uart_tx),
        .rx(uart_rx)
    );

    
    
    

endmodule
