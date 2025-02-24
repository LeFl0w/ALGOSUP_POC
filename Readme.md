# Call for Tender "Web interface for FPGA simulator" 
Your Task is to develop a web interface for an FPGA Simulator. 
This web interface will be used to teach people how the signals propagate inside an FPGA.

## Glossary
In this project we will be using the following words and associated definition:
- **FPGA**: it is an integrated circuit with basic elements and preconfigured electrical signal routes between them. The selected FPGA is a `NanoXplore NGultra` (with VTR flow a basic `Xilinx serie 7` model will be used )
- **Basic Element (BEL)**: these are the hardware electrical ressources available inside the FPGA like fliflop, Look-Up-Table (LUT), Block RAM....
- **Application** : in this context it will be the function to be executed in the FPGA (developped in verilog).
-  **Synthesis**: translation of the application into an electrical equivalent. It creates a netlist (which can be exported as a netlist). The tool used will be `Impulse` (or `yosys` in vtr flow )
- **P&R**: Place and Route is the packing of the netlist component in the FPGA available BEL (Place). Then a route for signals between each BEL is selected (Route). The tool used will be `Impulse` . A timing netlist is created and can be exported in verilog. The tool used will be `Impulse`  (or `VPR` for place and route in vtr flow )
- **Simulator**: It compiles verilog testbenches and application and execute the simulation of every signal with regard to time evolution. The tool used will be `Modelsim` (using `icarus verilog` was not achieved yet for VTR flow)
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

For graphical display you will need two inputs :
- a netlist schematic (in verilog format)
- a standard delay file (SDF format)

The `Example` folder will collect examples of such files. These files have been created with the VTR flow explained in `FPGA_Toolchain.md`


-------------------------------------------------
# Worth looking at ...
- https://digitaljs.tilk.eu/ : a project for simulate synthetized design in a webpage
- Verilog to routing: opensource FPGA framework for place and route FPGA (it use yosys as simualtor) : https://github.com/verilog-to-routing/vtr-verilog-to-routing
- osscad project : https://github.com/YosysHQ/oss-cad-suite-build : it includes:
    - open source synthetiser: yosys
    - open source place & route : nextpnr
    - open source simulator for verilog : icarus verilog
    - open source simulator for vhdl : ghdl
    - open source wave display (for simulators): gtkwave
- yowasp : https://yowasp.org/ : webassembly package for yosys, nextpnr....
- python-sdf-timing library: library to manage sdf file for timing annotation of verilog: https://github.com/chipsalliance/f4pga-sdf-timing
