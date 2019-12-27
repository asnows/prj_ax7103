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
    input  uart_rx,
    output 		rgmii1_txc 	   , //trans data clk
    output[3:0] rgmii1_txd		   ,
    output 		rgmii1_txctl      ,
    input 		rgmii1_rxc 	   , //trans data clk
    input[3:0]  rgmii1_rxd		   ,
    input 		rgmii1_rxctl      
    
    
    
);

    wire sys_clk;
    wire[7:0]  m_tdata ;
    wire       m_tlast ;
    wire       m_tready;
    wire       m_tuser ;
    wire       m_tvalid;
    wire clk_125m;
    wire tx_data_clk;
    
    assign clk_125m = sys_clk;



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




axis_master
#(
	.DATA_NUM (1024)
)
axis_master_I
(
	.clk (clk_125m ),
	.reset(~reset_n),
	.m_axis_tdata   (m_tdata ) ,
	.m_axis_tlast   (m_tlast ) ,
	.m_axis_tready  (m_tready) ,
	.m_axis_tuser   (m_tuser ) ,
	.m_axis_tvalid  (m_tvalid) 

);

    
    localparam DST_MAC = 48'h08_57_00_f4_ae_e5;
    localparam SRC_MAC = 48'h08_57_00_f4_ae_e6;
    localparam ETH_TYPE = 16'h0800;
    localparam IP_SrcAddr = 32'hc0_a8_c8_64;//192.168.200.100
    localparam IP_DestAddr = 32'hc0_a8_c8_65;//192.168.200.101
    localparam UDP_SrcPort = 16'd1536;//192.168.200.101
    localparam UDP_DestPort = 16'd1536;//192.168.200.101
    
    
    
    mac
    #(
        .MEDIA_TYPES ( "1000Base") //100Base
    )
    mac_I
    (
    .sys_clk (clk_125m),
    .dst_mac(DST_MAC),
    .src_mac(SRC_MAC),
    .eth_type(ETH_TYPE),
    .IP_TotLen(16'd1032),   //Total Length
    .IP_SrcAddr(IP_SrcAddr),
    .IP_DestAddr(IP_DestAddr),
    .UDP_SrcPort(UDP_SrcPort),
    .UDP_DestPort(UDP_DestPort),
    .UDP_TotLen  (16'd1024),//Total Length
    
    
    .s_axis_aclk     (tx_data_clk),
    .s_axis_tdata    (m_tdata ) ,
    .s_axis_tlast    (m_tlast ) ,
    .s_axis_tready   (m_tready) ,
    .s_axis_tuser    (m_tuser ) ,
    .s_axis_tvalid   (m_tvalid) ,
    
    .tx_data_clk(tx_data_clk),//generate data clk
    .tx_clk      (rgmii1_txc)  , //trans data clk
    .txd         (rgmii1_txd)  ,
    .tx_en       (rgmii1_txctl) ,
    
    .rx_clk (rgmii1_rxc)        , //trans data clk
    .rxd    (rgmii1_rxd)       ,
    .rx_en  (rgmii1_rxctl)     
    
    );
    
    

endmodule
