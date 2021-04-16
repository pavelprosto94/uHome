import QtQuick 2.7

Rectangle{
    id: root
    property int index: -1
    property string adrWidget
    property string nameWidget
    property string thumbnailWidget
    property int xWidget
    property int yWidget
    clip: true
    width: units.gu(20)
    height: units.gu(22)
    color: theme.palette.normal.background
    radius: units.gu(0.5)
    border{
        color: theme.palette.normal.base
        width: units.gu(0.25)
    }
    Image{
        id: im1
        source: thumbnailWidget
        fillMode: Image.PreserveAspectFit
        clip: true
        anchors{
            right: parent.right
            left: parent.left
            top: parent.top
            margins: units.gu(1)
        }
    }
    Text{
        id: tx1
        anchors{
            top: im1.bottom
            horizontalCenter: parent.horizontalCenter
        }
        text: nameWidget
        font.pixelSize: units.gu(2)
        color: theme.palette.normal.backgroundText
    }
    Rectangle{
        id: clickanim
        visible: false
        anchors.fill: parent
        color: theme.palette.normal.base
        opacity: 0.5
    }
    MouseArea{
        id: itemAreaM
        property bool enblcon: false
        anchors.fill: parent
        onPressed: {
        if (widgetHubListModel.enablmouse) {
            widgetHubListModel.clickanimtarget=clickanim
            clickanim.visible=true
        }}
        onClicked:{
            if (widgetHubListModel.enablmouse) {
                stack.pop()
                var newItem = {}
                var sttngs = []
                newItem.ww=units.gu(10)*xWidget
                newItem.wh=units.gu(10)*yWidget
                newItem.xl=units.gu(20)-newItem.ww/2
                newItem.yl=units.gu(30)-newItem.wh/2
                newItem.snd={fileName: adrWidget, settings: sttngs}
                widgets.append(newItem)
                python_main.saveWidgets()
        }
        clickanim.visible=false
        }
        Connections {
            enabled: itemAreaM.enblcon
            target: myDialog
            onClicked: { 
            itemAreaM.enblcon=false
            python_widgethub.call('widgethub.removeWidget', [adrWidget], function(returnValue) {
                if (returnValue=="")
                {
                    for (var i = 0; i < widgetHubListModel.count; i++){
                        if (widgetHubListModel.get(i).ind==index){
                            widgetHubListModel.remove(i)
                            break
                        }
                    }
                }else{
                    myDialog.text=returnValue
                    myDialog.visible=true
                }
            })    
            }
        }
        onPressAndHold:{
            if (widgetHubListModel.enablmouse) {
                if (adrWidget.indexOf("click.ubuntu.com")==-1) {
                    myDialog.text = i18n.tr("Are you sure to remove this widget?")
                    myDialog.okbutton = true;
                    myDialog.oktext = i18n.tr("Yes")
                    myDialog.button = i18n.tr("No")
                    myDialog.visible = true;
                    itemAreaM.enblcon=true
                } else {
                    myDialog.text=i18n.tr("This widget cannot be deleted.")
                    myDialog.visible=true
                }
            }
        }
        onReleased:{
            clickanim.visible=false
        }
    }
}
