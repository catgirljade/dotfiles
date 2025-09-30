pragma ComponentBehavior: Bound

import qs.components
import Quickshell
import Quickshell.Wayland
import QtQuick
import qs
import qs.modules.bar

Variants {
    model: Quickshell.screens

    Scope {
        id: scope

        required property ShellScreen modelData

        BasicWindow {
            id: win
            screen: scope.modelData
            name: "bars"
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            // TODO:
            // WlrLayershell.keyboardFocus: visibilities.launcher || visibilities.session ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

            mask: Region {
                intersection: Intersection.Combine
                regions: [
                    Region {
                        item: topBar
                    }
                ]
            }

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            Item {
                id: winDummy
                x: 0
                y: 0
                width: win.width
                height: win.height
            }

            TopBar {
                id: topBar
                screen: win.screen
                window: win
            }
        }
    }
}
