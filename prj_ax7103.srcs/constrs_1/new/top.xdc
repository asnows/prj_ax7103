set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
############## clock define##################
create_clock -period 5.000 [get_ports sys_clk_p]
set_property PACKAGE_PIN R4 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]
############## usb uart define##################
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx]
set_property PACKAGE_PIN P20 [get_ports uart_rx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx]
set_property PACKAGE_PIN N15 [get_ports uart_tx]



set_property PACKAGE_PIN T6 [get_ports reset_n]
set_property IOSTANDARD LVCMOS15 [get_ports reset_n]


#########################ethernet######################
create_clock -period 8.000 [get_ports rgmii1_rxc]
set_property IOSTANDARD LVCMOS33 [get_ports {rgmii1_rxd[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgmii1_txd[*]}]
set_property SLEW FAST [get_ports {rgmii1_txd[*]}]

set_property IOSTANDARD LVCMOS33 [get_ports e1_mdc]
set_property IOSTANDARD LVCMOS33 [get_ports e1_mdio]
set_property IOSTANDARD LVCMOS33 [get_ports e1_reset]
set_property IOSTANDARD LVCMOS33 [get_ports rgmii1_rxc]
set_property IOSTANDARD LVCMOS33 [get_ports rgmii1_rxctl]
set_property IOSTANDARD LVCMOS33 [get_ports rgmii1_txc]
set_property IOSTANDARD LVCMOS33 [get_ports rgmii1_txctl]
set_property SLEW FAST [get_ports rgmii1_txc]
set_property SLEW FAST [get_ports rgmii1_txctl]

set_property PACKAGE_PIN C19 [get_ports {rgmii1_rxd[3]}]
set_property PACKAGE_PIN C18 [get_ports {rgmii1_rxd[2]}]
set_property PACKAGE_PIN B18 [get_ports {rgmii1_rxd[1]}]
set_property PACKAGE_PIN A16 [get_ports {rgmii1_rxd[0]}]
set_property PACKAGE_PIN A18 [get_ports {rgmii1_txd[3]}]
set_property PACKAGE_PIN A19 [get_ports {rgmii1_txd[2]}]
set_property PACKAGE_PIN D20 [get_ports {rgmii1_txd[1]}]
set_property PACKAGE_PIN C20 [get_ports {rgmii1_txd[0]}]
set_property PACKAGE_PIN B16 [get_ports e1_mdc]
set_property PACKAGE_PIN B15 [get_ports e1_mdio]
set_property PACKAGE_PIN D16 [get_ports e1_reset]
set_property PACKAGE_PIN B17 [get_ports rgmii1_rxc]
set_property PACKAGE_PIN A15 [get_ports rgmii1_rxctl]
set_property PACKAGE_PIN E18 [get_ports rgmii1_txc]
set_property PACKAGE_PIN F18 [get_ports rgmii1_txctl]



create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 8192 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list U_uart_test/U_uart_model/uart_clk_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {U_uart_test/data_rev_dly[0]} {U_uart_test/data_rev_dly[1]} {U_uart_test/data_rev_dly[2]} {U_uart_test/data_rev_dly[3]} {U_uart_test/data_rev_dly[4]} {U_uart_test/data_rev_dly[5]} {U_uart_test/data_rev_dly[6]} {U_uart_test/data_rev_dly[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {U_uart_test/data_rev[0]} {U_uart_test/data_rev[1]} {U_uart_test/data_rev[2]} {U_uart_test/data_rev[3]} {U_uart_test/data_rev[4]} {U_uart_test/data_rev[5]} {U_uart_test/data_rev[6]} {U_uart_test/data_rev[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {U_uart_test/data_test[0]} {U_uart_test/data_test[1]} {U_uart_test/data_test[2]} {U_uart_test/data_test[3]} {U_uart_test/data_test[4]} {U_uart_test/data_test[5]} {U_uart_test/data_test[6]} {U_uart_test/data_test[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list U_uart_test/buff_full]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list U_uart_test/buff_wr_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list U_uart_test/rd_rise]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list U_uart_test/rd_valid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list U_uart_test/rd_valid_dly]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list U_uart_test/rx]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list U_uart_test/tx]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_uart_clk_BUFG]
