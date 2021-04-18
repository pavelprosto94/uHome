import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Ubuntu.Components.Themes 1.3
import Ubuntu.Content 1.3

Page {
        id:root
        header: PageHeader {
            id: header
            title: i18n.tr("Edit note:")
        }
        property var backgroundActions: ["red.png", "orange.png", "yellow.png", "green.png", "blue.png", "purple.png", "pink.png", "white.png"]
        property var backgroundToColor: ["#fbd5ce", "#fde5cf",    "#fff4bc",    "#d1ecc6",   "#d3f5fc",  "#ccd9fc",    "#f5d4fd",  "#ffffff"]
      
      FontLoader { name: "Pecita"; source: "20180.otf" }
      FontLoader { name: "Icegirl"; source: "20319.otf" }
      FontLoader { name: "Casual Contact MF"; source: "19081.ttf" }

     Component.onCompleted: {
       var tmp=widgets.get(widgets.target_obj).snd
       if (tmp.settings.length>0){ widgetMain.settings=tmp.settings}
       tx1.text=widgetMain.textnote
       tx1.font.pixelSize=widgetMain.fontsize
       sl1.value=parseFloat(tmp.settings[2])
       for (var j = 0; j < os1.model.length; j++){
         if (os1.model[j]==tmp.settings[3]){
           os1.selectedIndex=j
         }
       }
      }
        
    Rectangle{
        id: widget_thumbnail
        anchors{
            top: header.bottom
            left: parent.left
            right: parent.right
        }
        height: units.gu(30)
        clip: true
        color: theme.palette.normal.background
        Item{
          anchors{
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
          }
          width: height
    Main{
            id: widgetMain
            visibleText: true
            TextArea {
                id: tx1
                visible: {if (widgetMain.visibleText){false}else{true}}
                text: widgetMain.textnote
                anchors{
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    margins: units.gu(2)
                }
                autoSize : true
                font.pixelSize: widgetMain.fontsize
                font.family: widgetMain.fontName
                wrapMode: Text.WordWrap
                //cursorVisible: true
                onCursorVisibleChanged: {
                  if (cursorVisible == false){
                    widgetMain.textnote=tx1.text
                    widgetMain.visibleText = true
                  }else{
                    widgetMain.visibleText = false
                  }
                }
            }
            MouseArea{
              anchors.fill:parent
              visible: widgetMain.visibleText
              onClicked:{
                    widgetMain.visibleText = false
                    tx1.cursorVisible = true
                  }
            }
          }    
        }
    }
    Flickable {
    clip: true
    anchors{
          top: widget_thumbnail.bottom
          left: parent.left
          right: parent.right
          bottom: okButton.top
        }
      contentWidth: rectRoot.width
      contentHeight: rectRoot.height
    
    Rectangle {
    id :rectRoot
        width: root.width
        height: {childrenRect.height+units.gu(4)}
        color: theme.palette.normal.background

   Text {
        id: label1
        text: i18n.tr("To edit the text of the note, click on an area in the widget.")
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(1)
        anchors{
          top: parent.top
          topMargin: units.gu(2)
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
        }
    }     
      Flickable {
        id: colorChooser
        clip: true
        anchors{
              top: label1.bottom
              left: parent.left
              right: parent.right
            }
          height: colorChoose.height
          contentWidth: colorChoose.width
          contentHeight: colorChoose.height  
        Rectangle {
        id :colorChoose
            width: childrenRect.width+units.gu(4)
            height: {units.gu(6)}
            color: theme.palette.normal.background

        Repeater{
        model: backgroundActions
        delegate: Rectangle{
            width: units.gu(4)
            height: units.gu(4)
            color: backgroundToColor[index]
            y: units.gu(1)
            x: units.gu(5)*index+units.gu(2)
            radius: units.gu(0.5)
            border{
              color: "#555"
              width: units.gu(0.25)
            }
            MouseArea{
              anchors.fill: parent
              onClicked:{
                widgetMain.backgroundsource=backgroundActions[index]
              }
            }
              }
          }
        }
      }
      Text {
        id: label2
        text: i18n.tr("Font size: ")
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: colorChooser.bottom
          topMargin: units.gu(2)
          left: parent.left
          leftMargin: units.gu(2)
        }
    }
    Slider {
      id:sl1
      function formatValue(v) { return v.toFixed(2) }
      anchors{
          top: colorChooser.bottom
          topMargin: units.gu(2)
          left: label2.right
          right: parent.right
          rightMargin: units.gu(2)
        }
        live: true
        minimumValue: 2.0
        maximumValue: 4.0
        value: 2.0
        stepSize: 0.1
        onValueChanged:{
          tx1.font.pixelSize=sl1.value*units.gu(1)
          widgetMain.fontsize=sl1.value*units.gu(1)
        }
    }
    Text {
        id: label3
        text: i18n.tr("Font style: ")
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: sl1.bottom
          topMargin: units.gu(2)
          left: parent.left
          leftMargin: units.gu(2)
        }
    }
    OptionSelector{
      id: os1
      anchors{
          top: label3.bottom
          topMargin: units.gu(0.5)
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
        }
        model: ["DejaVu Sans","Pecita", "Icegirl", "Casual Contact MF"]
        containerHeight: itemHeight*4
        onDelegateClicked:{
          if (index>-1){
            widgetMain.fontName=model[index].toString()
          }
        }
    }
    }}

    OpenButton{
  id: okButton
  anchors{
    left: parent.left
    leftMargin: units.gu(2)
    bottom: parent.bottom
    bottomMargin: units.gu(1.5)
  }
  width: units.gu(16)
  colorBut: UbuntuColors.green
  colorButText: "white"
  iconOffset: true
  iconName: "document-save"
  text: i18n.tr("Save")
    onPressed: {
        waitScreen.visible=true
    }
    onReleased: {
      var tosend = widgets.get(widgets.target_obj).snd
      var newSet = [widgetMain.backgroundsource, tx1.text, sl1.value.toString(), widgetMain.fontName]
      tosend.settings = newSet
      widgets.get(widgets.target_obj).snd=tosend
      waitScreen.visible=false
      stack.pop()
    }
  }
  OpenButton{
  id: cancelButton
  anchors{
    right: parent.right
    rightMargin: units.gu(2)
    bottom: parent.bottom
    bottomMargin: units.gu(1.5)
  }
  width: units.gu(16)
  iconOffset: true
  iconName: "close"
  text: i18n.tr("Cancel")
    onClicked: {
      stack.pop()
    }
  }
}
