/*
 * Copyright (C) 2021  Pavel Prosto
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * uHome is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
/*
Аналоговые часы +
Cсылка +
Погода
Фото
Заметка +
*/
import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3
import Ubuntu.Components.Themes 1.3
import Qt.labs.platform 1.0
import Ubuntu.Content 1.3

MainView {
    id: main
    objectName: 'mainView'
    applicationName: 'uhome.pavelprosto'
    automaticOrientation: true
    property real needrot: if (width>height){-90}else{0}
    property var activeTransfer
    property int xsize: {if (needrot==0) {Math.floor(width/units.gu(10))} else {Math.floor(height/units.gu(10))}}
    property int ysize: {if (needrot==0) {Math.floor(height/units.gu(10))} else {Math.floor(width/units.gu(10))}}
    width: units.gu(45)
    height: units.gu(75)

    Component.onCompleted: {
    i18n.domain = "uhome.pavelprosto"
    }

    Settings {
    id: settings
    property string background_source: ""
    }

StackView {
    id: stack
    initialItem: mainView
    anchors.fill: parent
}

    Item {
        id: mainView
        visible: false
        Rectangle {
        anchors.fill: parent
        color: 'black'

        Image {
            id: background
            anchors.fill: parent
            source: settings.background_source
            fillMode: Image.PreserveAspectCrop
        }
        }

    Rectangle {
        id: widgets_layer
        rotation: main.needrot
        width: xsize*units.gu(10)
        height: ysize*units.gu(10)
        anchors{
            top:parent.top
            horizontalCenter: parent.horizontalCenter
            horizontalCenterOffset:units.gu(2.5/2)*(plus_layer.animopa/255)
            topMargin: {if (main.needrot!=0){(main.height-main.width)*0.35} else {0}}
            }
            transform: Scale { 
                origin.x: 0;
                origin.y: 0; 
                xScale: {1-0.0625*(plus_layer.animopa/255)}
                yScale: {1-0.0625*(plus_layer.animopa/255)}
                }
        color: "transparent"

    Repeater{
        model: widgets
        delegate: QDynamicLabel{
            //settingsWidget: sttg
            wleft: xl
            wtop: yl
            wwidth: ww
            wheight: wh
            sendi: snd
        }
    }
    ListModel {
    id: widgets
    property int target_obj
    }

    Rectangle {
        id: plus_layer
        signal showed
        signal hideed
        visible: false
        anchors.fill: parent
        color: Qt.rgba(1,1,1,0.4)
        property real animopa
        opacity: animopa/255
        NumberAnimation on animopa {
            id: plus_layer_anim2
            running: false
            alwaysRunToEnd: true
            from: 255; to: 0;
            onRunningChanged: {
            if (!running) {
                plus_layer.visible=false
            }
            }
          }
          NumberAnimation on animopa {
            id: plus_layer_anim1
            running: false
            alwaysRunToEnd: true
            from: 0; to: 255;
          }
        onShowed:{
            visible=true
            plus_model.clear()
            warea_model.clear()
            plus_layer_anim1.start()
            for (var x = 0; x < xsize+1; x++){
                for (var y = 0; y < ysize+1; y++){
                    var newItem = {}
                    newItem.xl=units.gu(10)*x-units.gu(5)
                    newItem.yl=units.gu(10)*y-units.gu(5)
                    plus_model.append(newItem)
                }
            }
            for (var i = 0; i < widgets.count; i++){
                var newItem = {}
                newItem.ww=widgets.get(i).ww
                newItem.wh=widgets.get(i).wh
                newItem.xl=widgets.get(i).xl
                newItem.yl=widgets.get(i).yl
                newItem.a_cnf=""
                newItem.ind=i
                var outset=widgets.get(i).snd.fileName
                python_main.call('main.getWidgetsSettings', [i, outset], function(returnValue) {
                    warea_model.get(returnValue[0]).a_cnf=returnValue[1]
                })
                warea_model.append(newItem)
            }
        }
        onHideed:{
            plus_layer_anim2.start()
            plus_model.clear()
            warea_model.clear()
        }
    Rectangle {
        color: "transparent"
        //clip: true
        anchors.fill: parent
    Repeater{
        model: plus_model
        delegate: Plus{
            pleft: xl
            ptop: yl
        }
    }
    ListModel {
        id: plus_model
    }
    MouseArea {
        id: warea_mouse
        anchors.fill: parent
        hoverEnabled: true
        focus: true
        property real stposx: -1
        property real stposy: -1
        property bool moveenbl:false
        property bool resizeenbl:false
        property var object : false
        onPositionChanged: {
            if ( moveenbl ) {
            //outConsol.text="move"
            object.wleft=mouse.x-object.wwidth/2
            object.wtop=mouse.y-object.wheight/2
            var newpos = Math.round(object.wleft / units.gu(5))
                if (stposx!=newpos*units.gu(5))
                {
                    widgets.get(object.index).xl=newpos*units.gu(5)
                    stposx=newpos*units.gu(5)
                }
            newpos = Math.round(object.wtop / units.gu(5))
                if (stposy!=newpos*units.gu(5))
                {
                    widgets.get(object.index).yl=newpos*units.gu(5)
                    stposy=newpos*units.gu(5)
                }
            }
            if ( resizeenbl ) {
                if (mouse.x-object.wleft>units.gu(9)){
                    object.wwidth=mouse.x-object.wleft
                    var newpos = Math.round(object.wwidth / units.gu(5))
                    if (stposx!=newpos*units.gu(5))
                    {
                        widgets.get(object.index).ww=newpos*units.gu(5)
                        stposx=newpos*units.gu(5)
                    }
                }
                if (mouse.y-object.wtop>units.gu(9)){
                    object.wheight=mouse.y-object.wtop
                    var newpos = Math.round(object.wheight / units.gu(5))
                    if (stposy!=newpos*units.gu(5))
                    {
                        widgets.get(object.index).wh=newpos*units.gu(5)
                        stposy=newpos*units.gu(5)
                    }
                }
            }
      }
      onReleased: {
          if ( moveenbl ) {
            moveenbl=false
            object.mouseenbl=true
            object.wleft=stposx
            object.wtop=stposy
            //outConsol.text="finishmove"
          }
          if ( resizeenbl ) {
            resizeenbl=false
            object.mouseenbl=true
            object.wwidth=stposx
            object.wheight=stposy
            //outConsol.text="finishresize"
          }
          }
    }
    Repeater{
        model: warea_model
        delegate: WidgetArea{
            wwidth: ww
            wheight: wh
            wleft: xl
            wtop: yl
            index: ind
            adr_conf: a_cnf
        }
    }
    ListModel {
        id: warea_model
    }
    }
    
    Rectangle{
        rotation: -main.needrot
        width: units.gu(5)
        height: units.gu(5)
        radius: units.gu(2.5)
        color: "white"
        border{
            color: "#aaa"
            width: units.gu(0.2)
        }
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: -units.gu(2.5)
        }
        Icon {
            name: "ok"
            anchors.fill: parent
            anchors.margins: units.gu(1)
        }
        MouseArea {
        anchors.fill: parent
        onClicked: {
            plus_layer.hideed()
            python_main.saveWidgets()
        }
    }}
    }
    }

    BottomEdge {
    id: bottomEdge
    height: units.gu(35)
    hint.text: i18n.tr("Menu")   
    contentComponent:  MenuPage{
        width: parent.width
        height: bottomEdge.height
    }
    property bool mouseenbl : false
    onCommitCompleted:{
        mouseenbl = true
    }
    onCollapseStarted:{
        mouseenbl = false
    }
    }

    Connections {
        id:widgetimport
        enabled: parent.visible
            target: ContentHub
            property var activeConTransfer
            onImportRequested: {
                console.log("try add:"+transfer.items[0].url.toString())
                widgetimport.activeConTransfer=transfer
                waitScreen.visible=true
                python_main.call('main.installWidget', [transfer.items[0].url.toString()], function(returnValue) {
                    waitScreen.visible=false
                    widgetimport.activeConTransfer.finalize()
                    myDialog.text=returnValue
                    myDialog.visible=true
                })
            }
        }
    }
    
    Rectangle {
        anchors.fill: parent
        color: 'black'
        property real animopa
        opacity: animopa/255
        NumberAnimation on animopa {
          alwaysRunToEnd: true
          from: 255; to: 0;
          }
    }

    Text {
        id: outConsol
        color: "white"
        text: "unpress"
        visible: false
    }
    Python {
        id: python_main

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../src/'));
            setHandler('error', function(returnValue) {
                    myDialog.text = returnValue
                    myDialog.visible = true;
                });
            setHandler('setBackground', function(returnValue) {
                    if (returnValue[0]!=settings.background_source) {
                        settings.background_source=returnValue[0]
                    }
                });
            setHandler('addwidget', function(returnValue) {
                var newItem = {}
                var sttngs = new Array (0)
                newItem.xl=returnValue[1]*units.gu(1)
                newItem.yl=returnValue[2]*units.gu(1)
                newItem.ww=returnValue[3]*units.gu(1)
                newItem.wh=returnValue[4]*units.gu(1)
                if (returnValue[5].length) {
                    var tmp = returnValue[5]
                    for (var j = 0; j < tmp.length; j++)
                        sttngs.push(tmp[j])
                    }
                newItem.snd={fileName:returnValue[0], settings: sttngs}
                widgets.append(newItem)
                });
            importModule('main', function() {
                console.log('module imported');
                python_main.call('main.widgets.load', [], function() {})
            });
        }
        function saveWidgets(){
            var outtxt = ""
            for (var i = 0; i < widgets.count; i++){
                outtxt += "file:"+widgets.get(i).snd.fileName+"\n"
                outtxt += "x:"+widgets.get(i).xl/units.gu(1)+"\n"
                outtxt += "y:"+widgets.get(i).yl/units.gu(1)+"\n"
                outtxt += "w:"+widgets.get(i).ww/units.gu(1)+"\n"
                outtxt += "h:"+widgets.get(i).wh/units.gu(1)+"\n"
                var outsettings = ""
                var tmp = widgets.get(i).snd.settings
                for (var j = 0; j < tmp.length; j++)
                    {var txt=tmp[j]
                    while (txt.indexOf("\n")>-1)
                        {txt=txt.replace("\n","</br>")}
                    outsettings += txt+"|"}
                outtxt += "settings:"+outsettings+"\n"
            }
            python_main.call('main.saveWidgets', [outtxt], function() {})
        }
        onError: {
            myDialog.text = 'python error: ' + traceback
            myDialog.visible = true;
            console.log('python error: ' + traceback);
        }
    }
    ImportPage {
    id: importPage
    visible: false
    }
    MyDialog {
        id: myDialog
        visible: false
        anchors.fill: parent
    }
    WaitScreen{
        id: waitScreen
        visible: false
        anchors.fill: parent
    }
}
