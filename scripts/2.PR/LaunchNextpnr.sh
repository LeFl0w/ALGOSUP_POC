
#Place and route FPGA
nextpnr-ice40 --hx8k --json design.json --pcf src/pinmap.pcf --asc output.asc --package ct256 

#you can use the commmand below to access GUI .
# you will have to click on Pack icon then Palce icon and finally Place icon to perform P&R manually
#nextpnr-ice40 --hx8k --json design.json --pcf src/pinmap.pcf --asc output.asc --package ct256 --gui