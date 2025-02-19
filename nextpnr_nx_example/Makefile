all: bitstream.nxb

netlist.json: top.v
	yosys -p 'read_verilog top.v; synth_nanoxplore -top top -json netlist.json'

bitstream.json: netlist.json ios.csv
	/usr/local/bin/nextpnr-himbaechel --device NG-ULTRA --json netlist.json --router router2 --vopt bit=bitstream.json --vopt csv=ios.csv --gui

bitstream.nxb: bitstream.json
	nxpython import.py bitstream.json bitstream.nxb bitstream.v

clean:
	rm -rf *.json *.nxb yosys_synth.v bitstream.v

.PHONY: yosys
