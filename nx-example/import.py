import sys
from nxpython import *

if len(sys.argv)<4:
    print("Not enough parameters")
    sys.exit(-1)  

prj = createProject()
prj.setVariantName("NG-ULTRA")
prj.setTopCellName('top')
prj.importCell(sys.argv[1])
prj.generateBitstream(sys.argv[2])
prj.save(sys.argv[3])
