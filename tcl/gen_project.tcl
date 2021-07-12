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
################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
    puts ""
    catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

    return 1
}

################################################################
# START
################################################################
set root_dir [ pwd ]

set g_project_name $g_project_name
set projec_dir $root_dir/project

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
    create_project $g_project_name $projec_dir -force -part xcu280-fsvh2892-2L-e
}
# Set project properties
set obj [current_project]
set_property -name "board_part" -value "xilinx.com:au280:part0:1.1" -objects $obj

# CHANGE DESIGN NAME HERE
variable design_name
set design_name $g_project_name
set ip_dir_list [list \
     $root_dir/ip]
	
set_property  ip_repo_paths  $ip_dir_list [current_project]
if { $g_useBlockDesign eq "Y" } {
create_bd_design -dir $root_dir/bd ${design_name}
update_ip_catalog -rebuild
source ${root_dir}/tcl/gen_bd.tcl
create_root_design ""
validate_bd_design
save_bd_design
}
####################################################
# MAIN FLOW
####################################################
set g_top_name axi_brom_top

set top_module "$root_dir/src/${g_top_name}.vhd"
set src_files [glob ${root_dir}/src/*]
set ip_files [glob -nocomplain ${root_dir}/ip/*/*.xci]
add_files ${src_files}
add_files -quiet ${ip_files}
set_property target_language VHDL [current_project]
puts "Project generation ended successfully"
source $root_dir/tcl/project_options.tcl
source $root_dir/tcl/gen_ip.tcl
