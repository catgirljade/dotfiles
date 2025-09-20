import QtQuick.Layouts
import QtQuick
import qs
import qs.components
import qs.services

RowLayout {
    id: contents
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.margins: 4

    Item {
        implicitHeight: parent.height
        implicitWidth: 32

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

    Item {
        implicitHeight: parent.height
        implicitWidth: 32

        IconText {
            anchors.centerIn: parent
            text: "󰃭"
            color: Constants.nord9
        }
    }

    BarText {
        font.bold: true
        text: new Date().toLocaleDateString()
        color: Constants.nord6
    }
}
