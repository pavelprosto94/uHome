import os

APP_PKG_NAME = os.path.abspath(__file__)
APP_PKG_NAME = APP_PKG_NAME[APP_PKG_NAME.find(".com/")+5:]
APP_PKG_NAME = APP_PKG_NAME[:APP_PKG_NAME.find("/")]
SCRIPTPATH = os.path.abspath(__file__)
SCRIPTPATH = SCRIPTPATH[:SCRIPTPATH.rfind('/')]

CACHEPATH = "/home/phablet/.cache/"+APP_PKG_NAME
DATAPATH = "/home/phablet/.local/share/"+APP_PKG_NAME
CONFIGPATH = "/home/phablet/.config/"+APP_PKG_NAME
TMPPATH = "/home/phablet/.cache/"+APP_PKG_NAME+"/tmp"

#os.chmod(TMPPATH, 777)
if not os.path.exists(TMPPATH):
    try:
        os.makedirs(TMPPATH)
    except Exception as e:
        print("Can't create DATAPATH dir:\n"+TMPPATH)
        print(e)

if not os.path.exists(DATAPATH):
    try:
        os.makedirs(DATAPATH)
    except Exception as e:
        print("Can't create DATAPATH dir:\n"+DATAPATH)
        print(e)

if not os.path.exists(CONFIGPATH):
    try:
        os.makedirs(CONFIGPATH)
    except Exception as e:
        print("Can't create CONFIGPATH dir:\n"+CONFIGPATH)
        print(e)

if not os.path.exists(CACHEPATH):
    try:
        os.makedirs(CACHEPATH)
    except Exception as e:
        print("Can't create CACHEPATH dir:\n"+CACHEPATH)
        print(e)