pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick.Controls
import QtQuick.Layouts
import qs.components
import qs.components
import Quickshell
import QtQuick
import qs

PopupWindow {
    required property real win
    anchor.window: win
    visible: true

    color: Constants.nord0

    anchor.rect.w: 700
    anchor.rect.h: 500
    implicitWidth: 700
    implicitHeight: 500

    ColumnLayout {
        TextField {
            id: search

            implicitWidth: 300
            implicitHeight: 30

            placeholderText: "Search"
        }

        ListView {
            implicitWidth: 300
            implicitHeight: 500

            model: DesktopEntries.applications.values.filter(a => a.name.includes(search.text))

            delegate: RowLayout {
                id: element
                required property DesktopEntry modelData

                IconImage {
                    implicitSize: 24

                    source: Constants.icons.getAppIcon(element.modelData.name, "package-broken")
                    implicitHeight: Constants.font.normalSize + 4
                }

                BarText {
                    text: element.modelData.name
                }
            }
        }
    }
}
