import QtQuick 2.7
import QtQuick.Controls 2.2
import Ubuntu.Components 1.3
import Ubuntu.Components.Themes 1.3
import io.thp.pyotherside 1.3

Page { 
  id: root
  property int srcindback: 0
  property var srcttl: [
i18n.tr("By preferring soda-free pastries, you help preserve the beauty of the mountains.<br><i>photographer - Rasmus Smidstrup Mortensen</i>"),
i18n.tr("About 12 million tons of plastic waste gets into the world's oceans every year. We choose a reusable alternative and admire its beauty.<br><i>photographer - Amelia Barkland</i>"),
i18n.tr("An amazing fact, but away from the city smog, you can see the stars. And they are beautiful!<br><i>photographer - YAN CHEN</i>"),
i18n.tr("Snow-white can't help but fascinate. It is terrible to imagine that such beauty can be blackened by oil.<br><b>#StopOilSpills</b> <i>photographer - Julia Lapshina</i>"),
i18n.tr("The waterfalls seem endless and so strong, but because of deforestation, they also become shallow.<br><i>photographer - Ivana Caine</i>"),
i18n.tr("What does global warming look like? This is when the snow-capped mountains cease to be so, and perhaps forever.<br><i>photographer - Eberhard Grossgasteiger</i>")
]
header: PageHeader {
        title: i18n.tr("Background settings:")
    }

Flickable {
    id : flickBackground
    clip: true
    anchors{
          top: root.header.bottom
          left: parent.left
          right: parent.right
        }
        height: units.gu(34)
      contentWidth: rectRoot.width
      contentHeight: rectRoot.height
      property int oldthisindex: -1
  onFlickEnded: {
      contentX=Math.round(contentX/units.gu(18))*units.gu(18)
  }
  onContentXChanged: {
    var thisindex=Math.round(contentX/units.gu(18))
    if (oldthisindex!=thisindex){
      oldthisindex=thisindex
    if ((thisindex>=root.srcindback) && (thisindex-root.srcindback<srcttl.length)){
      lbl1.text=srcttl[thisindex-root.srcindback]
      if (backgroundlist.get(thisindex).src.indexOf(".g.jpg")>-1)
      {
        headerTitle.enabl=true
      } else {
        headerTitle.enabl=false
      }
    }else{
      headerTitle.enabl=false
      if ((thisindex>=0) && (thisindex<backgroundlist.count)){
        var txt=backgroundlist.get(thisindex).src.toString()
        lbl1.text=txt.substr(txt.lastIndexOf("/")+1,txt.length)
      }else{
        lbl1.text=""
      }
    }
    }
  }
  Rectangle {
    id :rectRoot
        width: units.gu(18)
        height: units.gu(34)
        color: theme.palette.normal.background
    ListModel {
    id: backgroundlist
    ListElement {src: "../src/Backgrounds/IMG_9136.jpg"}
    ListElement {src: "../src/Backgrounds/IMG_9137.jpg"}
    ListElement {src: "../src/Backgrounds/IMG_9135.jpg"}
    ListElement {src: "../src/Backgrounds/ec_0f0NsuXw.jpg"}
    ListElement {src: "../src/Backgrounds/IMG_7945.jpg"}
    ListElement {src: "../src/Backgrounds/IMG_7943.jpg"} 
    }
    Repeater{
        id: backgroundmodel
        model: backgroundlist
        delegate: Image{
            y: units.gu(1)+(units.gu(32)-height)/2
            x: (root.width-units.gu(18))/2+units.gu(18)*index+(units.gu(18)-width)/2
            height: units.gu(32)*(0.5+opacity*0.5)
            width: units.gu(18)*(0.5+opacity*0.5)
            fillMode: Image.PreserveAspectCrop
            source: src
            opacity: {
                if (units.gu(18)*index-flickBackground.contentX>0){
                    if (units.gu(18)*index-flickBackground.contentX<units.gu(1))
                    {1}else
                    if (units.gu(18)*index-flickBackground.contentX<units.gu(18*3))
                    {1-(units.gu(18)*index-flickBackground.contentX)/units.gu(18*3)}
                    else{0}
                }else{
                    if (units.gu(18)*index-flickBackground.contentX>-units.gu(1))
                    {1}else
                    if (units.gu(18)*index-flickBackground.contentX>-units.gu(18*3))
                    {1-(units.gu(18)*index-flickBackground.contentX)/units.gu(18*3)*-1}
                    else{0}
                }
            }
        }
    }
    Component.onCompleted: {
        getListBackgrounds()
    }
  }}
  Item{
    id: headerTitle
    property bool enabl: false
    anchors{
      top: flickBackground.bottom
      left: parent.left
      right: parent.right
    }
    height: childrenRect.height+units.gu(1.5)
    Text{
      id: lbl1
      color: theme.palette.normal.backgroundText
      font.pixelSize: units.gu(1.5)
      anchors{
        top: parent.top
        topMargin: units.gu(1)
        left: parent.left
        leftMargin: units.gu(3)
        right: parent.right
        rightMargin: units.gu(3)
      }
      textFormat: Text.StyledText
      text: ""
      wrapMode: Text.WordWrap
      horizontalAlignment: Text.AlignHCenter
    }
  }
  Rectangle {
        id: hedrline
        height: units.gu(0.1)
        color: theme.palette.normal.base
        anchors.top: headerTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }
OpenButton{
  id: iconChooseButton
  anchors{
    top: hedrline.bottom
    topMargin: units.gu(2)
    left: parent.left
    leftMargin: units.gu(2)
    right: parent.right
    rightMargin: units.gu(2)
  }
  iconOffset: true
  iconName: "insert-image"
  text: i18n.tr("Import user picture")
    onClicked: {
        stack.push(importPage)
    }
  }
  OpenButton{
  id: iconExportButton
  anchors{
    top: iconChooseButton.bottom
    topMargin: units.gu(2)
    left: parent.left
    leftMargin: units.gu(2)
    right: parent.right
    rightMargin: units.gu(2)
  }
  iconOffset: true
  iconName: "save-to"
  text: i18n.tr("Export select background")
    onClicked: {
        exportPage.url=backgroundlist.get(Math.round(flickBackground.contentX/units.gu(18))).src
        stack.push(exportPage)
    }
  }
Connections {
            target: importPage
            onImported: { 
            if (fileUrl.indexOf(".png") || fileUrl.indexOf(".jpg") || fileUrl.indexOf(".jpeg"))
            {   
                var dir = "/home/phablet/.cache/uhome.pavelprosto/Backgrounds/"
                var namefile = importPage.activeTransfer.items[0].url.toString()
                namefile=namefile.substr(namefile.lastIndexOf("/")+1,namefile.length);
                namefile=dir+namefile
                python_main.call('main.fileexists', [namefile], function(returnValue) {
                    var dir = "/home/phablet/.cache/uhome.pavelprosto/Backgrounds/"
                    var namefile = importPage.activeTransfer.items[0].url.toString()
                    namefile=namefile.substr(namefile.lastIndexOf("/")+1,namefile.length);
                    namefile=dir+namefile
                    if (importPage.activeTransfer.items[0].move(dir)==false && returnValue==false )
                    {
                        myDialog.text=i18n.tr("Failed import file: "+namefile)
                        myDialog.visible=true
                    }else{
                        importPage.activeTransfer.finalize();
                        getListBackgrounds();
                    }
                });
            } else {
              myDialog.text=i18n.tr("Incorrect Image File")
              myDialog.visible=true
              importPage.activeConTransfer.finalize()
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
    onClicked: {
        python_main.call('main.getBackground', [backgroundlist.get(Math.round(flickBackground.contentX/units.gu(18))).src], function(returnValue) {
        main.settings.background_source=returnValue
        python_main.saveWidgets()
        });
      stack.pop()
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

function getListBackgrounds(){
    //backgroundlist.clear()
    if (root.srcindback>0){
      backgroundlist.remove(0,root.srcindback)
    }
    python_main.call('main.getListFiles', ["/home/phablet/.cache/uhome.pavelprosto/Backgrounds/","."], function(returnValue) {
      root.srcindback=0
        for (var i=0; i< returnValue.length; i++)
        if (returnValue[i]!="")
        {
            var newItem={}
            newItem.src="/home/phablet/.cache/uhome.pavelprosto/Backgrounds/"+returnValue[i]
            backgroundlist.insert(0,newItem)
        }
        root.srcindback=returnValue.length
        if (returnValue.length==0){
          headerTitle.enabl=true
          lbl1.text=srcttl[0]
        }else{
          lbl1.text=returnValue[returnValue.length-1]
        }
        rectRoot.width=root.width+units.gu(18)*(backgroundlist.count-1)
    });
}
}