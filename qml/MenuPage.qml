import QtQuick 2.7
import Ubuntu.Components.Themes 1.3
import Ubuntu.Components 1.3

Rectangle {
    id: root
    color: {if (height>units.gu(2)) {theme.palette.normal.background;}else{"transparent"}}
    property bool enablmouse: true;
    signal commit
    signal commitCompleted
    signal collapse
    signal collapseStarted
    height: heightSize
    property real heightSize:units.gu(1)

    NumberAnimation on heightSize { 
        id: showAnim
        alwaysRunToEnd: true
        running: false
        to: units.gu(35); 
        property bool enbl: false
        onRunningChanged: {
            if (!running) {
                if(enbl) {
                root.commitCompleted()
                enbl = false
            }}}
        }
    NumberAnimation on heightSize { 
        id: hideAnim
        alwaysRunToEnd: true
        running: false
        to: units.gu(1); 
        property bool enbl: false
        onRunningChanged: {
            if (running) {
                if(enbl) {
                root.collapseStarted()
                enbl = false
            }}}
        }
    onCommit:{
        showAnim.start()
        showAnim.enbl=true
    }
    onCollapse:{
        hideAnim.start()
        hideAnim.enbl=true
    }

Rectangle {
    id: butHide
    color: theme.palette.normal.background;
    height: units.gu(3);
    radius: units.gu(1.5)
    anchors{
        top: parent.top;
        topMargin: -units.gu(1.5);
        horizontalCenter: parent.horizontalCenter
        }
    width: {if (root.height>units.gu(2)) {parent.width}else{units.gu(5)}}
    Icon {
    width: parent.height
    height: parent.height
    name: {if (root.height>units.gu(2)) {"down"} else {"up"}}
    anchors.centerIn: parent
    }
    Rectangle {
        anchors{
        bottom: parent.bottom;
        left: parent.left;
        right: parent.right;
        }
        height: units.gu(0.1);
        color: theme.palette.normal.base;
    }
MouseArea {
    anchors.fill: parent
    onClicked: {
        if (root.height>units.gu(2))
        {
            bottomEdge.collapse()
        }else{
            bottomEdge.commit()
        }
    }
    onReleased: {
        if (root.height<units.gu(2))
        {
            if (mouse.y<-units.gu(10)){
            clicked(mouse)
            }
        }else{
            if (mouse.y>units.gu(10)){
            clicked(mouse)
            }
        }
    }
}
}
OpenButton{
        id: addTestWidgetBut
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: units.gu(1)
        }
        text: i18n.tr("Add test widget")
        iconName: "add"
        visible: false
        onPressed: {
            waitScreen.visible=true
            plus_layer.hideed()
        }
        onReleased:{
            waitScreen.visible=false
            bottomEdge.collapse()
            var newItem = {}
            var sttngs = []
            newItem.ww=units.gu(20)
            newItem.wh=units.gu(20)
            newItem.xl=units.gu(20)-newItem.ww/2
            newItem.yl=units.gu(30)-newItem.wh/2
            newItem.sttg=sttngs
            newItem.snd={fileName:"../src/Sticky Notes/Main.qml", settings: sttngs}
            widgets.append(newItem)
        }
    }
Item{
    anchors{
    top: butHide.bottom
    horizontalCenter: parent.horizontalCenter
    }
    width: units.gu(40)
OpenButton{
        id: addWidgetBut
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
            margins: units.gu(1)
        }
        text: i18n.tr("Add widgets")
        iconName: "add"
        onPressed: {
        if (bottomEdge.mouseenbl) {
            waitScreen.visible=true
        }}
        onClicked:{
            if (bottomEdge.mouseenbl) {
            plus_layer.hideed()
            waitScreen.visible=false
            bottomEdge.collapse()
            stack.push("WidgetHub.qml")
        }}
        onReleased:{
            if (bottomEdge.mouseenbl) {
            waitScreen.visible=false
        }}
    }
OpenButton{
        id: chandeWidgetBut
        anchors{
            left: parent.left
            right: parent.right
            top: addWidgetBut.bottom
            margins: units.gu(1)
        }
        iconOffset: true
        text: i18n.tr("Edit home screen")
        iconName: "compose"
        onClicked:{
            if (bottomEdge.mouseenbl) {
        if(bottomEdge.mouseenbl){
            plus_layer.showed()
            bottomEdge.collapse()
        }}}
    }
OpenButton{
        visible: false
        id: smartRestartBut
        anchors{
            left: parent.left
            right: parent.right
            top: chandeWidgetBut.bottom
            margins: units.gu(1)
        }
        iconOffset: true
        text: i18n.tr("Smart restart")
        iconSource: "../src/img/magic.svg"
        imgColored: true
        onPressed: {
        if (bottomEdge.mouseenbl) {
            waitScreen.visible=true
        }}
        onClicked:{
            if (bottomEdge.mouseenbl) {
            bottomEdge.collapse()
            plus_layer.hideed()
            widgets.clear()
            python_main.call('main.widgets.load', [], function() {})
            waitScreen.visible=false   
        }}
        onReleased:{
            if (bottomEdge.mouseenbl) {
            waitScreen.visible=false
        }}
    }
    OpenButton{
            id: donateButton
            anchors{
            left: parent.left
            right: parent.right
            top: chandeWidgetBut.bottom
            margins: units.gu(1)
            }
            iconName: "like"
            text: i18n.tr("Donate");
            onClicked: {
                if (bottomEdge.mouseenbl) {
                Qt.openUrlExternally("https://liberapay.com/pavelprosto/")
                bottomEdge.collapse()
            }}
    }
    OpenButton{
        id: settingsBut
        anchors{
            left: parent.left
            right: parent.right
            top: donateButton.bottom
            margins: units.gu(1)
        }
        text: i18n.tr("Settings")
        iconName: "settings"
        onPressed: {
        if (bottomEdge.mouseenbl) {
            waitScreen.visible=true
        }}
        onClicked:{
            if (bottomEdge.mouseenbl) {
            waitScreen.visible=false
            bottomEdge.collapse()
            stack.push("MainSettings.qml")
        }}
        onReleased:{
            if (bottomEdge.mouseenbl) {
            waitScreen.visible=false
        }}
    }
}
}