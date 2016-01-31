#Remove FIFO object first
delete_bd_objs [get_bd_cells axis_data_fifo_0]

#Add ip generated by HLS
create_bd_cell -type ip -vlnv k88k:hls:my_mult_axis:1.0 my_mult_axis_0

#Hook up my_mult_0 to axi_dma_0
connect_bd_intf_net [get_bd_intf_pins my_mult_axis_0/S_AXIS   ]   [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S     ]
connect_bd_intf_net [get_bd_intf_pins my_mult_axis_0/D_AXIS   ]   [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM     ]
connect_bd_net      [get_bd_pins      my_mult_axis_0/ap_rst_n ]   [get_bd_pins      axi_dma_0/axi_resetn      ]
connect_bd_net      [get_bd_pins      my_mult_axis_0/ap_clk   ]   [get_bd_pins      axi_dma_0/m_axi_mm2s_aclk ]

# Passthrough tlast signal from MM2S to S2MM
connect_bd_net [get_bd_pins axi_dma_0/m_axis_mm2s_tlast] [get_bd_pins axi_dma_0/s_axis_s2mm_tlast]

regenerate_bd_layout
validate_bd_design
save_bd_design
