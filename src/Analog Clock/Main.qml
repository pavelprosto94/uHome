//start_size: 2x2
import QtQuick 2.5
import QtGraphicalEffects 1.0

Item {
    clip: true
    id: root
    anchors.fill : parent
    anchors.margins : units.gu(1)
    property int index: -1
    property var settings: ["#00FFFFFF", "#FFFFFF", "Ubuntu.svg", "None.svg"]
    property string backgroundcolor: "#ffffff"
    property string handcolor: "#ffffff"
    property string arrowsource: "Ubuntu.svg"
    property string glasssource: "None.svg"
    onSettingsChanged:{
        if (settings.length>0) backgroundcolor=settings[0]
        if (settings.length>1) handcolor=settings[1]
        if (settings.length>2) arrowsource=settings[2]
        if (settings.length>3) glasssource=settings[3]
    }

    property real second: 0
    property real minute: 0
    property real hour: 0

function getinfClock() {
    var currentTime = new Date()
    root.second = currentTime.getSeconds() * 6
    root.minute = currentTime.getMinutes() * 6 + currentTime.getSeconds() * 0.1
    root.hour = currentTime.getHours() * 30 + currentTime.getMinutes() * 0.5
}
// Image{
//     id: backsource
//     anchors{
//         top: parent.top
//         topMargin: -root.parent.y
//         left: parent.left 
//         leftMargin: -root.parent.x
//     }
//     visible:false
//     width: main.sizeWidth
//     height: main.sizeHeight
//     source: main.settings.background_source
// }
// FastBlur{
//     anchors.fill : backsource
//     source: backsource
//     radius: units.gu(1)
//     opacity: 0.8
// }

Rectangle{
    anchors.fill : parent
    color: backgroundcolor
    radius: units.gu(1.5)
}
Rectangle{
    id: background_source
    anchors.fill : parent
    opacity: 0
    radius: units.gu(1.5)
}
// ThresholdMask{
//     id: backsource_opacity
//     anchors.fill: backsource
//     source: backsource
//     maskSource: background_source
//     visible: false
// }
Image{
    id: arrow_source
    anchors.fill : parent
    source: "background/"+root.arrowsource
    smooth: true
    antialiasing: true
    visible: false
}
ThresholdMask{
    id: arrow_opacity
    anchors.fill: parent
    source: arrow_source
    maskSource: background_source
    visible: false
}
ColorOverlay{
    id: arrow_color
    anchors.fill: parent
    source:arrow_opacity
    color: handcolor
    antialiasing: true
    //visible: false
}

Item{
    anchors.fill : parent
    rotation: root.hour
Rectangle {
    id: hourHand
    width: units.gu(1)
    height: parent.height*0.3
    anchors{
        horizontalCenter: parent.horizontalCenter
        bottom: parent.verticalCenter
    }
    radius: 3
    color: root.handcolor
}}

Item{
    anchors.fill : parent
    rotation: root.minute
Rectangle {
    id: minuteHand
    width: units.gu(0.6)
    height: parent.height*0.4
    anchors{
        horizontalCenter: parent.horizontalCenter
        bottom: parent.verticalCenter
    }
    radius: 3
    color: root.handcolor
}}

Item{
    anchors.fill : parent
    rotation: root.second
Rectangle {
    id: secondHand
    width: units.gu(0.2)
    height: parent.height*0.45
    anchors{
        horizontalCenter: parent.horizontalCenter
        bottom: parent.verticalCenter
    }
    radius: 2
    color: root.handcolor
}}

Image{
    id: glass_source
    anchors.fill : parent
    source: "front/"+root.glasssource
    smooth: true
    antialiasing: true
    visible: false
}
ThresholdMask{
    id: glass_opacity
    anchors.fill: parent
    source: glass_source
    maskSource: background_source
    //visible: false
}

Timer {
        running: parent.enabled
        interval: 1000
        triggeredOnStart: true
        repeat: true
        onTriggered: {
            getinfClock();
        }
    }

MouseArea{
    anchors.fill: parent
    onClicked: {
        Qt.openUrlExternally("alarm://")
    }
}
}