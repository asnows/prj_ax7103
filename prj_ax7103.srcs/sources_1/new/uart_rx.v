`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/26 12:48:59
// Design Name: 
// Module Name: uart_rx
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


module uart_rx
    (
        input clk,
        input rx,
        output[7:0] data_rev,
        output data_err,
        output rdsig
    
    );

    
    reg[7:0] count = 8'd0;
    reg[7:0] data_reg;
    reg parit;
    reg err_reg;
    reg rdsig_reg;
    reg rdsig_dly;
    reg rd_plus;
    
    
    reg rx_dly1;
    reg rx_plus;
    reg rx_flg = 1'b0;
    
    assign data_err = err_reg;
    assign rdsig    = rd_plus;
    assign data_rev = data_reg;
    
    
    //ÏÂ½µÑØ
    always@(posedge clk)
    begin
        //ÏÂ½µÑØ
        rx_dly1 <= rx;
        rx_plus <= rx_dly1 & (~rx);
        
    end
    
    always@(posedge clk)
    begin
        if(rx_plus == 1'b1)
        begin
            rx_flg <= 1'b1;
            rdsig_reg <= 1'b0;
        end
        else if(count == 168)
        begin
            rx_flg <= 1'b0;
            rdsig_reg <= 1'b1;
        end
    end
    
    
    always@(posedge clk)
    begin
       rdsig_dly <= rdsig_reg;
       rd_plus   <= (~rdsig_dly) & rdsig_reg; 
    end
    
    always@(posedge clk)
    begin
        if(rx_flg == 1'b1)
        begin
            count <= count + 1'b1;
            case(count)
                8'd24:
                begin
                    data_reg[0] <= rx; 
                    parit       <= rx;   
                end
                
                8'd40:
                begin
                    data_reg[1] <= rx; 
                    parit       <= parit^rx;   
                end
                
                8'd56:
                begin
                    data_reg[2] <= rx;  
                    parit       <= parit^rx;   
                      
                end
                
                8'd72:
                begin
                    data_reg[3] <= rx;
                    parit       <= parit^rx;   
                        
                end
                
                8'd88:
                begin
                    data_reg[4] <= rx; 
                    parit       <= parit^rx;   
                       
                end
                
                8'd104:
                begin
                    data_reg[5] <= rx; 
                    parit       <= parit^rx;   
                end
                
                8'd120:
                begin
                    data_reg[6] <= rx; 
                    parit       <= parit^rx;   
                end
                
                8'd136:
                begin
                    data_reg[7] <= rx; 
                    parit       <= parit^rx;   

                end
                
                8'd152:
                begin
                    if(parit == rx)
                    begin
                        err_reg <= 1'b0;    
                    end
                    else
                    begin
                        err_reg <= 1'b1; 
                    end
                end
                
                8'd168:
                begin
                    if(1'b1 == rx)
                    begin
                        err_reg <= 1'b0;    
                    end
                    else
                    begin
                        err_reg <= 1'b1; 
                    end
                end
                
           endcase
        end
        else
        begin
            count <= 8'd0;
        end
    end

endmodule
