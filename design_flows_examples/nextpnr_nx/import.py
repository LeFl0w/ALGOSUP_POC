import sys
from nxpython import *

if len(sys.argv)<4:
    print("Not enough parameters")
    sys.exit(-1)  

prj = createProject()
prj.setVariantName("NG-ULTRA")
prj.setTopCellName('RisingEdge_DFlipFlop_AsyncResetHigh')
prj.importCell(sys.argv[1])

#request a specific timing analysis for our two flip flops
Timing_analysis = prj.createAnalyzer()
Timing_analysis.addReportTimingRequest(
source = 'getRegister(Q2_reg)',
target = 'getRegister(Q3_reg)')
Timing_analysis.launch()


#export VHDL post place & route netlist
prj.save('routed_POC.vhd')
prj.save('routed_POC_worst.sdf','worstcase')
prj.save('routed_POC.v')

prj.save(sys.argv[3])
