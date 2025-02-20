
import sys
import traceback
from nxpython import *
createProject("./Project/POC")
getProject().setVariantName("NG-ULTRA")
getProject().addFiles("work", ["../../src/flipflop.v"])
getProject().setTopCellName("RisingEdge_DFlipFlop_AsyncResetHigh")
getProject().setOption('Autosave','Yes')

####Timing constraints
getProject().setTimingUnit('ns')
#main input clock 25MHz ii sokay     
getProject().createClock(name = "clk", period = 40.000, target = "getPort(clk)")
getProject().developCKGs()


#save native Impulse project
getProject().save('../Impulse_POC_native.nym')

getProject().synthesize()
#save post synth Impulse project
getProject().save('../Impulse_POC_synth.nym')

#For illustration purpose of large timing put the flip flop at to edges of the FPGA
getProject().setSite('Q2_reg','TILE[1x2]')
getProject().setSite('Q3_reg','TILE[92x48]')


getProject().place()
#save post place Impulse project
getProject().save('../Impulse_POC_place.nym')


getProject().route()
#save post route Impulse project
getProject().save('../Impulse_POC_route.nym')

#export verilog post place & route netlist
getProject().save('../routed_POC.v')

#request a specific timing analysis for our two flip flops
Timing_analysis = getProject().createAnalyzer()
Timing_analysis.addReportTimingRequest(
source = 'getRegister(Q2_reg)',
target = 'getRegister(Q3_reg)')
Timing_analysis.launch()


#export VHDL post place & route netlist
getProject().save('../routed_POC.vhd')
getProject().save('../routed_POC_worst.sdf','worstcase')
getProject().save('../routed_POC.v')

