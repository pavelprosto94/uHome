import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Ubuntu.Components.Themes 1.3
import io.thp.pyotherside 1.3
import Ubuntu.Content 1.3
import QtGraphicalEffects 1.0

Page {
        id:root
        header: PageHeader {
            id: header
            title: "Edit Link"
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
        text: "Link name:"
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
        text: "Link URL:"
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
        text: "To test the link, you can click on the prototype widget at the top of the screen."
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
  text: "Import a picture for icon"
    onClicked: {
        stack.push(importPage)
    }
  }
  Text {
        id: label4
        text: "BackgroundColor:"
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
        text: "LinkColor:"
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
  text: "Sketch"
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
  text: "Save"
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
  text: "Cancel"
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
          console.log(colorValue)
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
              myDialog.text="Incorrect Image File"
              myDialog.visible=true
              importPage.activeConTransfer.finalize()
            }
            }
        }
Item {
    id: sketchlayer
    visible: false
    anchors.fill:parent

    property var sketch_icons : [ 
      "img/play.svg",
      "img/ubports.png",
      "img/terminal-app.svg",
      "img/assets_calendar-app.png",
      "img/address-book-app.png",
      "img/dialer-app.png",
      "img/messaging-app.png",
      "img/user.svg",
      "img/desktop_gallery-app.svg",
      "img/app_weather-app.svg",
      "img/app_graphics_music-app.svg",
      "img/reminders.svg",
      "img/Telegram_logo.svg",
      "img/dekko-app.png",
      "img/docviewer-app.png"
    ];
    property var sketch_tille : [
      "YouTube",
      "Forum",
      "Terminal",
      "Calendar",
      "Addressbook",
      "Telephone",
      "Messages",
      "Contact",
      "Gallery",
      "Weather",
      "Music",
      "Notes",
      "Telegram",
      "Dekko",
      "Documents"
    ]; 
    property var sketch_link : [
      "https://youtube.com",
      "https://forums.ubports.com/",
      "terminal://",
      "calendar://",
      "addressbook://",
      "dialer://",
      "message://",
      "tel://0.123456789",
      "photo://",
      "weather://",
      "music://",
      "evernote://",
      "tg://",
      "dekko://",
      "document://"
    ]
    property var sketch_color : [
      "#e32200",
      "#ffffff",
      "#383838",
      "#383838",
      "#383838",
      "#383838",
      "#383838",
      "#ff9c1c",
      "#006ce3",
      "#006ce3",
      "#ff1c47",
      "#fffb55",
      "#383838",
      "#d7efed",
      "#d7efed"
    ]


Rectangle {
    anchors.fill:parent
    color: theme.palette.normal.background
    opacity: 0.75
}
Rectangle {
    anchors.centerIn:parent
    width: units.gu(32)
    height: units.gu(42)
    color: theme.palette.normal.background
    border{
        color: theme.palette.normal.base
        width: units.gu(0.1)
        }
   radius: units.gu(1)

  GridView{
    id: grid
    anchors{
      top: parent.top
      left: parent.left
      right: parent.right
      bottom: sketch_close.top
      margins: units.gu(1)
    }
    clip: true
    cellWidth: units.gu(10); 
    cellHeight: units.gu(10); 
    model: sketchlayer.sketch_link
    delegate: Item {
    width: grid.cellWidth; 
    height: grid.cellHeight;
    Rectangle{
      id: rect;
      anchors{
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: units.gu(1)
      } 
      width: units.gu(6)
      height: units.gu(6)
      color: sketchlayer.sketch_color[index]
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
    source: sketchlayer.sketch_icons[index]
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
    text: sketchlayer.sketch_tille[index]
    color: theme.palette.normal.backgroundText
}

MouseArea{
  anchors.fill: parent
  onClicked: {
      tx1.text=sketchlayer.sketch_tille[index]
      tx2.text=sketchlayer.sketch_link[index]
      color1.color=sketchlayer.sketch_color[index]
      var newSet = [color1.color, tx1.text, widgetMain.linkcolor, sketchlayer.sketch_icons[index], tx2.text]
      widgetMain.settings=newSet
      sketchlayer.visible=false
    }
}
  }
  }
    
  OpenButton{
    id:sketch_close
  anchors{
    right: parent.right
    rightMargin: units.gu(2)
    bottom: parent.bottom
    bottomMargin: units.gu(1)
  }
  width: units.gu(16)
  iconOffset: true
  iconName: "close"
  text: "Cancel"
    onClicked: {
      sketchlayer.visible=false
    }
  }
}
}
}