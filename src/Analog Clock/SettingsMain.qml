import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Ubuntu.Components.Themes 1.3
import io.thp.pyotherside 1.3

Page {
        id:root
        header: PageHeader {
            id: header
            title: "Settings"
        }
        property var backgroundActions: []
        property var frontActions: []
    
    Rectangle{
        id: widget_thumbnail
        anchors{
            top: header.bottom
            left: parent.left
            right: parent.right
        }
        height: units.gu(20)
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
        text: "Background:"
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: parent.top
          topMargin: units.gu(2)
          left: parent.left
          leftMargin: units.gu(2)
        }
    }
    Sections {
        id: sections1
        selectedIndex: 0
        anchors{
          top: label1.bottom
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
          }
        model: backgroundActions
        width: parent.width
        onSelectedIndexChanged: {
          var newSet = [widgetMain.backgroundcolor, widgetMain.handcolor, backgroundActions[sections1.selectedIndex], widgetMain.glasssource]
            widgetMain.settings=newSet
        }
      }
    Text {
        id: label2
        text: "Front:"
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: sections1.bottom
          topMargin: units.gu(2)
          left: parent.left
          leftMargin: units.gu(2)
        }
    }
    Sections {
        id: sections2
        selectedIndex: 0
        anchors{
          top: label2.bottom
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
          }
        model: frontActions
        width: parent.width
        onSelectedIndexChanged: {
            var newSet = [widgetMain.backgroundcolor, widgetMain.handcolor, widgetMain.arrowsource, frontActions[sections2.selectedIndex]]
            widgetMain.settings=newSet
        }
      }
    Text {
        id: label3
        text: "BackgroundColor:"
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: sections2.bottom
          topMargin: units.gu(3)
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
        }

        Rectangle{
          border.width: units.gu(0.2); 
          border.color: theme.palette.normal.base
          color: "transparent"
          anchors{
            right: parent.right
            top: parent.top
            topMargin: -units.gu(0.5)
            bottom: parent.bottom
            bottomMargin: -units.gu(0.5)
          }
          width: units.gu(5)
          Checkerboard{
            cellSide: units.gu(0.5)
          }
          Rectangle{
            id: color1
            anchors.fill: parent
            border.width: units.gu(0.2); 
            border.color: theme.palette.normal.base
            onColorChanged: {
              var newSet = [color.toString().toUpperCase(), widgetMain.handcolor, widgetMain.arrowsource, widgetMain.glasssource]
              widgetMain.settings=newSet
            }
         }
          MouseArea{
            anchors.fill: parent
            onClicked:{
              colorPicker.obj_target=color1
              colorPicker.visible=true
            }
          }
        }
    } 
    Text {
        id: label4
        text: "HandColor:"
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: label3.bottom
          topMargin: units.gu(3)
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
        }
        Rectangle{
          border.width: units.gu(0.2); 
          border.color: theme.palette.normal.base
          color: "transparent"
          anchors{
            right: parent.right
            top: parent.top
            topMargin: -units.gu(0.5)
            bottom: parent.bottom
            bottomMargin: -units.gu(0.5)
          }
          width: units.gu(5)
          Checkerboard{
            cellSide: units.gu(0.5)
          }
          Rectangle{
            id: color2
            anchors.fill: parent
            border.width: units.gu(0.2); 
            border.color: theme.palette.normal.base
            onColorChanged: {
              var newSet = [widgetMain.backgroundcolor, color.toString().toUpperCase(), widgetMain.arrowsource, widgetMain.glasssource]
              widgetMain.settings=newSet
            }
         }
          MouseArea{
            anchors.fill: parent
            onClicked:{
              colorPicker.obj_target=color2
              colorPicker.visible=true
            }
          }
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
      waitScreen.visible=false
      var tosend = widgets.get(widgets.target_obj).snd
      var newSet = [widgetMain.backgroundcolor, widgetMain.handcolor, widgetMain.arrowsource, widgetMain.glasssource]
      tosend.settings = newSet
      widgets.get(widgets.target_obj).snd=tosend
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
        }
    }

Python {
        id: python
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./'));
            setHandler('error', function(returnValue) {
                    myDialog.text = returnValue
                    myDialog.visible = true;
                });
            importModule('settingsmain', function() {
                console.log('module imported');
                python.call('settingsmain.getBackgrounds', [], function(returnValue) {
                    root.backgroundActions=returnValue
                    python.call('settingsmain.getFronts', [], function(returnValue) {
                    root.frontActions=returnValue
                    var tmp=widgets.get(widgets.target_obj).snd
                    if (tmp.settings.length>0){
                      widgetMain.settings=tmp.settings
                    }
                    color1.color= widgetMain.backgroundcolor
                    color2.color= widgetMain.handcolor
                    for (var j = 0; j < backgroundActions.length; j++)
                      if (widgetMain.arrowsource==backgroundActions[j])
                        {
                          sections1.selectedIndex=j
                          break
                        }
                    for (var j = 0; j < frontActions.length; j++)
                      if (widgetMain.glasssource==frontActions[j])
                        {
                          sections2.selectedIndex=j
                          break
                        }
                  })
                })
            });
        }
        onError: {
            myDialog.text = 'python error: ' + traceback
            myDialog.visible = true;
            console.log('python error: ' + traceback);
        }
    }
}