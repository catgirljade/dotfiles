import QtQuick.Layouts
import QtQuick
import qs
import qs.components
import qs.services

RowLayout {
    id: contents
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.margins: -4
    spacing: 8

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

    BarRect {
        Layout.fillWidth: true
        color: Constants.nord2

        implicitWidth: time.width + 12
        implicitHeight: parent.height

        RowLayout {
            id: time
            Layout.fillWidth: true
            implicitHeight: parent.height

            Item {} // spacing

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
        }
    }
}
