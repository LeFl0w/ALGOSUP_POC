# Proof Of Concept
The example below illustrate tools used to FPGA Simulation and display. It can be used for information or as input for the project.

## Prerequisite
- linux machine (tested on ubuntu)

## Getting started proprietary flow (Nanoxplore)

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

## Getting started opensource flow VTR ( preferred as it handles the full flow,  up to timing simulation))
This additionnal open source flow seems to handle timing delays.

### Install
- clone repository with submodule vith the Tag v9.0.0
- run the procedure located at https://github.com/verilog-to-routing/vtr-verilog-to-routing/blob/master/BUILDING.md (you will probably need to use python venv in order to resolve depency failure with system python)
- add synthetizer parmys to the build by executing `make CMAKE_PARAMS="-DWITH_PARMYS=ON`
- finish the procedure with command `make install`
- add the associated `vtr-verilog-to-routing/build/bin/` folder to your path

### Running
- Edit path for VTR binaries in `scripts_vtr/runme.sh` and launch it.
- Launch scripts_vtr/2.LaunchSimulation.sh (it needs modelsim installation)
- **To be done : provide a script for simulation with icarus verilog and gtkwave **

Nota there is a gui available for VPR using `--disp on` option when running `vpr`


## Getting started opensource flow nextpnr (informational as timing netlist creation will finish with Nanoxplore impulse)
In this flow you will use:
- yosys for synthesis
- Nextpnr for place androute and floorplanning display
- for timing simulation there is no opensource way for now. The flow would be to import into Impulse the output of the nextpnr P&R.

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

### Running
- edit`design_flows_examples/nextpnr_nx/Makefile` to fill you binaries path
- execute `make clean all` command in the folder `design_flows_examples/nextpnr_nx_example`
  this will synthesis with yosys, P&R with nextpnr and create a timing model with NAnaoxplore Impulse
- execute `design_flows_examples/nextpnr_nx/2.LaunchSimulation.sh` in folder `design_flows_examples/nextpnr_nx_example` to perform simulation


