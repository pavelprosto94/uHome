import QtQuick 2.7
import Ubuntu.Components 1.3

Rectangle{
    id: root
    rotation: -main.needrot
    property int index: -1
    property real wwidth: 0
    property real wheight: 0
    property real wtop: 0
    property real wleft: 0
    property string adr_conf: ""
    property bool mouseenbl: true
    onAdr_confChanged:{
        if (adr_conf==""){
            confbut.visible=false
        }else{
            confbut.visible=true
        }
    }
        width: wwidth
        height: wheight
        radius: units.gu(2)
        color: Qt.rgba(0.2,0.5,1,0.5)
        border{
            color: Qt.rgba(0.2,0.5,1,1)
            width: units.gu(0.2)
        }
        anchors{
            top: parent.top
            left: parent.left
            topMargin: wtop
            leftMargin: wleft
        }
        Rectangle{
        id: movebut
        width: units.gu(4)
        height: units.gu(4)
        radius: units.gu(2)
        color: "white"
        border{
            color: "#aaa"
            width: units.gu(0.2)
        }
        anchors{
            centerIn: parent
        }
        Icon {
            source: "../src/img/expand_move.svg"
            anchors.fill: parent
            anchors.margins: units.gu(1)
        }
        MouseArea {
        anchors.fill: parent
        visible: root.mouseenbl
        propagateComposedEvents:true
        onPressed: {
            warea_mouse.object=root
            warea_mouse.stposx=wleft
            warea_mouse.stposy=wtop
            root.mouseenbl=false
            warea_mouse.moveenbl=true
            //outConsol.text="startmove"
            mouse.accepted = false
        }  
    }}

        Rectangle{
        id: resizebut
        visible: {if (main.needrot==0) {true} else {false}}
        width: units.gu(4)
        height: units.gu(4)
        radius: units.gu(2)
        color: "white"
        border{
            color: "#aaa"
            width: units.gu(0.2)
        }
        anchors{
            right: parent.right
            rightMargin: -units.gu(2)
            bottom: parent.bottom
            bottomMargin: -units.gu(2)
        }
        Icon {
            source: "../src/img/arrow_scale.svg"
            anchors.fill: parent
            anchors.margins: units.gu(1)
        }
        MouseArea {
        anchors.fill: parent
        visible: root.mouseenbl
        propagateComposedEvents:true
        onPressed: {
            warea_mouse.object=root
            warea_mouse.stposx=wwidth
            warea_mouse.stposy=wheight
            root.mouseenbl=false
            warea_mouse.resizeenbl=true
            //outConsol.text="startresize"
            mouse.accepted = false
        }
    }}
    Rectangle{
        id: removebut
        property bool enblcon: false
        width: units.gu(4)
        height: units.gu(4)
        radius: units.gu(2)
        color: "white"
        border{
            color: "#f55"
            width: units.gu(0.2)
        }
        anchors{
            left: parent.left
            leftMargin: -units.gu(2)
            verticalCenter: parent.verticalCenter
        }
        Connections {
            enabled: removebut.enblcon
            target: myDialog
            onClicked: { 
            removebut.enblcon=false
                widgets.remove(index)
                if (index<warea_model.count-1)
                for (var i = index+1; i < warea_model.count; i++){
                    warea_model.get(i).ind=i-1
                }
                warea_model.remove(index)
            }
        }
        Icon {
            name: "delete"
            color: "#f22"
            anchors.fill: parent
            anchors.margins: units.gu(1)
        }
        MouseArea {
        anchors.fill: parent
        visible: root.mouseenbl
        onPressed: {
            myDialog.text = i18n.tr("Are you shure to remove this widget?")
            myDialog.okbutton = true;
            myDialog.oktext = i18n.tr("Yes")
            myDialog.button = i18n.tr("No")
            myDialog.visible = true;
            removebut.enblcon=true
        }
    }}
    Rectangle{
        id: confbut
        visible: {if (root.adr_conf!="") {true} else {false}}
        width: units.gu(4)
        height: units.gu(4)
        radius: units.gu(2)
        color: "white"
        border{
            color: "#aaa"
            width: units.gu(0.2)
        }
        anchors{
            right: parent.right
            rightMargin: -units.gu(2)
            verticalCenter: parent.verticalCenter
        }
        Icon {
            source: "../src/img/settings.svg"
            anchors.fill: parent
            anchors.margins: units.gu(1)
        }
        MouseArea {
        anchors.fill: parent
        visible: root.mouseenbl
        onPressed: {
            widgets.target_obj=index
            waitScreen.visible=true
        }
        onReleased: {
            waitScreen.visible=false
            stack.push(Qt.createComponent(root.adr_conf).createObject())
        }
    }}
}