
source ../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project_xilinx.tcl
source $ad_hdl_dir/projects/scripts/adi_board.tcl

# get_env_param retrieves parameter value from the environment if exists,
# other case use the default value
#
#   Use over-writable parameters from the environment.
#
#    e.g.
#      make RX_JESD_L=4 RX_JESD_M=8 RX_JESD_S=1 TX_JESD_L=4 TX_JESD_M=8 TX_JESD_S=1
#      make RX_JESD_L=8 RX_JESD_M=4 RX_JESD_S=1 TX_JESD_L=8 TX_JESD_M=4 TX_JESD_S=1

#
# Parameter description:
#   JESD_MODE : Used link layer encoder mode
#      64B66B - 64b66b link layer defined in JESD 204C, uses Xilinx IP as Physical layer
#      8B10B  - 8b10b link layer defined in JESD 204B, uses ADI IP as Physical layer
#
#   RX_RATE :  Line rate of the Rx link ( MxFE to FPGA )
#   TX_RATE :  Line rate of the Tx link ( FPGA to MxFE )
#   [RX/TX]_JESD_M : Number of converters per link
#   [RX/TX]_JESD_L : Number of lanes per link
#   [RX/TX]_JESD_NP : Number of bits per sample, only 16 is supported
#   [RX/TX]_NUM_LINKS : Number of links, matches numer of MxFE devices
#
#

#      make JESD_MODE=64B66B RX_RATE=24.75 TX_RATE=24.75 RX_JESD_M=4 RX_JESD_L=4 RX_JESD_S=2 RX_JESD_NP=12 TX_JESD_M=4 TX_JESD_L=4 TX_JESD_S=2 TX_JESD_NP=12

adi_project ad9081_fmca_ebz_vck190 0 [list \
  JESD_MODE    [get_env_param JESD_MODE    64B66B ]\
  RX_LANE_RATE [get_env_param RX_RATE      24.75 ] \
  TX_LANE_RATE [get_env_param TX_RATE      24.75 ] \
  RX_JESD_M    [get_env_param RX_JESD_M    4 ] \
  RX_JESD_L    [get_env_param RX_JESD_L    4 ] \
  RX_JESD_S    [get_env_param RX_JESD_S    2 ] \
  RX_JESD_NP   [get_env_param RX_JESD_NP   12] \
  RX_NUM_LINKS [get_env_param RX_NUM_LINKS 1 ] \
  TX_JESD_M    [get_env_param TX_JESD_M    4 ] \
  TX_JESD_L    [get_env_param TX_JESD_L    4 ] \
  TX_JESD_S    [get_env_param TX_JESD_S    2 ] \
  TX_JESD_NP   [get_env_param TX_JESD_NP   12] \
  TX_NUM_LINKS [get_env_param TX_NUM_LINKS 1 ] \
]

adi_project_files ad9081_fmca_ebz_vck190 [list \
  "system_top.v" \
  "system_constr.xdc"\
  "timing_constr.xdc"\
  "../../../library/common/ad_3w_spi.v"\
  "$ad_hdl_dir/library/common/ad_iobuf.v" \
  "$ad_hdl_dir/projects/common/vck190/vck190_system_constr.xdc" ]

set_property strategy Performance_Explore [get_runs impl_1]

add_files -fileset utils_1 -norecurse drc.tcl
set_property STEPS.PLACE_DESIGN.TCL.PRE [ get_files drc.tcl -of [get_fileset utils_1] ] [get_runs impl_1]
set_property STEPS.WRITE_DEVICE_IMAGE.TCL.PRE [ get_files drc.tcl -of [get_fileset utils_1] ] [get_runs impl_1]

adi_project_run ad9081_fmca_ebz_vck190

