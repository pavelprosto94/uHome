'''
 Copyright (C) 2021  Pavel Prosto

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; version 3.

 uHome is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''
import glob
import os
import threading
from threading import Thread
import pyotherside
import tarfile
from urllib.parse import unquote

def installWidget(adr=""):
  rez="Incorect widget file"
  if ".tar" in  adr:
    adr=adr[adr.find("//")+2:]
    nameWidget=""
    try:
      tar = tarfile.open(adr)
      for member in tar.getnames():
        if "/Main.qml" in member:
          nameWidget=member[:member.find("/")]
      if nameWidget!="":
        rez="Error install widget: <b>"+nameWidget+"</b>"
        tar.extractall(glob.DATAPATH)
        rez="<b>"+nameWidget+"</b> installed successfully"
      tar.close()
    except Exception as e:
        print(e)
  return rez

def fileexists(namef):
  ans=False
  if os.path.exists(namef):
    ans=True
  return ans

def updateWidget(indata):
  print(indata)
  pyotherside.send('updateWidget', indata)

# def getBackground():
#   text=""
#   f = open(CONFIGFILE, "r")
#   text=f.read()
#   key="Background="
#   text=text[text.rfind(key)+len(key):]
#   text=text[:text.find("\n")]
#   text="file://"+text
#   f.close()
#   return text
def getBackground(adr):
  if adr=="":
    adr="../src/Backgrounds/IMG_9137.jpg"
  if "/var/lib/" in adr:
    adr="../src/Backgrounds/IMG_9137.jpg"
  if "/usr/share/" in adr:
    adr="../src/Backgrounds/IMG_9137.jpg"  
  if "../src" in adr:
    adr=adr.replace("../src",  glob.SCRIPTPATH)
  else:
    if "/src/Backgrounds" in adr:
      adr=glob.SCRIPTPATH+adr[adr.rfind("/Backgrounds"):]
  if "cache://" in adr:
    adr=adr.replace("cache://",  glob.CACHEPATH)
  return adr

def removeFile(adr):
  os.remove(adr)

def getListFiles(path="",extension=""):
  rez=[]
  if "../src" in path:
    path=path.replace("../src",  glob.SCRIPTPATH)
  if os.path.exists(path):
    for root, dirs, files in os.walk(path):
        for filename in files:
          if extension in filename:
            rez.append(filename)
  return rez

def saveWidgets(txt):
  f = open(glob.CONFIGPATH+"/widgets.cnf", "w")
  f.write(txt)
  f.close()

def getWidgetsSettings(ind, adr):
  conf_adr=""
  adr=adr[:adr.rfind("/")]
  if "../src" in adr:
    adr=adr.replace("../src",  glob.SCRIPTPATH)
  if os.path.exists(adr+"/SettingsMain.qml"):
    conf_adr=adr+"/SettingsMain.qml"
  return [ind,conf_adr]

def createLink(txt=""):
  if txt!="":
    txt=unquote(txt)
    backgroundcolor = "#FFCE2029"
    iconsource = "img/link.svg"
    linkUrl = "https://liberapay.com/pavelprosto"
    linktext = "Link"
    linkcolor = "#FFFFFFFF"
    scpr=[txt]
    if "&" in txt:
      scpr=txt.split("&")
    for line in scpr:
      if "name=" in line:
        linktext=line[line.find("=")+1:]
      if "backgroundcolor=" in line:
        backgroundcolor=line[line.find("=")+1:]
      if "icon=" in line:
        iconsource=line[line.find("=")+1:]
      if "url=" in line:
        linkUrl=line[line.find("=")+1:]
    filename="../src/Link/Main.qml"
    x=20
    y=40
    w=10
    h=10
    settg=[backgroundcolor,linktext,linkcolor,iconsource,linkUrl]
    if os.path.exists(filename.replace("../src",  glob.SCRIPTPATH)):
      pyotherside.send('addwidget', [filename,x,y,w,h,settg])
  return txt

class WidgetsThread(Thread):
  def __init__(self):
    Thread.__init__(self)
    self.background=""
      
  def run(self):
    pyotherside.send('setBackground', [getBackground(self.background)])
    if not os.path.exists(glob.CONFIGPATH+"/widgets.cnf"):
      f = open(glob.CONFIGPATH+"/widgets.cnf", "w")
      strtxt = open(glob.SCRIPTPATH+'/datastart', 'r').read()
      f.write(strtxt.replace("{path}",glob.SCRIPTPATH))
      f.close()
    if os.path.exists(glob.CONFIGPATH+"/widgets.cnf"):
      f = open(glob.CONFIGPATH+"/widgets.cnf", "r")
      text=f.read()
      #print(text)
      text=text.split("\n")

      filename=""
      x=0
      y=0
      w=0
      h=0
      settg=[]
      for line in text:
        if line[0:line.find(":")]=="file":
          filename=line[line.find(":")+1:]
          if "/src/" in filename:
            filename=glob.SCRIPTPATH+filename[filename.find("/src/")+4:]
        if line[0:line.find(":")]=="x":
          x=float(line[line.find(":")+1:])
        if line[0:line.find(":")]=="y":
          y=float(line[line.find(":")+1:])
        if line[0:line.find(":")]=="w":
          w=float(line[line.find(":")+1:])
        if line[0:line.find(":")]=="h":
          h=float(line[line.find(":")+1:])
        if line[0:line.find(":")]=="settings":
          if "|" in line:
            tmpline=line[line.find(":")+1:]
            tmpline=tmpline.replace("</br>","\n")
            settg=tmpline.split("|")
            if len(settg)>0:
              if settg[len(settg)-1]=="":
                settg.pop(len(settg)-1)
          if os.path.exists(filename.replace("../src",  glob.SCRIPTPATH)):
            pyotherside.send('addwidget', [filename,x,y,w,h,settg])
          filename=""
          x=0
          y=0
          w=0
          h=0
          settg=[]
      f.close()
  pyotherside.send('finalizewidget', [])

class Widgets:
  def __init__(self):
    self.bgthread = threading.Thread()

  def load(self, background=""):
    if self.bgthread.is_alive():
      return
    self.bgthread = WidgetsThread()
    self.bgthread.background=background
    self.bgthread.start()

widgets = Widgets()