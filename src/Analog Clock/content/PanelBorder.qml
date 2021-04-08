//  Fancy pseudo-3d control border
import QtQuick 2.9
import Ubuntu.Components 1.3

Rectangle {
    width : 40; height : 15;
    border.width: 1; border.color: "#FF101010"
    color: "transparent"
    anchors.leftMargin: 1; anchors.topMargin: 3
    clip: true
    Rectangle {
        anchors.fill: parent;
        anchors.leftMargin: -1; anchors.topMargin: -1
        anchors.rightMargin: 0; anchors.bottomMargin: 0
        color: "transparent"
    }
}


