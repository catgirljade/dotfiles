pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs
import qs.components
import qs.services

IconText {
    Layout.fillWidth: true
    font.pointSize: Constants.font.iconSize
    text: ""

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Hypr.dispatch(`exec swaync-client -t -sw`);
        }
    }
}
