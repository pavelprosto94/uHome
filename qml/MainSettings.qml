import QtQuick 2.7
import QtQuick.Controls 2.2
import Ubuntu.Components 1.3
import Ubuntu.Components.Themes 1.3
import io.thp.pyotherside 1.3
import "./constants.js" as Constants

Page { 
  id: root
  property int oldpos1: 0

header: PageHeader {
        title: i18n.tr("Settings")
    }
Flickable {
    clip: true
    anchors{
          top: root.header.bottom
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
        text: i18n.tr("Programm theme:")
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: parent.top
          topMargin: units.gu(2)
          left: parent.left
          leftMargin: units.gu(2)
        }
    }
    property var thememodel: [
        i18n.tr("System"),
        "Suru Light" ,
        "Suru Dark"
        ]
    property var themeval: [
      Constants.Theme.System ,
      Constants.Theme.SuruLight,
      Constants.Theme.SuruDark 
    ]
    OptionSelector {
      id: themeSelect
        anchors{
          top: label1.bottom
          topMargin: units.gu(1)
          left: parent.left
          leftMargin: units.gu(2)
          right: parent.right
          rightMargin: units.gu(2)
        }
            model: parent.thememodel
              Component.onCompleted: {
                themeSelect.selectedIndex = _getIndexByTheme(settings.theme)
                root.oldpos1=themeSelect.selectedIndex
              }
              function _getIndexByTheme(themeId) {
                return themeId
              }
            //textRole: "text"
            onSelectedIndexChanged: {
              settings.theme = parent.themeval[selectedIndex]
            }
    }
    Text {
        id: label2
        text: i18n.tr("Background:")
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: themeSelect.bottom
          topMargin: units.gu(2)
          left: parent.left
          leftMargin: units.gu(2)
        }
    }
Text {
        id: label3
        text: {
        settings.background_source.substr(settings.background_source.lastIndexOf("/")+1,settings.background_source.length)
        }
        color: theme.palette.normal.backgroundText
        font.pixelSize: units.gu(2)
        anchors{
          top: label2.bottom
          topMargin: units.gu(2)
          left: parent.left
          leftMargin: units.gu(2)
          right: backgroundButton.left
          rightMargin: units.gu(1)
        }
        horizontalAlignment : Text.AlignRight
    }
OpenButton{
  id: backgroundButton
  anchors{
    right: parent.right
    rightMargin: units.gu(2)
    top: label2.bottom
    topMargin: units.gu(1)
  }
  width: units.gu(16)
  iconOffset: true
  iconName: "close"
  text: i18n.tr("Change")
    onClicked: {
      stack.push("BackgroundSettings.qml")
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
    onClicked: {
      //main.activeTheme=parseInt(settings.theme)
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
      themeSelect.selectedIndex=root.oldpos1
      stack.pop()
    }
  }
}