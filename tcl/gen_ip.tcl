source [pwd]/tcl/environment.tcl


set ip_properties [ list \
    vendor "meep-project.eu" \
    library "MEEP" \
    name ${g_design_name} \
    version "$g_ip_version" \
    taxonomy "/MEEP_IP" \
    display_name "MEEP ${g_design_name}" \
    description "Initialize a BRAM to be used as ROM" \
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
set_property SUPPORTED_FAMILIES ${family_lifecycle} ${ip_core}

 ipx::add_bus_parameter ID_WIDTH [ipx::get_bus_interfaces S_AXI -of_objects [ipx::current_core]]    
 ipx::add_bus_parameter AWUSER_WIDTH [ipx::get_bus_interfaces S_AXI -of_objects [ipx::current_core]]
 ipx::add_bus_parameter ARUSER_WIDTH [ipx::get_bus_interfaces S_AXI -of_objects [ipx::current_core]]
 ipx::add_bus_parameter WUSER_WIDTH [ipx::get_bus_interfaces S_AXI -of_objects [ipx::current_core]] 
 ipx::add_bus_parameter BUSER_WIDTH [ipx::get_bus_interfaces S_AXI -of_objects [ipx::current_core]] 
 ipx::add_bus_parameter RUSER_WIDTH [ipx::get_bus_interfaces S_AXI -of_objects [ipx::current_core]] 
# Associate AXI/AXIS interfaces and reset with clock
set aclk_intf [ipx::get_bus_interfaces ACLK -of_objects ${ip_core}]
set aclk_assoc_intf [ipx::add_bus_parameter ASSOCIATED_BUSIF $aclk_intf]
set_property value M_AXIS:S_AXIS:S_AXI $aclk_assoc_intf
set aclk_assoc_reset [ipx::add_bus_parameter ASSOCIATED_RESET $aclk_intf]
set_property value ARESETN $aclk_assoc_reset
ipx::add_bus_parameter FREQ_HZ [ipx::get_bus_interfaces ACLK -of_objects [ipx::current_core]]

# Set reset polarity
set aresetn_intf [ipx::get_bus_interfaces ARESETN -of_objects ${ip_core}]
set aresetn_polarity [ipx::add_bus_parameter POLARITY $aresetn_intf]
set_property value ACTIVE_LOW ${aresetn_polarity}

# Save IP and close project
ipx::check_integrity ${ip_core}
ipx::save_core ${ip_core}

puts "IP succesfully packaged "	

