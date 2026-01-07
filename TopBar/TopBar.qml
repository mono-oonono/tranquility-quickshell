import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import "Widgets"

ShellRoot{
    PanelWindow{
        WlrLayershell.layer: WlrLayershell.Top
        anchors{
            top: true
            left: true
            right: true
        }
        margins{
            top: 4
            left: 4
            right: 4
            bottom: 4
        }
        height: 36
        color: "transparent"
        Rectangle{
            anchors.fill: parent
            radius: 16
            color: "#6c7086"
            opacity: 1
            Launcher{
                id: "launcher"
                anchors.leftMargin: 12
            }
            CpuWidget{
                id: "cpuWidget"
                anchors.left : launcher.right
                anchors.leftMargin: 8
            }
        }
    }
}