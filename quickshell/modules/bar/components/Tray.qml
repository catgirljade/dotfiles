pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

RowLayout {
    id: root
    implicitWidth: repeater.width

    Repeater {
        id: repeater
        model: SystemTray.items

        Loader {
            id: loader
            required property SystemTrayItem modelData

            active: true
            sourceComponent: item
            property Component item: TrayItem {
                modelData: loader.modelData
            }
        }
    }
}
