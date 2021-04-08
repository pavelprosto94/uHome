// Vertical "slider" control used in colorpicker
import QtQuick 2.4
import Ubuntu.Components.Themes 1.3
Item {
    property int cursorHeight: 7
    property real value: (1 - pickerCursor.y/height)
    width: 15; height: 300
    Item {
        id: pickerCursor
        width: parent.width
        Rectangle {
            radius: height/2
            x: 0; y: -height*0.5
            width: parent.width; height: parent.width/2
            border.color: "black"; border.width: units.gu(0.1)
            color: "transparent"
            Rectangle {
                radius: height/2
                anchors.fill: parent; anchors.margins: units.gu(0.1)
                border.color: "white"; border.width: units.gu(0.1)
                color: "transparent"
            }
        }
    }
    MouseArea {
        y: -Math.round(cursorHeight/2)
        height: parent.height+cursorHeight
        anchors.left: parent.left
        anchors.right: parent.right
        function handleMouse(mouse) {
            if (mouse.buttons & Qt.LeftButton) {
                pickerCursor.y = Math.max(0, Math.min(height, mouse.y)-cursorHeight)
            }
        }
        onPositionChanged: {
            handleMouse(mouse)
        }
        onPressed: handleMouse(mouse)
    }

    onVisibleChanged: {
        if(visible) {
            pickerCursor.y = -cursorHeight*0.5
        }
    }
}

