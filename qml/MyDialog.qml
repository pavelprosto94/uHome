/*  CalculatorButton.qml */
import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Themes 1.3

Item {
    id: root
    signal clicked
    property alias text: label.text
    property alias button: closebut.text
    property alias okbutton: okbut.visible
    property string oktext: i18n.tr("Ok")
    Rectangle {
    anchors.fill:parent
    color: theme.palette.normal.background
    opacity: 0.75

    MouseArea {
        anchors.fill: parent
        onClicked:{ 
        }
        }
    }
        Rectangle {
            width: units.gu(35)
            height: units.gu(25)
            anchors{
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            color: theme.palette.normal.background
            border.color: theme.palette.normal.foreground
            radius: units.gu(1)
            border.width: units.gu(0.1)

        Text {
            id: label
            text: ""
            anchors{
            right: parent.right
            left: parent.left
            bottom: closebut.top
            top: parent.top
            }
            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
            font.pixelSize: units.gu(2)
            padding: units.gu(1)
            wrapMode : Text.Wrap
            color: theme.palette.normal.backgroundText
        }
        Button {
        id: closebut
        text: i18n.tr("Close")
        anchors{
            right: parent.right
            rightMargin: units.gu(2)
            bottom: parent.bottom
            bottomMargin: units.gu(1.5)
        }
        onClicked: {
            okbut.visible = false;
            closebut.text = i18n.tr("Close")
            root.visible = false;
        }
        }
        Button {
        id: okbut
        visible: false
        text: root.oktext
        color: UbuntuColors.green
        anchors{
            left: parent.left
            leftMargin: units.gu(2)
            bottom: parent.bottom
            bottomMargin: units.gu(1.5)
        }
        onClicked: {
            okbut.visible = false;
            closebut.text = i18n.tr("Close")
            root.visible = false;
            root.clicked();
        }
        }
        }
}