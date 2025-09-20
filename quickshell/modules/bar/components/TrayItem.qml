import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

Item {
    id: root
    required property SystemTrayItem modelData

    implicitWidth: 24
    implicitHeight: 20
    IconImage {
        // source: modelData.icon
        implicitWidth: 24
        implicitHeight: 24
        mipmap: true
        anchors.centerIn: parent
        // source: root.modelData.icon
        smooth: false
        asynchronous: true
        backer.fillMode: Image.PreserveAspectFit
        source: {
            let icon = root.modelData.icon;
            // Process icon path
            if (icon.includes("?path=")) {
                const [name, path] = icon.split("?path=");
                const fileName = name.substring(name.lastIndexOf("/") + 1);
                return `file://${path}/${fileName}`;
            }
            return icon;
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: event => {
            switch (event.button) {
            case Qt.LeftButton:
                root.modelData.activate();
                break;
            case Qt.RightButton:
                if (root.modelData.hasMenu) {
                    const window = QsWindow.window;
                    // [TODO] The bellow is kinda hard coded, find a better solution
                    //
                    const widgetRect = window.contentItem.mapFromItem(root, 5, root.height - 20, root.width, root.height);
                    menuAnchor.anchor.rect = widgetRect;
                    menuAnchor.open();
                }
                break;
            }
        }
    }

    QsMenuAnchor {
        id: menuAnchor

        menu: root.modelData.menu

        anchor.window: root.QsWindow.window ?? null
        anchor.adjustment: PopupAdjustment.Flip
    }
}
