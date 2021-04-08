import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Themes 1.3
import io.thp.pyotherside 1.3
import QtQuick.Layouts 1.3

Page {
        id:root
        header: PageHeader {
            id: header
            title: i18n.tr("    Add widget")
        Icon{
            anchors{
                left: parent.left
                top: parent.top
                topMargin: units.gu(1.5)
                bottom: parent.bottom
                bottomMargin: units.gu(1.5)
            }
            width: height
            name: "go-previous"
            color: theme.palette.normal.backgroundText
        }
        MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked:{ 
        stack.pop()
        }}}

Flickable {
    clip: true
    anchors{
          top: header.bottom
          left: parent.left
          right: parent.right
          bottom: parent.bottom
        }
      contentWidth: rectRoot.width
      contentHeight: rectRoot.height
      onFlickStarted:{
        if (widgetHubListModel.clickanimtarget!=null) {widgetHubListModel.clickanimtarget.visible=false}
        widgetHubListModel.enablmouse=false}
      onFlickEnded:{
        if (widgetHubListModel.clickanimtarget!=null) {widgetHubListModel.clickanimtarget.visible=false}
        widgetHubListModel.enablmouse=true
      }
    
    Rectangle {
    id :rectRoot
        width: root.width
        height: {childrenRect.height+units.gu(2)}
        color: theme.palette.normal.background
    Grid {
    topPadding: units.gu(2)
    anchors.horizontalCenter: parent.horizontalCenter
    columns: Math.round(mainView.width/units.gu(24))
    spacing: units.gu(2)
    horizontalItemAlignment: Grid.AlignHCenter
    verticalItemAlignment: Grid.AlignTop
    Repeater{
        model: widgetHubListModel
        delegate: WidgetHubItem{
            adrWidget: aW
            nameWidget: nW
            thumbnailWidget: tW
            xWidget: xW
            yWidget: yW
            index: ind
            }
        }
    }
    ListModel{
        id: widgetHubListModel
        property var clickanimtarget
        property int actIndex: 0
        property bool enablmouse: true;
    }
    }}

    Python {
        id: python_widgethub

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../src/'));
            setHandler('error', function(returnValue) {
                    myDialog.text = returnValue
                    myDialog.visible = true;
                });
            setHandler('addWidgetItem', function(returnValue) {
                    var newItem = {}
                    newItem.aW=returnValue[0]
                    newItem.nW=returnValue[1]
                    newItem.tW=returnValue[2]
                    newItem.xW=returnValue[3]
                    newItem.yW=returnValue[4]
                    newItem.ind=widgetHubListModel.actIndex
                    widgetHubListModel.actIndex+=1
                    widgetHubListModel.append(newItem)
                });
            importModule('widgethub', function() {
                console.log('module imported');
                python_widgethub.call('widgethub.load', [], function() {})
            });
        }
        onError: {
            myDialog.text = 'python error: ' + traceback
            myDialog.visible = true;
            console.log('python error: ' + traceback);
        }
    }
}