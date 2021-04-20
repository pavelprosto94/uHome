/*  CalculatorButton.qml */
import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Themes 1.3

UbuntuShape {
    signal clicked
    signal pressed
    signal released
    property string colorBut: theme.palette.normal.base
    property string colorButText: theme.palette.selected.baseText
    property string radiusBorder:  "medium"
    property var    aspectBorder:  UbuntuShape.DropShadow
    property alias  iconName: icon.name
    property bool   iconOffset: false
    property alias  text: label.text

    backgroundColor : colorBut
    radius: radiusBorder
    aspect: aspectBorder
    height: units.gu(5)

    anchors.margins : units.gu(0.25);
    Icon {
        id: icon
        anchors{
            left: parent.left
            leftMargin: units.gu(1.5)
            top: parent.top
            topMargin: units.gu(1)
            bottom: parent.bottom
            bottomMargin: units.gu(1)
        }
        color: colorButText
        name : ""
        width: {
            if (icon.name==""){
                units.gu(0)
            } else {
                icon.height
            }
        }
        height: parent.height
    }

    Text {
        id: label
        font.pixelSize: units.gu(2)
        anchors{
            left: {if (iconOffset) {icon.right} else {parent.left}}
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
        color: colorButText
        horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
    }
    property int animopa
    Rectangle {
        color: theme.palette.normal.background
        anchors.fill: parent
        opacity: animopa/40
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: parent.clicked()
        onPressed: parent.pressed()
        onReleased: parent.released()
    }
    NumberAnimation on animopa {
        id: anim1w
        alwaysRunToEnd: true
        running: mouseArea.pressed
        from: 0; to: 20;
        onRunningChanged: {
        if (!running) {
            anim2w.start()
        }
        }
    }
    NumberAnimation on animopa {
        id: anim2w
        alwaysRunToEnd: true
        from: 20; to: 0;
    }
}