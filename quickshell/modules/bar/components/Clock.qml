import QtQuick.Layouts
import QtQuick
import qs
import qs.components
import qs.services

RowLayout {
    Layout.fillWidth: true
    implicitHeight: parent.height
    spacing: 8

    Item {
        implicitHeight: parent.height
        implicitWidth: 24

        IconText {
            anchors.centerIn: parent
            text: ""
            color: Constants.nord9
        }
    }

    BarText {
        font.bold: true
        text: Time.format("hh:mm:ss")
        color: Constants.nord6
    }
}
