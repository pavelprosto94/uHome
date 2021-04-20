import QtQuick 2.0

Image{
    id: root
width: units.gu(10)
height: units.gu(10)
property real ptop: 0
property real pleft: 0
anchors{
    top: parent.top
    left: parent.left
    topMargin: ptop
    leftMargin: pleft
}
fillMode: Image.PreserveAspectCrop
source: "../src/img/plus.svg"
}