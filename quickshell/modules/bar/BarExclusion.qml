import qs.components
import qs

BasicWindow {
    required property var bar
    name: "bar-border-exclusion"
    exclusiveZone: bar.height + Constants.outerPadding
    implicitWidth: 1
    implicitHeight: 1
}
