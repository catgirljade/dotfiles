pragma ComponentBehavior: Bound
import QtQuick
import qs.components
import qs
import qs.services
import QtQuick.Layouts

Item {
    id: root
    Layout.margins: -4
    Layout.fillHeight: true
    implicitWidth: container.implicitWidth

    BarRect {
        anchors.fill: container
        color: Constants.nord3
    }

    BarRect {
        id: activeDisplay
        property real currentWsIdx: Hypr.activeWsId - 1
        property Item rect: entries.itemAt(currentWsIdx)

        property point childPos: root.mapFromItem(rect, 0, 0)

        // janky as fuck

        x: childPos.x
        y: childPos.y
        height: rect?.height ?? 0
        width: height
        color: Constants.nord4
        radius: width / 2

        Behavior on x {
            Anim {
                easing.bezierCurve: Constants.animCurves.emphasized
            }
        }

        layer.enabled: true
    }

    Item {
        id: container
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: contents.implicitWidth

        RowLayout {
            id: contents
            anchors.fill: parent
            anchors.margins: -2
            spacing: 0

            Repeater {
                id: entries
                model: ["", "", "", "󰈮", "", "", "", "", "", ""]
                Item {
                    id: entry
                    required property int index
                    required property string modelData
                    implicitHeight: parent.height
                    implicitWidth: implicitHeight

                    property color color: activeDisplay.currentWsIdx == index ? Constants.nord0 : Constants.nord6

                    Loader {
                        active: entry.modelData != ""
                        anchors.fill: parent
                        sourceComponent: Item {
                            anchors.fill: parent

                            IconText {
                                text: entry.modelData
                                anchors.centerIn: parent
                                color: entry.color
                            }
                        }
                    }

                    Loader {
                        active: entry.modelData == ""
                        anchors.fill: parent
                        sourceComponent: Item {
                            anchors.fill: parent

                            BarText {
                                font.bold: true
                                text: ""
                                anchors.centerIn: parent
                                color: entry.color
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            Hypr.dispatch(`workspace ${entry.index + 1}`);
                        }
                    }
                }
            }
        }
    }
}
