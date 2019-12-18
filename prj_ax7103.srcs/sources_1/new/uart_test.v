`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/29 18:31:45
// Design Name: 
// Module Name: uart_test
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
// 
//`define TX_TEST
`define RX_TO_TX
//////////////////////////////////////////////////////////////////////////////////


module uart_test
    (
        input clk,
    (*mark_debug = "true"*)        output tx,
    (*mark_debug = "true"*)        input  rx
    
        );
        
    (*mark_debug = "true"*) wire buff_full;
    (*mark_debug = "true"*) wire buff_wr_en;
    (*mark_debug = "true"*) reg[7:0] data_test = 8'd0;
    (*mark_debug = "true"*) wire[7:0] data_rev;
    (*mark_debug = "true"*) wire rd_valid;
    
    reg[7:0] test_data[17:0];
    reg[7:0] test_cout = 8'd0;
    
    
    always@(*)
    begin
        test_data[0] = "h";
        test_data[1] = "e";
        test_data[2] = "l";
        test_data[3] = "l";
        test_data[4] = "o";
        test_data[5] = "w";
        test_data[6] = " ";
        test_data[7] = "f";
        test_data[8] = "p";
        test_data[9] = "g";        
        test_data[10] = "a";    
        test_data[11] = " ";        
        test_data[12] = "w";     
        test_data[13] = "o";        
        test_data[14] = "r";    
        test_data[15] = "d";        
        test_data[16] = "\r";  
        test_data[17] = "\n";        
    end
    
`ifdef TX_TEST    
    assign buff_wr_en = ~buff_full;
    always@(posedge clk)
    begin
        if(buff_wr_en)
        begin
            //data_test <= data_test + 1'b1;
            
            if(test_cout < 8'd17 )
            begin
                test_cout <= test_cout + 1'b1;
            end
            else
            begin
                test_cout <= 8'd0;
            end
            
            data_test <= test_data[test_cout];
        end
    end
    
    
    
    
    
`endif

`ifdef RX_TO_TX
    (*mark_debug = "true"*)reg rd_valid_dly;
    (*mark_debug = "true"*)reg rd_rise;
    (*mark_debug = "true"*)reg[7:0] data_rev_dly;
    
    always@(posedge clk)
    begin
        rd_valid_dly    <= rd_valid;  
        rd_rise         <= (~rd_valid_dly) & rd_valid;
        data_rev_dly    <= data_rev;
    end
    
    
    assign buff_wr_en = rd_rise;
    always@(posedge clk)
    begin
        data_test <= data_rev_dly;    
    end

`endif   
    
        
    uart_model U_uart_model
    (
        .clk(clk),
        .data_send(data_test),
        .wr_en(buff_wr_en),
        .rx(rx),
        
        .buff_full(buff_full),
        .tx (tx),
        .data_rev(data_rev),
        .data_err(),
        .rd_valid(rd_valid)
    
    );
    
    

        
endmodule
