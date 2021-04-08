import os
import pyotherside

SCRIPTPATH = os.path.abspath(__file__)
SCRIPTPATH = SCRIPTPATH[:SCRIPTPATH.rfind('/')]

def getBackgrounds():
    rez=[]
    for root, dirs, files in os.walk(SCRIPTPATH+"/background"):
        for filename in files:
            rez.append(filename)
    return rez
            
def getFronts():
    rez=[]
    for root, dirs, files in os.walk(SCRIPTPATH+"/front"):
        for filename in files:
            rez.append(filename)
    return rez

# DATAPATH = "/home/phablet/.local/share/uhome.pavelprosto/Analog Clock"
# if not os.path.exists(DATAPATH):
#     try:
#         os.makedirs(DATAPATH)
#     except Exception as e:
#         print("Can't create DATAPATH dir:\n"+DATAPATH)
#         print(e)
