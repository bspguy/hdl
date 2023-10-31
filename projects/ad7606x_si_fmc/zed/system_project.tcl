###############################################################################
## Copyright (C) 2023 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

source ../../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project_xilinx.tcl
source $ad_hdl_dir/projects/scripts/adi_board.tcl

# Parameter description
# DEV_CONFIG - The device which will be used
#  - Options : AD7606B(0)/C-16(1)/C-18(2)
# NUM_OF_SDI - NUmber of SDI lines used
#  - Options: 1, 2, 4, 8

set DEV_CONFIG [get_env_param DEV_CONFIG 0]
set NUM_OF_SDI [get_env_param NUM_OF_SDI 8]

adi_project ad7606x_si_fmc_zed 0 [list \
  DEV_CONFIG $DEV_CONFIG \
  NUM_OF_SDI $NUM_OF_SDI \
]

adi_project_files ad7606x_si_fmc_zed [list \
  "$ad_hdl_dir/library/common/ad_iobuf.v" \
  "$ad_hdl_dir/projects/common/zed/zed_system_constr.xdc" \
  "system_constr.tcl" \
  "system_top.v"]

adi_project_run ad7606x_si_fmc_zed
