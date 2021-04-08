import glob
import os
import threading
from threading import Thread
import pyotherside
import shutil

def removeWidget(adr=""):
  rez=""
  adr=adr[:adr.rfind("/")]
  if glob.DATAPATH in adr:
    try:
      shutil.rmtree(adr)
    except Exception as e:
      print(e)
      rez="Error remove: "+adr
  return rez

def testLoca(dirsname,path):
    if os.path.exists(path+"/"+dirsname+"/Main.qml"):
        adr=path+"/"+dirsname+"/Main.qml"
        name=dirsname
        thumbnail="../src/img/engine.svg"
        if os.path.exists(path+"/"+dirsname+"/thumbnail.jpg"):
            thumbnail=path+"/"+dirsname+"/thumbnail.jpg"
        x=2
        y=2
        f = open(path+"/"+dirsname+"/Main.qml", "r")
        text=f.read().split("\n")
        for txt in text:
            if "//" in txt:
                if "start_size:" in txt:
                    x = int(txt[txt.rfind(":")+1:txt.rfind("x")])
                    y = int(txt[txt.rfind("x")+1:])
            else:
                break
        f.close
        pyotherside.send('addWidgetItem', [adr,name,thumbnail,x,y])

def load():
    for dirsname in os.listdir(glob.SCRIPTPATH):
        testLoca(dirsname, glob.SCRIPTPATH)
    for dirsname in os.listdir(glob.DATAPATH):
        testLoca(dirsname, glob.DATAPATH)
        #pyotherside.send('error', dirs)
        