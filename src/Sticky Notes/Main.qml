//start_size: 2x2
import QtQuick 2.5
import QtGraphicalEffects 1.0
import Ubuntu.Components 1.3
//Don't forget the most important thing
Item {
    id: root
    anchors.fill : parent
    anchors.margins : units.gu(1)
    property var settings: ["yellow.png", "Simple Notes😗", "2"]
    property string backgroundsource: "yellow.png"
    property string textnote: "Simple Notes😗"
    property real fontsize: units.gu(2)
    property bool visibleText: true
    onSettingsChanged:{
        if (settings.length>0) backgroundsource=settings[0]
        if (settings.length>1) textnote=settings[1]
        if (settings.length>2) fontsize=units.gu(parseFloat(settings[2]))
    }
    FontLoader { id: pecitaFont; source: "20180.otf" }

    Image{
    anchors.fill: parent
    source: "background/"+backgroundsource
    smooth: true
    antialiasing: true
    }   
    Text{
        visible: visibleText
        anchors.fill: parent
        anchors.margins: units.gu(2)*(parent.width/units.gu(20))
        text: textnote
        clip: true
        color: "#000055"
        font.pixelSize: fontsize
        font.family: pecitaFont.name
        wrapMode: Text.WordWrap
    }
}