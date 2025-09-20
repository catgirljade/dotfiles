pragma ComponentBehavior: Bound

import qs.components
import Quickshell.Widgets
import QtQuick

IconImage {
    id: root

    required property color colour
    property color dominantColour

    asynchronous: true

    layer.enabled: true
    layer.effect: Colouriser {
        sourceColor: root.dominantColour
        colorizationColor: root.colour
    }
}
