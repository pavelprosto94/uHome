import QtQuick 2.7
import Ubuntu.Components.Themes 1.3
import Ubuntu.Components 1.3

Rectangle {
    id: root
    color: theme.palette.normal.background;
    property bool enablmouse: true;

Rectangle {
    id: butHide
    color: theme.palette.normal.background;
    height: units.gu(3);
    radius: units.gu(1.5)
    anchors{
        top: parent.top;
        topMargin: -units.gu(1.5);
        left: parent.left;
        right: parent.right;
        }
    Icon {
    width: parent.height
    height: parent.height
    name: "down"
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
    visible: bottomEdge.mouseenbl
    onClicked: {bottomEdge.collapse()}
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
            top: smartRestartBut.bottom
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
}
}