open_project ZynqDesign.xpr 
open_bd_design ZynqDesign.srcs/sources_1/bd/Z_system/Z_system.bd
get_bd_intf_ports 
create_bd_port -dir O -type rst Reset
delete_bd_objs [get_bd_ports Reset]
validate_bd_design 
write_bd_tcl basic_design.tcl
write_project_tcl project_setup.tcl 
mv project_setup.tcl ./..
source project_setup.tcl
open_bd_design Z_system.bd 
get_bd_intf_ports 
close_bd_design [get_bd_designs Z_system.bd]
remove_files Z_system.bd 
source basic_design.tcl 

