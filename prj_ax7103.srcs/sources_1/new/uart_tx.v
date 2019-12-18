`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/25 15:15:47
// Design Name: 
// Module Name: uart_tx
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


module uart_tx
    (
        input       clk,     
        input       send_cmd,
        inout[7:0]  data, 
        output      dvalid, //out data valide   
        output      idle,    
        output      tx       
    );
    
    localparam paritymode =1'b0;//1= 奇校验，0= 偶校验
    reg[7:0] data_dly1;
    reg send_dly1;
    reg dvalid_reg = 1'b0;
    reg send;
    reg idle_reg = 1'b1;
    reg tx_reg;
    reg[7:0] count = 8'd0;
    reg parit;


    assign idle = idle_reg;
    assign tx   = tx_reg;
    assign dvalid = dvalid_reg;
        
    always@(posedge clk)
    begin
        send_dly1 <= send_cmd;
        data_dly1 <= data;
        
    end
    
    always@(*)
    begin
        if(send_cmd == 1'b1)
        begin
            idle_reg <= 1'b0;
        end
        else if(count == 8'd11)
        begin
            idle_reg <= 1'b1;
        end
    end
    
    always@(posedge clk)
    begin
        if((~send_dly1)&send_cmd)
        begin
            send <= 1'b1;
        end
        else if(count == 8'd10)
        begin
            send <= 1'b0;
        end
    end  
    
    always@(posedge clk)
    begin
        if(send == 1'b1)
        begin
            count <= count + 1'b1;    
        end 
        else
        begin
            count <= 8'd0;    
        end
    end
    
    always@(posedge clk)
    begin
        if(send == 1'b1)
        begin
            case(count)
                8'd0:
                begin
                    tx_reg <= 1'b0; // 起始位
                    dvalid_reg <= 1'd1;
                end
                
                8'd1://d16:
                begin
                    tx_reg <= data_dly1[0]; 
                    parit  <= data_dly1[0]^paritymode;  
                    dvalid_reg <= 1'd1;   
                end
                
                8'd2://d32:
                begin
                    tx_reg <= data_dly1[1];
                    parit  <= data_dly1[1]^parit; 
                    dvalid_reg <= 1'd1;   
                end
                
                8'd3://d48:
                begin
                    tx_reg <= data_dly1[2];
                    parit  <= data_dly1[2]^parit;  
                    dvalid_reg <= 1'd1;  
                end
                
                8'd4://d64:
                begin
                    tx_reg <= data_dly1[3];
                    parit  <= data_dly1[3]^parit;
                    dvalid_reg <= 1'd1;    
                end
                
                8'd5://d80:
                begin
                    tx_reg <= data_dly1[4];
                    parit  <= data_dly1[4]^parit; 
                    dvalid_reg <= 1'd1;   
                end
                
                8'd6://d96:
                begin
                    tx_reg <= data_dly1[5]; 
                    parit  <= data_dly1[5]^parit;
                    dvalid_reg <= 1'd1;   
                end
                
                8'd7://d112:
                begin
                    tx_reg <= data_dly1[6]; 
                    parit  <= data_dly1[6]^parit;
                    dvalid_reg <= 1'd1;   
                end
                
                8'd8://d128:
                begin
                    tx_reg <= data_dly1[7]; 
                    parit  <= data_dly1[7]^parit;
                    dvalid_reg <= 1'd1;  
                end
                
                8'd9://d144:
                begin
                    tx_reg <= parit;
                    dvalid_reg <= 1'd1; 
                end
                
                8'd10://d160:
                begin
                    tx_reg <= 1'b1; //发送停止
                    dvalid_reg <= 1'd1;
                end
                default:;
                
            endcase
        end
        else
        begin
            tx_reg <= 1'b1;
            dvalid_reg <= 1'd0; 
        end
        
    end



    
endmodule
