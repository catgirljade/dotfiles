import QtQuick.Layouts
import qs
import qs.components
import qs.modules.bar.components

Bar {
    id: bar
    screen: screen
    y: Constants.outerPadding
    height: Constants.topBarHeight

    BarExclusion {
        bar: bar
        anchors.top: true
    }

    RowLayout {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 12
        spacing: 12

        Logo {}

        Workspaces {}
    }

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        spacing: 16

        Clock {}

        BarRect {
            Layout.fillHeight: true
            Layout.margins: -2
            color: Constants.nord2
            implicitWidth: active.implicitWidth + 24

            Active {
                id: active
                maxWidth: bar.width / 3
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Date {}
    }

    RowLayout {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        spacing: 8

        Tray {}

        Notif {}

        Seperator {}

        Perf {}
    }
}
