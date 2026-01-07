import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

ShellRoot {
    property bool menuOpen: false
        Process {
            id: ollamaProcess
            property string userMsg: ""
                command: ["python3", "/home/aditya/.config/quickshell/ollama_chat.py", userMsg]
                stdout: StdioCollector{
                    onStreamFinished: chatroom_dropdown.terminalLog += ("\n" + "ollama" + `<font color='#fab387'>${this.text}</font>`)
                   // onStreamFinished: console.log(`line read ${this.text}`)
        }
    }
    PanelWindow {
        id: chatroom
        width: 40
        height: 40
        color: "transparent"
        anchors {
            left: true
            top: true
        }
        margins {
            left: 10
            // the extra top margin is due to a seperate bar in a different config
            top: 50
        }

        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayershell.Bottom

        Rectangle {
            anchors.fill: parent
            implicitWidth: 40
            implicitHeight: 40
            radius: 5
            color: "#1e1e2e"
            opacity: 0.6

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                // Fixed double onClicked syntax error
                onClicked: menuOpen = !menuOpen
            }
        }
    }

    PanelWindow {
        id: chatroom_dropdown
        visible: menuOpen

        property string terminalLog: "welcome! \n"

            Image {
                source: "/home/aditya/.config/quickshell/Be8aj5NEXJ1gm8Rl6Qdc3.webp"
                opacity: 1
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
            }

            width: chatroom.width + 10 + projects_thing.width
            height: 640
            color: "transparent"
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
            WlrLayershell.layer: WlrLayershell.Bottom

            anchors { top: true; left: true }
            margins {
                top: chatroom.height + 60
                left: 10
            }

            Rectangle {
                anchors.fill: parent
                radius: 5
                color: "#1e1e2e"
                opacity: 0.9

                Column {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 10

                    Text {
                        text: "ollama"
                        color: "#fab387"
                        font.bold: true; font.family: "Lexend"; font.pixelSize: 12
                    }

                    Flickable {
                        id: logFlickable
                        width: parent.width
                        height: parent.height - 100
                        contentHeight: logText.height
                        clip: true

                        // Auto-scroll logic
                        onContentHeightChanged: logFlickable.contentY = contentHeight - height

                        Text {
                            id: logText
                            width: parent.width
                            text: chatroom_dropdown.terminalLog
                            color: "#cdd6f4"
                            font.family: "Iosevka Light"
                            font.pixelSize: 13
                            wrapMode: Text.WordWrap
                            // 2. Enable HTML-style tags (<b>, <i>, <font>)
                            textFormat: Text.StyledText
                        }
                    }

                    Rectangle {
                        implicitWidth: parent.width
                        implicitHeight: 40
                        color: "#313244"
                        radius: 5

                        TextInput {
                            id: commandInput
                            anchors.fill: parent
                            anchors.margins: 10
                            color: "white"
                            font.family: "iosevka Light"
                            focus: menuOpen


                            Keys.onReturnPressed: {
                                if (text.trim() !== "" && !ollamaProcess.running)
                                {
                                    let userMsg = text.trim();
                                    chatroom_dropdown.terminalLog += "<b>You:</b> " + userMsg + "\n";
                                    chatroom_dropdown.terminalLog += "<i>ollama is thinking...</i>\n";
                                    ollamaProcess.userMsg = userMsg;
                                    ollamaProcess.running = true;

                                    text = "";
                                }
                            }
                        }
                    }
                }
            }
        }

        PanelWindow {
            id: projects_thing
            width: 340
            height: 40
            color: "transparent"

            anchors {
                top: true
                left: true
            }
            margins {
                left: chatroom.width + 20
                top: 50
            }

            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayershell.Bottom

            Rectangle {
                anchors.fill: parent
                implicitWidth: 340
                implicitHeight: 40
                radius: 5
                color: "#1e1e2e"
                opacity: 0.6

                Text {
                    anchors.centerIn: parent
                    text: "projects"
                    color: "#cdd6f4"
                    font.family: "Lexend"
                    font.pixelSize: 20
                }
            }
        }
    }