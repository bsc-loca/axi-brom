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


set g_ip_version_min 2 
set g_ip_version_maj 0
set g_ip_version ${g_ip_version_maj}.${g_ip_version_min}

set ip_properties [ list \
    vendor "meep-project.eu" \
    library "MEEP" \
    name ${g_design_name} \
    version "$g_ip_version" \
    taxonomy "/MEEP_IP" \
    display_name "MEEP ${g_design_name}" \
    description "BRAM that can be used as ROM" \
    vendor_display_name "MEEP Project" \
    company_url "https://meep-project.eu/" \
    ]

set family_lifecycle { \
  virtexuplusHBM Production \
}



# Package project and set properties
ipx::package_project
set ip_core [ipx::current_core]
set_property -dict ${ip_properties} ${ip_core}
# set_property SUPPORTED_FAMILIES ${family_lifecycle} ${ip_core}

ipx::add_bus_interface bram [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:bram_rtl:1.0 [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:bram:1.0 [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]
ipx::add_port_map DIN [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]
set_property physical_name dina [ipx::get_port_maps DIN -of_objects [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]]
ipx::add_port_map EN [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]
set_property physical_name ena [ipx::get_port_maps EN -of_objects [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]]
ipx::add_port_map DOUT [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]
set_property physical_name douta [ipx::get_port_maps DOUT -of_objects [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]]
ipx::add_port_map CLK [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]
set_property physical_name clka [ipx::get_port_maps CLK -of_objects [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]]
ipx::add_port_map WE [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]
set_property physical_name wea [ipx::get_port_maps WE -of_objects [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]]
ipx::add_port_map ADDR [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]
set_property physical_name addra [ipx::get_port_maps ADDR -of_objects [ipx::get_bus_interfaces bram -of_objects [ipx::current_core]]]


# Save IP and close project
ipx::check_integrity ${ip_core}
ipx::save_core ${ip_core}

puts "IP succesfully packaged "	

