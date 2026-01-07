import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

Rectangle {
    color: "#1e1e2e"
    radius: 16
    implicitHeight: 32
    implicitWidth: 96
    Text {
        id: cpuText
        color: "#f5c2e7"
        font.family: "Iosevka"
        anchors.centerIn: parent

        Process {
            id: cpuTextProcess
            command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | awk '{print $2}'"]
            running: true
            stdout: StdioCollector {
                onStreamFinished: cpuText.text =  `CPU:${this.text}%`
            }
        }
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: cpuTextProcess.running = true
        }
    }
}

