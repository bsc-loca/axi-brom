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
	set g_fpga_part "xc${g_board_part}-fsvh2892-2L-e"

}


################################################################
# START
################################################################
set root_dir $g_root_dir

set projec_dir $root_dir/project

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
