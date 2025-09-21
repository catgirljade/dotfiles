import QtQuick
import qs
import qs.components
import qs.services

Item {
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.margins: -8
    width: height

    IconText {
        anchors.centerIn: parent
        font.pointSize: Constants.font.iconSize
        text: ""

        MouseArea {
            anchors.fill: parent
            onClicked: {
                Hypr.dispatch(`exec swaync-client -t -sw`);
            }
        }
    }
}
