import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Ubuntu.Components.Themes 1.3
import io.thp.pyotherside 1.3
import Ubuntu.Content 1.3

Page {
        id:root
        header: PageHeader {
            id: header
            title: i18n.tr("Edit Link")
        }
    
    Rectangle{
        id: widget_thumbnail
        anchors{
            top: header.bottom
            left: parent.left
            right: parent.right
        }
        height: units.gu(12)
        radius: units.gu(2)
        clip: true
        color: theme.palette.normal.base
        
        Image {
            anchors{
                left: parent.left
                top: parent.top
                topMargin: - header.bottom
                }
            width: background.width
            height: background.height
            source: settings.background_source
            fillMode: Image.PreserveAspectCrop
        }
        Item{
            anchors{
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                margins: units.gu(1)
            }
            width:height
        Main{
            id: widgetMain
        }}
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
        text: i18n.tr("Link name:")
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: parent.top
          topMargin: units.gu(2)
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
        }
    }
    TextField {
    id: tx1
    text: ""
    cursorVisible: false
    anchors{
          top: label1.bottom
          topMargin: units.gu(1)
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
        }
    Keys.onReleased: {
      var newSet = [widgetMain.backgroundcolor, tx1.text, widgetMain.linkcolor, widgetMain.iconsource, widgetMain.linkUrl]
      widgetMain.settings=newSet
    }
  }
  Text {
        id: label2
        text: i18n.tr("Link URL:")
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: tx1.bottom
          topMargin: units.gu(2)
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
        }
    }
    TextField {
    id: tx2
    text: ""
    cursorVisible: false
    anchors{
          top: label2.bottom
          topMargin: units.gu(1)
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
        }
    Keys.onReleased: {
      var newSet = [widgetMain.backgroundcolor, widgetMain.linktext, widgetMain.linkcolor, widgetMain.iconsource, tx2.text]
      widgetMain.settings=newSet
    }
  }
  Text {
        id: label3
        text: i18n.tr("To test the link, you can click on the prototype widget at the top of the screen.")
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(1)
        anchors{
          top: tx2.bottom
          topMargin: units.gu(0)
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
        }
    }
    OpenButton{
  id: iconChooseButton
  anchors{
    top: label3.bottom
    topMargin: units.gu(2)
    left: parent.left
    leftMargin: units.gu(2)
    right: parent.right
    rightMargin: units.gu(2)
  }
  iconOffset: true
  iconName: "import"
  text: i18n.tr("Import a picture for icon")
    onClicked: {
        stack.push(importPage)
    }
  }
  Text {
        id: label4
        text: i18n.tr("BackgroundColor:")
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: iconChooseButton.bottom
          topMargin: units.gu(3)
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
        }

        Checkerboard{
          id: color1
          anchors{
            right: parent.right
            top: parent.top
            topMargin: -units.gu(0.5)
            bottom: parent.bottom
            bottomMargin: -units.gu(0.5)
          }
          width: units.gu(5)
          onColorChanged: {
            var newSet = [color.toString().toUpperCase(), tx1.text, widgetMain.linkcolor, widgetMain.iconsource, tx2.text]
            widgetMain.settings=newSet
          }
          MouseArea{
            anchors.fill: parent
            onClicked:{
              colorPicker.setColor=color1.color
              colorPicker.obj_target=color1
              colorPicker.visible=true
            }
          }
        }
    } 
    Text {
        id: label5
        text: i18n.tr("LinkColor:")
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: label4.bottom
          topMargin: units.gu(3)
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
        }
        Checkerboard{
          id: color2
          anchors{
            right: parent.right
            top: parent.top
            topMargin: -units.gu(0.5)
            bottom: parent.bottom
            bottomMargin: -units.gu(0.5)
          }
          width: units.gu(5)
            onColorChanged: {
              var newSet = [widgetMain.backgroundcolor, tx1.text, color.toString().toUpperCase(), widgetMain.iconsource, tx2.text]
              widgetMain.settings=newSet
            }
          MouseArea{
            anchors.fill: parent
            onClicked:{
              colorPicker.setColor=color2.color
              colorPicker.obj_target=color2
              colorPicker.visible=true
            }
          }
        }
    }

    OpenButton{
  id: sketchButton
  anchors{
    right: parent.right
    rightMargin: units.gu(2)
    top: label5.bottom
    topMargin: units.gu(3)
  }
  width: units.gu(16)
  iconOffset: true
  iconName: "image-quality"
  text: i18n.tr("Sketch")
    onClicked: {
      sketchlayer.visible=true
    }
  }
    }
    }

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
      if (importPage.newFileUrl==widgetMain.iconsource){
        var namefile = importPage.activeTransfer.items[0].url.toString()
        namefile=namefile.substr(namefile.lastIndexOf("/")+1,namefile.length);
        namefile="/home/phablet/.cache/uhome.pavelprosto/"+namefile
      python_main.call('main.fileexists', [namefile], function(returnValue) {
        var namefile = importPage.activeTransfer.items[0].url.toString()
        namefile=namefile.substr(namefile.lastIndexOf("/")+1,namefile.length);
        namefile="/home/phablet/.cache/uhome.pavelprosto/"+namefile
      if (importPage.activeTransfer.items[0].move("/home/phablet/.cache/uhome.pavelprosto/")==false && returnValue==false )
        {
            myDialog.text=i18n.tr("Filed import file: "+namefile)
            myDialog.visible=true
        }else{
          importPage.activeTransfer.finalize()
          var tosend = widgets.get(widgets.target_obj).snd
          var newSet = [widgetMain.backgroundcolor, tx1.text, widgetMain.linkcolor, namefile, tx2.text]
          tosend.settings = newSet
          widgets.get(widgets.target_obj).snd=tosend  
          stack.pop()
        }
      waitScreen.visible=false
      })
      }else{
      var tosend = widgets.get(widgets.target_obj).snd
      var newSet = [widgetMain.backgroundcolor, tx1.text, widgetMain.linkcolor, widgetMain.iconsource, tx2.text]
      tosend.settings = newSet
      widgets.get(widgets.target_obj).snd=tosend
      waitScreen.visible=false
      stack.pop()
      }
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

    ColorPicker{
        id: colorPicker
        property var obj_target
        visible: false
        anchors.centerIn: parent
        width: {if (parent.width>parent.height){parent.height-units.gu(2)}else{parent.width-units.gu(2)}}
        height: width
        onConfirm:{
          obj_target.color=colorValue
        }
    }

    Component.onCompleted: {
      var tmp=widgets.get(widgets.target_obj).snd
      if (tmp.settings.length>0){ widgetMain.settings=tmp.settings}
      tx1.text=widgetMain.linktext
      tx2.text=widgetMain.linkUrl
      color1.color=widgetMain.backgroundcolor
      color2.color=widgetMain.linkcolor
      }

    Connections {
            enabled: parent.visible
            target: importPage
            onImported: { 
            if (fileUrl.indexOf(".png") || fileUrl.indexOf(".jpg") || fileUrl.indexOf(".svg"))
            { 
              var newSet = [widgetMain.backgroundcolor, tx1.text, widgetMain.linkcolor, fileUrl, tx2.text]
              widgetMain.settings=newSet
            } else {
              myDialog.text=i18n.tr("Incorrect Image File")
              myDialog.visible=true
              importPage.activeConTransfer.finalize()
            }
            }
        }
Item {
    id: sketchlayer
    visible: false
    anchors.fill:parent
Rectangle {
    anchors.fill:parent
    color: theme.palette.normal.background
    opacity: 0.75
}
Rectangle {
    anchors.centerIn:parent
    width: units.gu(30)
    height: {childrenRect.height+units.gu(8.5)}
    color: theme.palette.normal.background
    border{
        color: theme.palette.normal.base
        width: units.gu(0.1)
        }
   radius: units.gu(1)
  OpenButton{
    id: sketch1
  anchors{
    left: parent.left
    leftMargin: units.gu(2)
    right: parent.right
    rightMargin: units.gu(2)
    top: parent.top
    topMargin: units.gu(1)
  }
  iconOffset: true
  iconSource: "img/terminal-app.svg"
  text: i18n.tr("Terminal")
    onClicked: {
      tx1.text=i18n.tr("Terminal")
      tx2.text="terminal://"
      color1.color="#383838"
      var newSet = [color1.color, tx1.text, widgetMain.linkcolor, "img/terminal-app.svg", tx2.text]
      widgetMain.settings=newSet
      sketchlayer.visible=false
    }
  }
  OpenButton{
    id: sketch2
  anchors{
    left: parent.left
    leftMargin: units.gu(2)
    right: parent.right
    rightMargin: units.gu(2)
    top: sketch1.bottom
    topMargin: units.gu(0.5)
  }
  iconOffset: true
  iconSource: "img/assets_calendar-app.png"
  text: i18n.tr("Calendar")
    onClicked: {
      tx1.text=i18n.tr("Calendar")
      tx2.text="calendar://"
      color1.color="#383838"
      var newSet = [color1.color, tx1.text, widgetMain.linkcolor, "img/assets_calendar-app.png", tx2.text]
      widgetMain.settings=newSet
      sketchlayer.visible=false
    }
  }
  OpenButton{
    id: sketch3
  anchors{
    left: parent.left
    leftMargin: units.gu(2)
    right: parent.right
    rightMargin: units.gu(2)
    top: sketch2.bottom
    topMargin: units.gu(0.5)
  }
  iconOffset: true
  iconSource: "img/desktop_gallery-app.svg"
  text: i18n.tr("Gallery")
    onClicked: {
      tx1.text=i18n.tr("Gallery")
      tx2.text="photo://"
      color1.color="#006ce3"
      var newSet = [color1.color, tx1.text, widgetMain.linkcolor, "img/desktop_gallery-app.svg", tx2.text]
      widgetMain.settings=newSet
      sketchlayer.visible=false
    }
  }
  OpenButton{
    id: sketch4
  anchors{
    left: parent.left
    leftMargin: units.gu(2)
    right: parent.right
    rightMargin: units.gu(2)
    top: sketch3.bottom
    topMargin: units.gu(0.5)
  }
  iconOffset: true
  iconSource: "img/app_weather-app.svg"
  text: i18n.tr("Weather")
    onClicked: {
      tx1.text=i18n.tr("Weather")
      tx2.text="weather://"
      color1.color="#006ce3"
      var newSet = [color1.color, tx1.text, widgetMain.linkcolor, "img/app_weather-app.svg", tx2.text]
      widgetMain.settings=newSet
      sketchlayer.visible=false
    }
  }
  OpenButton{
    id: sketch5
  anchors{
    left: parent.left
    leftMargin: units.gu(2)
    right: parent.right
    rightMargin: units.gu(2)
    top: sketch4.bottom
    topMargin: units.gu(0.5)
  }
  iconOffset: true
  iconSource: "img/app_graphics_music-app.svg"
  text: i18n.tr("Music")
    onClicked: {
      tx1.text=i18n.tr("Music")
      tx2.text="music://"
      color1.color="#ff1c47"
      var newSet = [color1.color, tx1.text, widgetMain.linkcolor, "img/app_graphics_music-app.svg", tx2.text]
      widgetMain.settings=newSet
      sketchlayer.visible=false
    }
  }
  OpenButton{
    id: sketch6
  anchors{
    left: parent.left
    leftMargin: units.gu(2)
    right: parent.right
    rightMargin: units.gu(2)
    top: sketch5.bottom
    topMargin: units.gu(0.5)
  }
  iconOffset: true
  iconSource: "img/Telegram_logo.svg"
  text: i18n.tr("Telegram")
    onClicked: {
      tx1.text=i18n.tr("Telegram")
      tx2.text="tg://"
      color1.color="#383838"
      var newSet = [color1.color, tx1.text, widgetMain.linkcolor, "img/Telegram_logo.svg", tx2.text]
      widgetMain.settings=newSet
      sketchlayer.visible=false
    }
  }
  OpenButton{
    id: sketch7
  anchors{
    left: parent.left
    leftMargin: units.gu(2)
    right: parent.right
    rightMargin: units.gu(2)
    top: sketch6.bottom
    topMargin: units.gu(1)
  }
  iconOffset: true
  iconSource: "img/reminders.svg"
  text: i18n.tr("Notes")
    onClicked: {
      tx1.text=i18n.tr("Notes")
      tx2.text="evernote://"
      color1.color="#fffb55"
      var newSet = [color1.color, tx1.text, widgetMain.linkcolor, "img/reminders.svg", tx2.text]
      widgetMain.settings=newSet
      sketchlayer.visible=false
    }
  }
  OpenButton{
  anchors{
    right: parent.right
    rightMargin: units.gu(2)
    bottom: parent.bottom
    bottomMargin: units.gu(1)
  }
  width: units.gu(16)
  iconOffset: true
  iconName: "close"
  text: i18n.tr("Cancel")
    onClicked: {
      sketchlayer.visible=false
    }
  }
}
}
}
