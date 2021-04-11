//start_size: 1x1
import QtQuick 2.5
import QtGraphicalEffects 1.0
import Ubuntu.Components 1.3

Item {
    id: root
    anchors.fill : parent
    anchors.margins : units.gu(1)
    property var settings: ["#FF0E8CBA", "Internet Link", "#FFFFFFFF", "img/morph-browser.svg", "https://liberapay.com/pavelprosto"]
    property string backgroundcolor: "#FF0E8CBA"
    property string iconsource: "img/morph-browser.svg"
    property string linkUrl: "https://liberapay.com/pavelprosto"
    property string linktext: "Internet Link"
    property string linkcolor: "#FFFFFFFF"
    onSettingsChanged:{
        if (settings.length>0) backgroundcolor=settings[0]
        if (settings.length>1) linktext=settings[1]
        if (settings.length>2) linkcolor=settings[2]
        if (settings.length>3) iconsource=settings[3]
        if (settings.length>4) linkUrl=settings[4]
    }
    Rectangle{
        id: rect
    anchors{
        fill: parent
        leftMargin: units.gu(0.5)
        rightMargin: units.gu(0.5)
        bottomMargin: units.gu(1)
    }
    color: backgroundcolor
    radius: units.gu(1.5)

Rectangle{
    id: background_source
    anchors.fill: parent
    opacity: 0
    radius: units.gu(1.5)
}
Image{
    id: ico_source
    anchors.fill: parent
    source: iconsource
    smooth: true
    visible: false
    fillMode: Image.PreserveAspectCrop
    
}
ThresholdMask{
    id: sr1
    threshold: 0.4
    spread: 0.5
    anchors.fill: parent
    source: ico_source
    maskSource: background_source
}
}
Text{
    id: sr2
    anchors{
        top: rect.bottom
        horizontalCenter: parent.horizontalCenter
    }
    text: linktext
    color: linkcolor
}

DropShadow {
        anchors.fill: rect
        horizontalOffset: units.gu(0.2)
        verticalOffset: units.gu(0.2)
        radius: units.gu(0.3)
        samples: 9
        color: "#AA000000"
        source: sr1
    }
DropShadow {
        anchors.fill: sr2
        horizontalOffset: units.gu(0.2)
        verticalOffset: units.gu(0.15)
        radius: units.gu(0.3)
        samples: 7
        color: "#AA000000"
        source: sr2
    }
MouseArea{
    anchors.fill: parent
    onClicked: {
        Qt.openUrlExternally(linkUrl)
    }
}
}