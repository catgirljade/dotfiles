import QtQuick.Layouts
import qs
import qs.components
import qs.services
import Quickshell.Services.UPower

RowLayout {
    id: contents
    spacing: 16

    RowLayout {
        Layout.fillWidth: true

        IconText {
            Layout.fillWidth: true
            text: ""
        }

        BarText {
            Layout.fillWidth: true

            property int perc: Math.round(SystemUsage.cpuPerc * 100)
            readonly property var colorMap: [[90, Constants.nord11], [75, Constants.nord12], [50, Constants.nord13], [-1, Constants.nord14],]

            font.bold: true
            text: perc.toString().padStart(2, "0") + "%"
            color: colorMap.find(x => perc > x[0])[1]
        }
    }

    RowLayout {
        Layout.fillWidth: true
        IconText {
            Layout.fillWidth: true
            text: ""
        }

        BarText {
            Layout.fillWidth: true

            property int perc: Math.round(SystemUsage.memPerc * 100)
            readonly property var colorMap: [[90, Constants.nord11], [75, Constants.nord12], [50, Constants.nord13], [-1, Constants.nord14],]

            font.bold: true
            text: perc.toString().padStart(2, "0") + "%"
            color: colorMap.find(x => perc > x[0])[1]
        }
    }

    RowLayout {
        Layout.fillWidth: true

        IconText {
            Layout.fillWidth: true
            property int perc: Math.round(UPower.displayDevice.percentage * 100)
            readonly property var iconMap: [[95, "󰁹"], [85, "󰂂"], [75, "󰂁"], [65, "󰂀"], [55, "󰁿"], [45, "󰁾"], [35, "󰁽"], [25, "󰁼"], [15, "󰁻"], [5, "󰁺"], [-1, "󰂎"]]
            text: iconMap.find(x => perc > x[0])[1]
        }

        BarText {
            Layout.fillWidth: true

            property int perc: Math.round(UPower.displayDevice.percentage * 100)
            readonly property var colorMap: [[50, Constants.nord14], [30, Constants.nord13], [20, Constants.nord12], [-1, Constants.nord11],]

            font.bold: true
            text: perc.toString().padStart(2, "0") + "%"
            color: colorMap.find(x => perc > x[0])[1]
        }

        BarText {
            Layout.fillWidth: true

            font.bold: true
            text: "%1".arg(UPower.onBattery ? "" : "󱐋")
        }

        BarText {
            Layout.fillWidth: true

            function formatSeconds(s: int, fallback: string): string {
                const day = Math.floor(s / 86400);
                const hr = Math.floor(s / 3600) % 60;
                const min = Math.floor(s / 60) % 60;

                let comps = [];
                if (day > 0)
                    comps.push(`${day} days`);
                if (hr > 0)
                    comps.push(`${hr}h`);
                if (min > 0)
                    comps.push(`${min}m`);

                return comps.join(" ") || fallback;
            }

            font.bold: true
            font.pointSize: Constants.font.smallSize
            text: UPower.onBattery ? formatSeconds(UPower.displayDevice.timeToEmpty, "...") : formatSeconds(UPower.displayDevice.timeToFull, "")
        }
    }
}
