# Call for Tender "Web interface for FPGA simulator" 
Your Task is to develop a web interface for an FPGA Simulator. 
This web interface will be used to teach people how the signals propagate inside an FPGA.

## Glossary
In this project we will be using the following words and associated definition:
- **FPGA**: it is an integrated circuit with basic elements and preconfigured electrical signal routes between them. The selected FPGA is a `Lattice ICE40 HX8K`
- **Basic Element (BEL)**: these are the hardware electrical ressources available inside the FPGA like fliflop, Look-Up-Table (LUT), Block RAM....
- **Application** : in this context it will be the function to be executed in the FPGA (developped in verilog).
-  **Synthesis**: translation of the application into an electrical equivalent. IT create a netlist (which can be exported as a netlist). The tool used will be `Yosys`.
- **P&R**: Place and Route is the packing of the netlist component in the FPGA available BEL (Place). Then a route for signals between each BEL is selected (Route). The tool used will be `nextpnr-ice40` . A timing netlist is created and can be exported in verilog. The tool used will be `icetime`
- **Simulator**: It compiles verilog testbenches and application and execute the simulation of every signal with regard to time evolution. The tool used will be `verilator`
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
    - The teacher will load the server with several application examples and associated verilog testbench.
    - The student will use the web interface to select the preloaded application examples

### 2. User Interface for the Webpage (student use)
- It includes a 2D view of used BEL inside the FPGA, the routes used by each signals.
- Student can navigate (zoom, move) inside the 2D view.
- Student can select one of the preloaded application examples.
- It implements a play button to run the application (thus see how every signals proppagate in the FPGA) at a different reducing factors speed (x1, x2, x4...)
- It implements a pause/resume button.

### 3. Interface for the backend side (teacher use)
- Teacher will provide verilog application and a verilog tesbench. The backend will create the necessary data to be loaded by the webserver for the webpage.

## Expected Deliverables
- source code on a GIT repository
- How-To explaining how to run the software
- How-To explaining how to add an application example
- At minimum two application examples, one for the flipflop and an other for the LUT4.

-------------------------------------------------

# Proof Of Concept
The example below illustrate tools used to FPGA Simulation and display. It can be used for information or as input for the project.

## Prerequisite
- linux machine (tested on ubuntu)

## Installation
- Download latest impulse design suite 24.3.3.0 from `https://files.nanoxplore.com/f/5f05b9415c604a6ca7e2/?dl=1`
- Extract it for example in folder `/opt/NanoXplore/Impulse/nxdesignsuite-24.3.0.0/`
- Download and install modelsim simulator `https://www.intel.com/content/www/us/en/software-kit/790078/questa-intel-fpgas-pro-edition-software-version-23-3.html`

optional:
- Download latest osscad suite latest release : https://github.com/YosysHQ/oss-cad-suite-build/releases
- Extract it for example in folder `/opt/osccad`


## Getting started proprietary flow
This development flow is similar as the one used by industrial companies

1. Execute `scripts/1.LaunchImpulse.sh`. This will execute synthesis, place and route and export a verilog netlist.
    - You can launch impulse to have a view of the FPGA `/opt/NanoXplore/Impulse/nxdesignsuite-24.3.0.0/bin/impulse`
    - open the `Project/Impulse_POC_route.nym` project
    - click on the left on the `floorplan` icon
    - click on the command `none` button on the top and select `net` or `instance`
    - click on th fpga matrx to view the requested feature
2. launch simulation 

## Getting started opensource flow

### installation
you will have to compile nextpnr with ngultra support.
1. clone repositories : https://github.com/YosysHQ/nextpnr.git and https://github.com/YosysHQ-GmbH/prjbeyond-db.git
 Becareful there are submodules so use `--recurse-submodules` option
2. install prerequisite from https://github.com/YosysHQ/nextpnr?tab=readme-ov-file#prerequisites
3. execute commands from https://github.com/YosysHQ/nextpnr?tab=readme-ov-file#ng-ultra


### Troubleshooting:
- if cmake is to old on you ubuntu remove it from apt and isntall the version from pip
        - apt remove cmake -y
        - pip install cmake --upgrade
        - create a link from you python cmake to usr/bin/ `sudo ln -s /home/flo/.local/bin/cmake /usr/bin/`
        - pip install pybind11

### simulation
This flow is the same as the proprietary one but more complex and some features might be missing.

2. execute `scripts/1.synthesis/LaunchYosys.sh` to perform synthesis
3. execute `scripts/2.PR/LaunchNextpnr.sh` to perform P&R 
4. execute `scripts/2.PR/LaunchIcetime.sh` to perform creation of the timing netlist
5. execute `scripts/3.Simulation/LaunchSimulation.sh` to perform time simulation
6. execute `scripts/3.Simulation/LaunchGtkwave.sh` to display simulation


# Worth looking at ...
- python API for Nanoxplore Impulse : https://files.nanoxplore.com/f/263e38b58862428ebef9/?dl=1
- nanoxplore wiki :https://nanoxplore-wiki.atlassian.net/wiki/
- osscad project : https://github.com/YosysHQ/oss-cad-suite-build : it includes:
    - open source synthetiser: yosys
    - open source place & route : nextpnr
    - open source simulator for verilog : icarus verilog
    - open source simulator for vhdl : ghdl
    - open source wave display (for simulators): gtkwave
-