#nanoxplore binary folder
export NX_BIN_PATH:=/opt/NanoXplore/Impulse/nxdesignsuite-24.3.0.0/bin
#yosys binary folder
export YOSYS_BIN_PATH:=/opt/osscad/oss-cad-suite-linux-x64-20250212/oss-cad-suite/bin
#nextpnr ngultra path
export NEXT_BIN_PATH:=/usr/local/bin



#add nanoxplore binaries in PATH
export PATH := $(NX_BIN_PATH):$(YOSYS_BIN_PATH):$(PATH)

all: bitstream.nxb

netlist.json: ../../src/flipflop.v
	yosys -p 'read_verilog ../../src/flipflop.v; synth_nanoxplore -top RisingEdge_DFlipFlop_AsyncResetHigh -json netlist.json'

bitstream.json: netlist.json ios.csv
	$(NEXT_BIN_PATH)/nextpnr-himbaechel --device NG-ULTRA --json netlist.json --router router2 --vopt bit=bitstream.json --vopt csv=ios.csv 
#you can add this option for gui display (be careful it is CPU consuming) --gui

bitstream.nxb: bitstream.json
	nxpython import.py bitstream.json bitstream.nxb bitstream.v

clean:
	rm -rf *.json *.nxb yosys_synth.v bitstream.v

.PHONY: yosys
