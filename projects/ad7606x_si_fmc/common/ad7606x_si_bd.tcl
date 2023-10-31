###############################################################################
## Copyright (C) 2023 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# system level parameters
set DEV_CONFIG $ad_project_params(DEV_CONFIG)
set NUM_OF_SDI $ad_project_params(NUM_OF_SDI)
set ADC_N_BITS [expr {$DEV_CONFIG == 2 ? 18 : 16}]
set ADC_TO_DMA_N_BITS [expr {$ADC_N_BITS == 16 ? 16 : 32}]

    create_bd_intf_port -mode Master -vlnv analog.com:interface:spi_master_rtl:1.0 ad7606_spi
    create_bd_port -dir O rx_cnvst_n
    create_bd_port -dir I rx_busy

    source $ad_hdl_dir/library/spi_engine/scripts/spi_engine.tcl

    set data_width    $ADC_TO_DMA_N_BITS
    set async_spi_clk 1
    set num_cs        1
    set num_sdi       $NUM_OF_SDI
    set sdi_delay     1

    set hier_spi_engine spi_ad7606

    spi_engine_create $hier_spi_engine $data_width $async_spi_clk $num_cs $num_sdi $sdi_delay

    # axi_clkgen
    ad_ip_instance axi_clkgen spi_clkgen
    ad_ip_parameter spi_clkgen CONFIG.CLK0_DIV 5
    ad_ip_parameter spi_clkgen CONFIG.VCO_DIV 1
    ad_ip_parameter spi_clkgen CONFIG.VCO_MUL 6

    # axi_pwm_gen
    ad_ip_instance axi_pwm_gen ad7606_pwm_gen
    ad_ip_parameter ad7606_pwm_gen CONFIG.PULSE_0_PERIOD 120
    ad_ip_parameter ad7606_pwm_gen CONFIG.PULSE_0_WIDTH 1

    # trigger to BUSY's negative edge
    create_bd_cell -type module -reference sync_bits busy_sync
    create_bd_cell -type module -reference ad_edge_detect busy_capture
    set_property -dict [list CONFIG.EDGE 1] [get_bd_cells busy_capture]

    ad_connect spi_clk busy_capture/clk
    ad_connect busy_capture/rst GND

    ad_connect busy_sync/out_resetn $hier_spi_engine/${hier_spi_engine}_axi_regmap/spi_resetn
    ad_connect spi_clk busy_sync/out_clk
    ad_connect busy_sync/in_bits rx_busy
    ad_connect busy_sync/out_bits busy_capture/signal_in
    ad_connect busy_capture/signal_out $hier_spi_engine/trigger

    # dma
    ad_ip_instance axi_dmac axi_ad7606_dma
    ad_ip_parameter axi_ad7606_dma CONFIG.DMA_TYPE_SRC 1
    ad_ip_parameter axi_ad7606_dma CONFIG.DMA_TYPE_DEST 0
    ad_ip_parameter axi_ad7606_dma CONFIG.CYCLIC 0
    ad_ip_parameter axi_ad7606_dma CONFIG.SYNC_TRANSFER_START 0
    ad_ip_parameter axi_ad7606_dma CONFIG.AXI_SLICE_SRC 0
    ad_ip_parameter axi_ad7606_dma CONFIG.AXI_SLICE_DEST 1
    ad_ip_parameter axi_ad7606_dma CONFIG.DMA_2D_TRANSFER 0
    ad_ip_parameter axi_ad7606_dma CONFIG.DMA_DATA_WIDTH_SRC [expr $data_width * $num_sdi]
    ad_ip_parameter axi_ad7606_dma CONFIG.DMA_DATA_WIDTH_DEST 64

    # interface connections
    ad_connect $sys_cpu_clk spi_clkgen/clk
    ad_connect $sys_cpu_clk $hier_spi_engine/clk
    ad_connect $sys_cpu_clk ad7606_pwm_gen/s_axi_aclk

    ad_connect spi_clk spi_clkgen/clk_0
    ad_connect spi_clk $hier_spi_engine/spi_clk
    ad_connect spi_clk ad7606_pwm_gen/ext_clk
    ad_connect spi_clk axi_ad7606_dma/s_axis_aclk

    ad_connect sys_cpu_resetn ad7606_pwm_gen/s_axi_aresetn
    ad_connect sys_cpu_resetn $hier_spi_engine/resetn
    ad_connect sys_cpu_resetn axi_ad7606_dma/m_dest_axi_aresetn

    ad_connect rx_cnvst_n ad7606_pwm_gen/pwm_0

    ad_connect axi_ad7606_dma/s_axis $hier_spi_engine/m_axis_sample

    ad_connect ad7606_spi $hier_spi_engine/m_spi

    # interconnect
    ad_cpu_interconnect 0x44a00000 $hier_spi_engine/${hier_spi_engine}_axi_regmap
    ad_cpu_interconnect 0x44a30000 axi_ad7606_dma
    ad_cpu_interconnect 0x44a70000 spi_clkgen
    ad_cpu_interconnect 0x44b00000 ad7606_pwm_gen

    # interrupts
    ad_cpu_interrupt ps-13 mb-13 axi_ad7606_dma/irq
    ad_cpu_interrupt ps-12 mb-12 /$hier_spi_engine/irq

    # memory interconnect
    ad_mem_hp1_interconnect $sys_cpu_clk sys_ps7/S_AXI_HP1
    ad_mem_hp1_interconnect $sys_cpu_clk axi_ad7606_dma/m_dest_axi
