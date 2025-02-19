# Call for Tender "Web interface for FPGA simulator" 
Your Task is to develop a web interface for an FPGA Simulator. 
This web interface will be used to teach people how the signals propagate inside an FPGA.

## Glossary
In this project we will be using the following words and associated definition:
- **FPGA**: it is an integrated circuit with basic elements and preconfigured electrical signal routes between them. The selected FPGA is a `NAnoXplore NGultra`
- **Basic Element (BEL)**: these are the hardware electrical ressources available inside the FPGA like fliflop, Look-Up-Table (LUT), Block RAM....
- **Application** : in this context it will be the function to be executed in the FPGA (developped in verilog).
-  **Synthesis**: translation of the application into an electrical equivalent. IT create a netlist (which can be exported as a netlist). The tool used will be `Impulse` 
- **P&R**: Place and Route is the packing of the netlist component in the FPGA available BEL (Place). Then a route for signals between each BEL is selected (Route). The tool used will be `Impulse` . A timing netlist is created and can be exported in verilog. The tool used will be `Impulse`
- **Simulator**: It compiles verilog testbenches and application and execute the simulation of every signal with regard to time evolution. The tool used will be `Modelsim`
- **Sofware**: It is the developped web application int he frame of this call for tender.

## Context
When using an FPGA, designers can access the resulting layout of a given described application (in verilog) after synthesis and P&R. It is basically a 2D representation of the FPGA and the routes taken by the electrical signals between each BEL used by the application.

To check the good behavior of the application, FPGA designer use a timing simulator which simulate the propogation of the signal at a given location in the FPGA. To do so the deisgner use a testbench (writen in verilog) and a timing netlist (it is a verilog representation of the application with signal time propagation included).

The aim of this project is to merge the two views : 2D floorplan with associated propogation of the signals with regard to the time.

## Core requirements
### 1. Programming language
- The sofware must be accessible trough a web interface. The software technology used to develop the application is open.

### 2. Application utilization
- We identify two role for this application: the teacher and the student
    - The teacher will load the server with several application examples and associated verilog testbench. This is called the backend.
    - The student will use a web interface to select the preloaded application examples. 

### 2. User Interface for the Webpage (student use)
- It includes a 2D view of used BEL inside the FPGA, the routes used by each signals.
- Student can navigate (zoom, move) inside the 2D view.
- Student can select one of the preloaded application examples.
- It implements a play button to run the application (thus see how every signals proppagate in the FPGA) at a different reducing factors speed (x1, x2, x4...)
- It implements a pause/resume button.

### 3. Interface for the backend side (teacher use)
- Teacher will provide verilog application and a verilog tesbench. The backend will create the necessary data to be loaded by the webserver for the webpage.

## Expected Deliverables
- Source code on a GIT repository
- How-To explaining how to run the software
- How-To explaining how to add an application example
- At minimum two application examples, one for the flipflop and an other for the LUT4.

-------------------------------------------------

# Proof Of Concept
The example below illustrate tools used to FPGA Simulation and display. It can be used for information or as input for the project.

## Prerequisite
- linux machine (tested on ubuntu)

## Getting started proprietary flow

### Install
- Download latest impulse design suite 24.3.3.0 from `https://files.nanoxplore.com/f/5f05b9415c604a6ca7e2/?dl=1`
- Extract it for example in folder `/opt/NanoXplore/Impulse/nxdesignsuite-24.3.0.0/`
- Download and install modelsim simulator `https://www.intel.com/content/www/us/en/software-kit/790078/questa-intel-fpgas-pro-edition-software-version-23-3.html`
- Download nanoxplore licence manager `https://files.nanoxplore.com/f/a342e814bad24a61807f/?dl=1`
- Extract it for example in folder `/opt/NanoXplore/NXLMD`
- Ask nanoxplore for a licence by email at `support@nanoxplore.com` mentionning :
    - the name of the project `AlgoSUP` 
    - your hostname extracted with command `hostname`
    - your hostID extracted with command ` /opt/NanoXplore/NXLMD/2.2/bin/lmhostid`
- launch license server with command  `/opt/NanoXplore/NXLMD-2.2-linux/NXLMD/2.2/bin/x86_64_UBUNTU_18/lmgrd -c /opt/NanoXplore/licence.lic > ~/.log_server_nx.log` 
- add `export NXLMD_LICENSE_FILE="27000@localhost"` to your environment
- try launching Nanoxplore Impulse software : `/opt/NanoXplore/Impulse/nxdesignsuite-24.3.0.0/bin/impulse` 

You can consult https://nanoxplore-wiki.atlassian.net/wiki/spaces/NAN/pages/47710209/License+Daemon for additional informations


This development flow is similar as the one used by industrial companies

1. Execute `scripts/1.LaunchImpulse.sh`. This will execute synthesis, place and route and export a verilog netlist.
    - You can launch impulse to have a view of the FPGA `/opt/NanoXplore/Impulse/nxdesignsuite-24.3.0.0/bin/impulse`
    - open the `Project/Impulse_POC_route.nym` project
    - click on the left on the `floorplan` icon
    - click on the command `none` button on the top and select `net` or `instance`
    - click on th fpga matrx to view the requested feature
2. launch simulation 
    - you can view it on modelsim or on gtkwave using command `gtkwave ./Sim/data.vcd`

## Getting started opensource flow (nextpnr)
In this flow you will use:
- yosys for synthesis
- Nextpnr for place androute and floorplanning display
- for timing simulation there is no opensource way for now. the flow would be to import into Impulse the output of the nextpnr P&R. For now it is not certain it is feasible.

A more detailed example is aviable in branch ice40.

### Install
you will have to compile nextpnr with ngultra support.
1. clone repositories : https://github.com/YosysHQ/nextpnr.git and https://github.com/YosysHQ-GmbH/prjbeyond-db.git
 Becareful there are submodules so use `--recurse-submodules` option
2. install prerequisite from https://github.com/YosysHQ/nextpnr?tab=readme-ov-file#prerequisites
3. execute commands from https://github.com/YosysHQ/nextpnr?tab=readme-ov-file#ng-ultra 
    - change the cmake command by adding `-DBUILD_GUI=ON` at the end

- Download latest osscad suite latest release : https://github.com/YosysHQ/oss-cad-suite-build/releases (to get yosys synthetiser)
- Extract it for example in folder `/opt/osccad`

Be careful osscad comes with its own version of `nextpnr-himbaechel` be sure to use your compiled version `/usr/local/bin/nextpnr-himbaechel`

### Troubleshooting:
- if cmake is to old on you ubuntu remove it from apt and install the version from pip
        - apt remove cmake -y
        - pip install cmake --upgrade
        - create a link from you python cmake to usr/bin/ `sudo ln -s /home/flo/.local/bin/cmake /usr/bin/`
        - pip install pybind11
- if qt5 is missing install it with `sudo apt-get install qtbase5-dev`

### simulation
For now this opensource flow doesn't seem to run post place and route timing simulation as the timing database for FPGA cells are not available unencrypted.

### Running
- execute `make` command in the folder `nextpnr_nx_example`

## Getting started opensource flow (VTR)
This additionnal open source flow seems to handle timing delays.

### Install
- clone repository with submodule vith the Tag v9.0.0
- run the procedure located at https://github.com/verilog-to-routing/vtr-verilog-to-routing/blob/master/BUILDING.md (you will probably need to use python venv in order to resolve depency failure with system python)
- add synthetizer parmys to the build by executing `make CMAKE_PARAMS="-DWITH_PARMYS=ON`
- finish the procedure with command `make install`
- add the associated `vtr-verilog-to-routing/build/bin/` folder to your path

### Running
- 

Nota there is a gui available also using `--disp on` option when running `vpr`


# Worth looking at ...
- python API for Nanoxplore Impulse : https://files.nanoxplore.com/f/263e38b58862428ebef9/?dl=1
- nanoxplore wiki :https://nanoxplore-wiki.atlassian.net/wiki/
- osscad project : https://github.com/YosysHQ/oss-cad-suite-build : it includes:
    - open source synthetiser: yosys
    - open source place & route : nextpnr
    - open source simulator for verilog : icarus verilog
    - open source simulator for vhdl : ghdl
    - open source wave display (for simulators): gtkwave
- yowasp : https://yowasp.org/ : webassembly package for yosys, nextpnr....

- python-sdf-timing library: library to manage sdf file for timing annotation of verilog: https://github.com/chipsalliance/f4pga-sdf-timing
- Verilog to routing: opensource FPGA framework similar to yosys and nextpnr : https://github.com/verilog-to-routing/vtr-verilog-to-routing