//start_size: 3x1
import QtQuick 2.5
import Ubuntu.Components 1.3
import Ubuntu.Components.Themes 1.3

Item {
    id: root
    anchors.fill : parent
    anchors.margins : units.gu(1)
    property bool rotatemode: {if (main.needrot==0) {false} else {true}}
Rectangle{
    id: background_source
    anchors{
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
    }
    height: units.gu(6)
    width: {if (rotatemode) {units.gu(6)} else {parent.width}}
    radius: units.gu(1)
    color: theme.palette.normal.background
    border.width: units.gu(0.1); 
    border.color: theme.palette.normal.base
    opacity: 0.5

    TextField {
    id: tx1
    text: ""
    focus: false
    visible: {if (rotatemode) {false} else {true}}
    anchors{
          top: parent.top
          topMargin: units.gu(1)
          left: parent.left
          leftMargin: units.gu(6)
          right: parent.right
          rightMargin: units.gu(2)
        }
    onAccepted: {
        if (text!="")
        {Qt.openUrlExternally("https://duckduckgo.com/"+text)
      tx1.text= ""
      tx1.focus=false
      }
    }
    onCursorVisibleChanged: {
        if (cursorVisible == false){
            tx1.text= ""
            tx1.focus=false
        }
    }
  }
}
Image{
      anchors{
        verticalCenter: parent.verticalCenter
        left: background_source.left
        leftMargin: units.gu(1)
        }
        width: units.gu(4)
        height: units.gu(4)
        source: "logo.png"
        smooth: true
        antialiasing: true
        fillMode: Image.PreserveAspectFit
        opacity: 0.9
  }
    MouseArea{
            anchors.fill:background_source
            onClicked:{
              if (rotatemode){
                Qt.openUrlExternally("https://duckduckgo.com/")
              }else{
                tx1.forceActiveFocus()
              }
            }
        }
}