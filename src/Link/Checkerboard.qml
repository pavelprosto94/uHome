import QtQuick 2.7
import QtGraphicalEffects 1.0

Item {
    id: root
    property alias color: front.color
    height: units.gu(4)
    width: units.gu(6)
    Rectangle {
        id: mask
        anchors.fill:parent
        anchors.margins: units.gu(0.1)
        opacity: 0
        radius: units.gu(0.6)
    }
    Image{
        id: back
        visible: false
        anchors.fill: parent
        source: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMjAwbW0iIGhlaWdodD0iMjAwbW0iIHZlcnNpb249IjEuMSIgdmlld0JveD0iMCAwIDIwMCAyMDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiA8cmVjdCB4PSIuNjUyODIiIHk9Ii42NTI4MiIgd2lkdGg9Ijk4LjY5NCIgaGVpZ2h0PSI5OC42OTQiIHN0eWxlPSJmaWxsOiMwMDAwMDA7c3Ryb2tlLWxpbmVjYXA6cm91bmQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS1vcGFjaXR5Oi41MzY2OTtzdHJva2Utd2lkdGg6MS4zMDU2O3N0cm9rZTojMDAwMDAwIi8+CiA8cmVjdCB4PSIxMDAuNjUiIHk9IjEwMC42NSIgd2lkdGg9Ijk4LjY5NCIgaGVpZ2h0PSI5OC42OTQiIHN0eWxlPSJmaWxsOiMwMDAwMDA7c3Ryb2tlLWxpbmVjYXA6cm91bmQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS1vcGFjaXR5Oi41MzY2OTtzdHJva2Utd2lkdGg6MS4zMDU2O3N0cm9rZTojMDAwMDAwIi8+Cjwvc3ZnPgo="
        fillMode: Image.Tile
        sourceSize.width: units.gu(1.5)
        sourceSize.height: units.gu(1.5)
    }
    ThresholdMask{
        anchors.fill: parent
        source: back
        maskSource: mask
        threshold: 0.4
        spread: 0.5
    }
    Rectangle {
        id: front
        anchors.fill:parent
        radius: units.gu(0.5)
        border.width: units.gu(0.1); 
        border.color: theme.palette.normal.base
    } 
}