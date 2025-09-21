import QtQuick
import qs
import qs.components
import qs.services

Item {
    implicitWidth: icon.width

    IconText {
        id: icon
        anchors.centerIn: parent
        font.pointSize: Constants.font.iconSize
        text: ""

        MouseArea {
            anchors.fill: parent
            onClicked: {
                Hypr.dispatch(`exec rofi -show drun`);
            }
        }
    }
}
