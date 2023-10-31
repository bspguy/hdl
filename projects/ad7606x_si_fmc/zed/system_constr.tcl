###############################################################################
## Copyright (C) 2023 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# ad7606x

    if {![info exists NUM_OF_SDI]} {
      set NUM_OF_SDI $::env(NUM_OF_SDI)
    }
    
    switch $NUM_OF_SDI {
      1 {
        set_property -dict {PACKAGE_PIN M20     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[0]]  ; ## G7   FMC_LA00_CC_N  IO_L13N_T2_MRCC_34
      }
      2 {
        set_property -dict {PACKAGE_PIN M20     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[0]]  ; ## G7   FMC_LA00_CC_N  IO_L13N_T2_MRCC_34
        set_property -dict {PACKAGE_PIN L22     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[1]]  ; ## C11  FMC_LA06_N     IO_L10N_T1_34
      }
      4 {
        set_property -dict {PACKAGE_PIN M20     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[0]]  ; ## G7   FMC_LA00_CC_N  IO_L13N_T2_MRCC_34
        set_property -dict {PACKAGE_PIN L22     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[1]]  ; ## C11  FMC_LA06_N     IO_L10N_T1_34
        set_property -dict {PACKAGE_PIN J18     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[2]]  ; ## D11  FMC_LA05_P     IO_L7P_T1_34
        set_property -dict {PACKAGE_PIN R20     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[3]]  ; ## D14  FMC_LA09_P     IO_L17P_T2_34
      }
      8 {
        set_property -dict {PACKAGE_PIN M20     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[0]]  ; ## G7   FMC_LA00_CC_N  IO_L13N_T2_MRCC_34
        set_property -dict {PACKAGE_PIN L22     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[1]]  ; ## C11  FMC_LA06_N     IO_L10N_T1_34
        set_property -dict {PACKAGE_PIN J18     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[2]]  ; ## D11  FMC_LA05_P     IO_L7P_T1_34
        set_property -dict {PACKAGE_PIN R20     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[3]]  ; ## D14  FMC_LA09_P     IO_L17P_T2_34
        set_property -dict {PACKAGE_PIN P22     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[4]]  ; ## G10  FMC_LA03_N     IO_L16N_T2_34
        set_property -dict {PACKAGE_PIN M22     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[5]]  ; ## H11  FMC_LA04_N     IO_L15N_T2_DQS_34
        set_property -dict {PACKAGE_PIN T17     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[6]]  ; ## H14  FMC_LA07_N     IO_L21N_T3_DQS_34
        set_property -dict {PACKAGE_PIN J22     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdi[7]]  ; ## G13  FMC_LA08_N     IO_L8N_T1_34
      }
    }
    
    set_property -dict {PACKAGE_PIN M19     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sclk]    ; ## G6   FMC_LA00_CC_P  IO_L13P_T2_MRCC_34
    set_property -dict {PACKAGE_PIN N22     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_sdo]     ; ## G9   FMC_LA03_P     IO_L16P_T2_34
    set_property -dict {PACKAGE_PIN M21     IOSTANDARD LVCMOS25} [get_ports ad7606_spi_cs]      ; ## H10  FMC_LA04_P     IO_L15P_T2_DQS_34
    set_property -dict {PACKAGE_PIN K18     IOSTANDARD LVCMOS25} [get_ports adc_cnvst_n]        ; ## D12  FMC_LA05_N     IO_L7N_T1_34

# control lines
set_property -dict {PACKAGE_PIN K19     IOSTANDARD LVCMOS25} [get_ports adc_serpar]         ; ## C18  FMC_LA14_P     IO_L11P_T1_SRCC_34
set_property -dict {PACKAGE_PIN T16     IOSTANDARD LVCMOS25} [get_ports adc_busy]           ; ## H13  FMC_LA07_P     IO_L21P_T3_DQS_34
set_property -dict {PACKAGE_PIN J21     IOSTANDARD LVCMOS25} [get_ports adc_first_data]     ; ## G12  FMC_LA08_P     IO_L8P_T1_34
set_property -dict {PACKAGE_PIN L21     IOSTANDARD LVCMOS25} [get_ports adc_reset]          ; ## C10  FMC_LA06_P     IO_L10P_T1_34
set_property -dict {PACKAGE_PIN P20     IOSTANDARD LVCMOS25} [get_ports adc_os[0]]          ; ## G15  FMC_LA12_P     IO_L18P_T2_34
set_property -dict {PACKAGE_PIN P17     IOSTANDARD LVCMOS25} [get_ports adc_os[1]]          ; ## H7   FMC_LA02_P     IO_L20P_T3_34
set_property -dict {PACKAGE_PIN N17     IOSTANDARD LVCMOS25} [get_ports adc_os[2]]          ; ## H16  FMC_LA11_P     IO_L5P_T0_34
set_property -dict {PACKAGE_PIN T19     IOSTANDARD LVCMOS25} [get_ports adc_stby]           ; ## C15  FMC_LA10_N     IO_L22N_T3_34
set_property -dict {PACKAGE_PIN R21     IOSTANDARD LVCMOS25} [get_ports adc_range]          ; ## D15  FMC_LA09_N     IO_L17N_T2_34
