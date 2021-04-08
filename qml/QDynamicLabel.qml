import QtQuick 2.0

Item{
id: root
rotation: -main.needrot
property var sendi
property real wleft :0
property real wtop : 0
property real wwidth : 0
property real wheight : 0
property var object : false

anchors{
    top: parent.top
    topMargin: wtop
    left: parent.left
    leftMargin: wleft
}
height: wheight
width: wwidth
property real animopa
opacity: animopa/255
NumberAnimation on animopa {
alwaysRunToEnd: true
from: 0; to: 255;
}
onSendiChanged: {
        if (object== false)
        { console.log(sendi.fileName)
            var component = Qt.createComponent(sendi.fileName)
        if (component.status == Component.Ready) {
            object = component.createObject(root);
            if (sendi.settings.length>0)
                {object.settings = sendi.settings;}
        }else{
            component.statusChanged.connect(finishCreation);
        }
        }else{
        if (sendi.settings.length>0)
            {object.settings = sendi.settings;}
        }
    }

function finishCreation() {
    if (component.status == Component.Ready) {
        object = component.createObject(root);
        if (object == null) {
            console.log("Error creating object");
        }else{
            if (sendi.settings.length>0)
                {object.settings = sendi.settings;}
        }
    } else if (component.status == Component.Error) {
        console.log("Error loading component:", component.errorString());
    }
}
}

