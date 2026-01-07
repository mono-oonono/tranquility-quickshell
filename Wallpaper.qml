import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            color: "Transparent"
            screen: modelData
            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }
            WlrLayershell.layer: WlrLayershell.Background
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.namespace: "wallpaper"
            Image {
                anchors.fill: parent
                source: "/home/mono/Pictures/Wallpapers/hollow-knight.png"
                fillMode: Image.PreserveAspectCrop
            }
        }
    }
}