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

    Logo {
        id: logo
        anchors.bottom: bar.bottom
    }

    Workspaces {
        anchors.left: logo.right
    }

    Active {
        maxWidth: bar.width / 3
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Tray {
        anchors.right: notifs.left
    }

    Notif {
        id: notifs
        anchors.right: perf.left
        anchors.rightMargin: 8
    }

    Perf {
        id: perf
        anchors.right: clock.left
        anchors.rightMargin: 8
    }

    Clock {
        id: clock
        anchors.right: parent.right
        anchors.rightMargin: 8
    }
}
