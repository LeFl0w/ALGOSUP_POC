
import sys
import traceback
from nxpython import *
createProject("./Project/POC")
getProject().setVariantName("ULTRA300", "BGA-1152")
getProject().addFiles("work", ["./src/flipflop.v"])
getProject().addParameters({})
getProject().setDescription("")
