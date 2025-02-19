#adapted from https://docs.verilogtorouting.org/en/latest/tutorials/timing_simulation/#generating-the-post-implementation-netlist

#generate post synth timing netlist with VTR
vpr ./k6_frac_N10_40nm.xml multiclock.blif --gen_post_synthesis_netlist on
