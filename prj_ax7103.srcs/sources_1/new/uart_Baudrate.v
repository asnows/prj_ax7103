`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/25 10:17:38
// Design Name: 
// Module Name: uart_Baudrate
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
// clk = 200mhz
//Baudrate = 115200
// uart_clk = 16*Baudrate//16±¶µÄBaudrateÊä³ö
//////////////////////////////////////////////////////////////////////////////////


module uart_Baudrate
    #(
      parameter CLK_MHZ  = 200,
      parameter BAUTDRATE = 115200
    )
    (
        input clk,
        output uart_clk
         
    );

    //localparam NUM  = 54; // 200Mhz/(115200 * 16)/2
    localparam NUM  = (CLK_MHZ * 1000000)/(BAUTDRATE * 2);//100Mhz/(115200 * 2)
    reg[12:0] counter = 8'd1;
    reg uart_clk_reg = 1'b0;
    
    assign uart_clk = uart_clk_reg;
    
    always@(posedge clk)
    begin

        if(counter < NUM)
        begin
            counter <= counter + 1'b1;
        end
        else
        begin
            counter <= 8'd1;
        end
    end
    
    always@(posedge clk)
    begin
        if(counter == NUM)
        begin
            uart_clk_reg <= ~uart_clk_reg;    
        end
    end
    
endmodule
