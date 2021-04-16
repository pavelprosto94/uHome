import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Controls 2.2
import Ubuntu.Components.Themes 1.3
Item{
    id: root
    signal confirm
    property int colorlength: 16
    property color colorValue: Qt.hsla(rectPalette.selectIndex/10/colorlength,saturationSlider.value,(rectPalette.selectIndex%10)/9,alphaSlider.value)
    property color setColor: "#00000000"
    anchors.fill: parent

    onSetColorChanged:{
        if (setColor.hslHue>0)
        {rectPalette.selectIndex=Math.round(setColor.hslHue*10*colorlength)}
        else{rectPalette.selectIndex=Math.round(10*setColor.hslLightness)-1}
        saturationSlider.value=setColor.hsvSaturation
        var c = setColor.toString()
        if (c.length==9){
            alphaSlider.value=parseInt(c.substr(1, 2),16)/255
        }else{
            alphaSlider.value=1
        }
    }
Rectangle{
    anchors.fill: parent
    color: theme.palette.normal.background
    opacity: 0.5
}
Rectangle{
    anchors.centerIn: parent
    width: units.gu(40)
    height: units.gu(40)
    color: theme.palette.normal.background
    //clip: true
    radius: units.gu(0.5)
    border.width: units.gu(0.1); 
    border.color: theme.palette.normal.base
    Rectangle{
    id: layercolor
    anchors{
            top: parent.top
            topMargin: units.gu(2.5)
            left: parent.left
            leftMargin: units.gu(5)
        }
    width: units.gu(30)
    height: units.gu(30)
    color: theme.palette.normal.base
    //clip: true
    radius: units.gu(0.5)
    Flickable {
    id : flickBackground
    clip: true
    anchors{
            top: parent.top
            topMargin: units.gu(1)
            left: parent.left
            leftMargin: units.gu(1)
        }
    height: units.gu(28)
    width: units.gu(28)
    contentWidth: rectPalette.width
    contentHeight: rectPalette.height
      
    Item{
        id: rectPalette
        property int selectIndex: 0
        width: units.gu(28)
        height: root.colorlength*units.gu(2.9)
        //clip: true
        Repeater{
        id: backgroundmodel
        model: root.colorlength*10
        delegate: Rectangle{
            y: Math.floor(index/10)*units.gu(2.85)
            x: (index % 10)*units.gu(2.85)
            height: units.gu(2.3)
            width: units.gu(2.3)
            color: Qt.hsla(index/10/root.colorlength,saturationSlider.value,(index%10)/9,1)
            radius: units.gu(0.5)
            border.width: {if (rectPalette.selectIndex==index) {units.gu(0.2)} else {0}}
            border.color: {if (rectPalette.selectIndex==index) {theme.palette.normal.backgroundText} else {"transparent"}}
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    rectPalette.selectIndex=index
                    //console.log(colorValue)
                }
            }
        }
        }
    }}
    }
    Slider{
        id: saturationSlider
        from: 0
        to: 1
        anchors{
            top: layercolor.top
            bottom: layercolor.bottom
            bottomMargin: units.gu(3)
            left: parent.left
            right: layercolor.left
        }
        orientation : Qt.Vertical
        value: 1.0
        live: true
    }
    Icon{
        color : theme.palette.normal.base
        name : "image-quality"
        anchors{
            bottom: layercolor.bottom
            left: parent.left
            leftMargin: units.gu(1)
        }
        width: units.gu(3)
        height: width
    }
    Slider{
        id: alphaSlider
        from: 0
        to: 1
        anchors{
            top: layercolor.top
            bottom: layercolor.bottom
            bottomMargin: units.gu(3)
            right: parent.right
            left: layercolor.right
        }
        orientation : Qt.Vertical
        value: 1.0
        live: true
    }
    Icon{
        color : theme.palette.normal.base
        name : "grip-large"
        anchors{
            bottom: layercolor.bottom
            right: parent.right
            rightMargin: units.gu(1)
        }
        width: units.gu(3)
        height: width
    }
    Checkerboard{       
        anchors{
            left: parent.left
            leftMargin: units.gu(2)
            bottom: parent.bottom
            bottomMargin: units.gu(1.5)
        }
            height: units.gu(4)
            width: units.gu(6)
            color: colorValue
        }
    OpenButton{
        id: okButton
        anchors{
            right: cancelButton.left
            rightMargin: units.gu(2)
            bottom: parent.bottom
            bottomMargin: units.gu(1.5)
        }
        height: units.gu(4)
        width: units.gu(12)
        iconOffset: true
        iconName: "ok"
        text: "Apply"
            onClicked: {
            root.visible=false
            confirm()
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
        height: units.gu(4)
        width: units.gu(12)
        iconOffset: true
        iconName: "close"
        text: "Cancel"
            onClicked: {
            root.visible=false
            root.setColor= "#00000000"
            }
        }
}}