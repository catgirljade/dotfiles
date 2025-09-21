pragma ComponentBehavior: Bound

import QtQuick
import qs
import qs.components
import qs.services

Item {
    implicitWidth: 32

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
