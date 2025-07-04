import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import ChessAnalyzer 1.0

ScrollView {
    id: root
    
    property var parentWindow
    
    signal analysisRequested(string username)
    signal playerClicked(string username)
    
    Rectangle {
        color: "#000000"
        implicitWidth: root.width
        implicitHeight: mainColumn.implicitHeight + 40
        
        ColumnLayout {
            id: mainColumn
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20
            
            Rectangle {
                id: header
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "transparent"
                border.color: "#1f2937"
                border.width: 1
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 12
                    
                    Rectangle {
                        width: 32
                        height: 32
                        color: "#16a34a"
                        radius: 8
                        
                        Text {
                            anchors.centerIn: parent
                            text: "📈"
                            font.pixelSize: 16
                        }
                    }
                    
                    Text {
                        text: "Chess Analyzer"
                        color: "white"
                        font.pixelSize: 20
                        font.weight: Font.Bold
                    }
                }
            }
            
            ColumnLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                Layout.maximumWidth: 800
                spacing: 30
                
                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20
                    
                    Text {
                        text: "Analyze Chess Performance"
                        color: "white"
                        font.pixelSize: 32
                        font.weight: Font.Bold
                        Layout.alignment: Qt.AlignHCenter
                    }
                    
                    Text {
                        text: "Discover patterns, detect anomalies, and gain insights from chess.com game data"
                        color: "#9ca3af"
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                        Layout.maximumWidth: 600
                    }
                    
                    Rectangle {
                        id: searchCard
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 400
                        Layout.preferredHeight: 200
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8
                        
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            spacing: 15
                            
                            RowLayout {
                                spacing: 8
                                
                                Text {
                                    text: "🔍"
                                    font.pixelSize: 16
                                }
                                
                                Text {
                                    text: "New Analysis"
                                    color: "white"
                                    font.pixelSize: 16
                                    font.weight: Font.Bold
                                }
                            }
                            
                            Text {
                                text: "Enter a chess.com username to analyze"
                                color: "white"
                                font.pixelSize: 14
                            }
                            
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 10
                                
                                TextField {
                                    id: usernameInput
                                    Layout.fillWidth: true
                                    placeholderText: "Enter chess.com username"
                                    color: "white"
                                    background: Rectangle {
                                        color: "#374151"
                                        border.color: "#4b5563"
                                        border.width: 1
                                        radius: 4
                                    }
                                    
                                    Keys.onReturnPressed: {
                                        if (text.trim() !== "") {
                                            root.analysisRequested(text.trim())
                                            text = ""
                                        }
                                    }
                                }
                                
                                Button {
                                    Layout.fillWidth: true
                                    text: "Start Analysis"
                                    enabled: usernameInput.text.trim() !== ""
                                    
                                    background: Rectangle {
                                        color: parent.enabled ? "#16a34a" : "#374151"
                                        radius: 4
                                    }
                                    
                                    contentItem: Text {
                                        text: parent.text
                                        color: "white"
                                        font.pixelSize: 14
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    
                                    onClicked: {
                                        if (usernameInput.text.trim() !== "") {
                                            root.analysisRequested(usernameInput.text.trim())
                                            usernameInput.text = ""
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                GridLayout {
                    Layout.fillWidth: true
                    columns: 4
                    columnSpacing: 20
                    rowSpacing: 20
                    Layout.maximumWidth: 800
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 150
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8
                        
                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 10
                            
                            Rectangle {
                                Layout.alignment: Qt.AlignHCenter
                                width: 48
                                height: 48
                                color: "#1e40af"
                                opacity: 0.2
                                radius: 8
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "📊"
                                    font.pixelSize: 20
                                    color: "#60a5fa"
                                }
                            }
                            
                            Text {
                                text: "Opening Entropy"
                                color: "white"
                                font.pixelSize: 14
                                font.weight: Font.DemiBold
                                Layout.alignment: Qt.AlignHCenter
                            }
                            
                            Text {
                                text: "Analyze opening diversity vs ELO consistency"
                                color: "#9ca3af"
                                font.pixelSize: 12
                                Layout.alignment: Qt.AlignHCenter
                                horizontalAlignment: Text.AlignHCenter
                                wrapMode: Text.WordWrap
                                Layout.maximumWidth: 120
                            }
                        }
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 150
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8
                        
                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 10
                            
                            Rectangle {
                                Layout.alignment: Qt.AlignHCenter
                                width: 48
                                height: 48
                                color: "#7c3aed"
                                opacity: 0.2
                                radius: 8
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "⏰"
                                    font.pixelSize: 20
                                    color: "#a78bfa"
                                }
                            }
                            
                            Text {
                                text: "Move Timing"
                                color: "white"
                                font.pixelSize: 14
                                font.weight: Font.DemiBold
                                Layout.alignment: Qt.AlignHCenter
                            }
                            
                            Text {
                                text: "Detect suspicious timing patterns"
                                color: "#9ca3af"
                                font.pixelSize: 12
                                Layout.alignment: Qt.AlignHCenter
                                horizontalAlignment: Text.AlignHCenter
                                wrapMode: Text.WordWrap
                                Layout.maximumWidth: 120
                            }
                        }
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 150
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8
                        
                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 10
                            
                            Rectangle {
                                Layout.alignment: Qt.AlignHCenter
                                width: 48
                                height: 48
                                color: "#16a34a"
                                opacity: 0.2
                                radius: 8
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "📈"
                                    font.pixelSize: 20
                                    color: "#4ade80"
                                }
                            }
                            
                            Text {
                                text: "Win/Loss Stats"
                                color: "white"
                                font.pixelSize: 14
                                font.weight: Font.DemiBold
                                Layout.alignment: Qt.AlignHCenter
                            }
                            
                            Text {
                                text: "Comprehensive game outcome analysis"
                                color: "#9ca3af"
                                font.pixelSize: 12
                                Layout.alignment: Qt.AlignHCenter
                                horizontalAlignment: Text.AlignHCenter
                                wrapMode: Text.WordWrap
                                Layout.maximumWidth: 120
                            }
                        }
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 150
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8
                        
                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 10
                            
                            Rectangle {
                                Layout.alignment: Qt.AlignHCenter
                                width: 48
                                height: 48
                                color: "#ea580c"
                                opacity: 0.2
                                radius: 8
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "⚡"
                                    font.pixelSize: 20
                                    color: "#fb923c"
                                }
                            }
                            
                            Text {
                                text: "Comeback Analysis"
                                color: "white"
                                font.pixelSize: 14
                                font.weight: Font.DemiBold
                                Layout.alignment: Qt.AlignHCenter
                            }
                            
                            Text {
                                text: "Identify dramatic game turnarounds"
                                color: "#9ca3af"
                                font.pixelSize: 12
                                Layout.alignment: Qt.AlignHCenter
                                horizontalAlignment: Text.AlignHCenter
                                wrapMode: Text.WordWrap
                                Layout.maximumWidth: 120
                            }
                        }
                    }
                }
                
                PlayersList {
                    Layout.fillWidth: true
                    Layout.maximumWidth: 800
                    
                    onPlayerClicked: function(username) {
                        root.playerClicked(username)
                    }
                }
            }
        }
    }
}
