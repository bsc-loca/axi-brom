# Copyright 2022 Barcelona Supercomputing Center-Centro Nacional de Supercomputación

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Author: Daniel J.Mazure , BSC-CNS
# Date: 22.02.2022
# Description: 


namespace eval _tcl {
proc get_script_folder {} {
    set script_path [file normalize [info script]]
    set script_folder [file dirname $script_path]
    return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]


puts "The environment tcl will be sourced from ${script_folder}"
source $script_folder/environment.tcl

# Redefine the FPGA part in case the script is called with arguments
# It defaults to u280
if { $::argc > 0 } {

	set g_board_part [lindex $argv 0]
    set g_ip_target  [lindex $argv 1]
	set g_fpga_part "xc${g_board_part}-fsvh2892-2L-e"
    if { $g_board_part == "u250" } {
      set g_fpga_part xcu250-figd2104-2L-e
    }

}

set root_dir $g_root_dir
set g_project_name $g_project_name
set projec_dir $root_dir/${g_ip_target}

################################################################
# START
################################################################

# Clean previous project
file delete -force $projec_dir

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
    create_project $g_project_name $projec_dir -force -part $g_fpga_part 
}
# Set project properties

# CHANGE DESIGN NAME HERE
variable design_name
set design_name $g_project_name
set ip_dir_list [list \
     $root_dir/ip]
	
####################################################
# MAIN FLOW
####################################################

#set top_module "$root_dir/src/${g_top_name}.vhd"

set src_files [glob ${root_dir}/src/*]
#set ip_files [glob -nocomplain ${root_dir}/ip/*/*.xci]

add_files ${src_files}
#add_files -quiet ${ip_files}

#source $root_dir/tcl/project_options.tcl
source $root_dir/tcl/gen_ip.tcl


puts "Project generation ended successfully"

