import QtQuick.Layouts
import qs
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

    Active {
        maxWidth: bar.width / 3
        anchors.horizontalCenter: parent.horizontalCenter
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

        Seperator {}

        Clock {}
    }
}
