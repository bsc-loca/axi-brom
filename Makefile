ROOT_DIR  = $(PWD)
VIVADO_VER  := 2021.2
VIVADO_PATH := /opt/Xilinx/Vivado/$(VIVADO_VER)/bin/
VIVADO_XLNX := $(VIVADO_PATH)/vivado
VIVADO_OPT  := -mode batch -nolog -nojournal -notrace -source
FPGA_BOARD  ?= u55c
IP_NAME     := native_bram


IPMODE = native_bram meep_rom

all: meep_rom

#Generate the Ethernet IP

$(IPMODE): 
	@(echo "Package a Native BRAM IP for the Alveo $(FPGA_BOARD)")
	$(VIVADO_XLNX) $(VIVADO_OPT)  ./tcl/gen_project.tcl -tclargs $(FPGA_BOARD) $@
	@(echo "IP created under folder $@") ;\


clean:
	git clean -fxd
	rm -rf xgui project native*



