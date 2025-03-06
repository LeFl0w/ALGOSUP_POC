# How to use SDC file
This file exaplin how to handle SDC file. It is based on example `Examples/1ff_no_rst_VTR`

## Graphical view
when you display the post place and route netlist `Examples/1ff_no_rst_VTR/FF1_norst_post_synthesis.v` as graphical , you'll get this architecture:


![Schematic view of example post place and route](./assets/shematic.png)

There are new elements calls fpga interconnect which were added. They are virtual element created in order to collect wire delay timing from SDC. These elements are not physically real. They should not be displayed on the final graphic.

![Schematic view of example](./assets/real example.png)