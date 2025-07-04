import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    
    property var players: []
    property bool loading: false
    property string error: ""
    
    signal playerClicked(string username)
    signal stopAnalysis(string username)
    signal deletePlayer(string username)
    
    color: "#1f2937"
    border.color: "#374151"
    border.width: 1
    radius: 8
    implicitHeight: 400
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15
        
        RowLayout {
            Layout.fillWidth: true
            
            RowLayout {
                spacing: 8
                
                Text {
                    text: "📜"
                    font.pixelSize: 16
                }
                
                Text {
                    text: "Analyzed Players"
                    color: "white"
                    font.pixelSize: 16
                    font.weight: Font.Bold
                }
            }
            
            Item { Layout.fillWidth: true }
            
            Button {
                visible: root.error !== ""
                text: "🔄 Retry"
                
                background: Rectangle {
                    color: "transparent"
                    border.color: "#4b5563"
                    border.width: 1
                    radius: 4
                }
                
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                onClicked: {
                    root.error = ""
                    root.loading = true
                }
            }
        }
        
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            ColumnLayout {
                width: parent.width
                spacing: 10
                
                Loader {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    sourceComponent: {
                        if (root.loading) {
                            return loadingComponent
                        } else if (root.error !== "") {
                            return errorComponent
                        } else if (root.players.length === 0) {
                            return emptyComponent
                        } else {
                            return playersComponent
                        }
                    }
                }
            }
        }
    }
    
    Component {
        id: loadingComponent
        
        ColumnLayout {
            spacing: 10
            
            Repeater {
                model: 3
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 64
                    color: "#374151"
                    opacity: 0.5
                    radius: 8
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 10
                        
                        Rectangle {
                            width: 40
                            height: 40
                            color: "#4b5563"
                            radius: 20
                        }
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 5
                            
                            Rectangle {
                                Layout.preferredWidth: 100
                                Layout.preferredHeight: 16
                                color: "#4b5563"
                                radius: 2
                            }
                            
                            Rectangle {
                                Layout.preferredWidth: 60
                                Layout.preferredHeight: 12
                                color: "#4b5563"
                                radius: 2
                            }
                        }
                        
                        Rectangle {
                            Layout.preferredWidth: 60
                            Layout.preferredHeight: 24
                            color: "#4b5563"
                            radius: 2
                        }
                    }
                }
            }
        }
    }
    
    Component {
        id: errorComponent
        
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 15
            
            Text {
                text: "⚠️"
                font.pixelSize: 48
                color: "#ef4444"
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: "Connection Error"
                color: "#ef4444"
                font.pixelSize: 18
                font.weight: Font.Bold
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: root.error
                color: "#9ca3af"
                font.pixelSize: 14
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.maximumWidth: 300
            }
            
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 5
                
                Text {
                    text: "This usually means:"
                    color: "#6b7280"
                    font.pixelSize: 12
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Text {
                    text: "• The backend server is not running\n• The server URL has changed\n• Network connectivity issues"
                    color: "#6b7280"
                    font.pixelSize: 12
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }
    
    Component {
        id: emptyComponent
        
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 15
            
            Text {
                text: "👤"
                font.pixelSize: 48
                color: "#6b7280"
                opacity: 0.5
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: "No players analyzed"
                color: "white"
                font.pixelSize: 18
                font.weight: Font.Bold
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: "Start analyzing a player to see results here"
                color: "#9ca3af"
                font.pixelSize: 14
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
    
    Component {
        id: playersComponent
        
        ColumnLayout {
            spacing: 10
            
            Repeater {
                model: root.players
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 80
                    color: "#374151"
                    opacity: 0.5
                    radius: 8
                    
                    property var playerData: modelData
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        
                        onEntered: parent.opacity = 0.7
                        onExited: parent.opacity = 0.5
                        onClicked: root.playerClicked(parent.playerData.username)
                    }
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 10
                        
                        Rectangle {
                            width: 40
                            height: 40
                            color: "#4b5563"
                            radius: 20
                            
                            Text {
                                anchors.centerIn: parent
                                text: parent.parent.parent.playerData.username.charAt(0).toUpperCase()
                                color: "white"
                                font.pixelSize: 14
                                font.weight: Font.Bold
                            }
                        }
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 5
                            
                            RowLayout {
                                spacing: 8
                                
                                Text {
                                    text: parent.parent.parent.parent.playerData.username
                                    color: "white"
                                    font.pixelSize: 14
                                    font.weight: Font.Bold
                                }
                                
                                Rectangle {
                                    width: statusText.implicitWidth + 16
                                    height: 20
                                    radius: 10
                                    color: {
                                        var status = parent.parent.parent.parent.parent.playerData.status
                                        if (status === "pending") return "#eab308"
                                        if (status === "ready") return "#16a34a"
                                        if (status === "error") return "#ef4444"
                                        return "#6b7280"
                                    }
                                    opacity: 0.2
                                    border.color: {
                                        var status = parent.parent.parent.parent.parent.playerData.status
                                        if (status === "pending") return "#eab308"
                                        if (status === "ready") return "#16a34a"
                                        if (status === "error") return "#ef4444"
                                        return "#6b7280"
                                    }
                                    border.width: 1
                                    
                                    Text {
                                        id: statusText
                                        anchors.centerIn: parent
                                        text: {
                                            var status = parent.parent.parent.parent.parent.parent.playerData.status
                                            if (status === "pending") return "Pending"
                                            if (status === "ready") return "Ready"
                                            if (status === "error") return "Error"
                                            return status
                                        }
                                        color: {
                                            var status = parent.parent.parent.parent.parent.parent.playerData.status
                                            if (status === "pending") return "#eab308"
                                            if (status === "ready") return "#16a34a"
                                            if (status === "error") return "#ef4444"
                                            return "#6b7280"
                                        }
                                        font.pixelSize: 10
                                        font.weight: Font.Bold
                                    }
                                }
                            }
                            
                            ProgressBar {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 8
                                visible: parent.parent.parent.parent.playerData.status === "pending"
                                value: (parent.parent.parent.parent.playerData.progress || 0) / 100
                                
                                background: Rectangle {
                                    color: "#4b5563"
                                    radius: 4
                                }
                                
                                contentItem: Rectangle {
                                    color: "#16a34a"
                                    radius: 4
                                }
                            }
                            
                            Text {
                                visible: parent.parent.parent.parent.playerData.status === "pending"
                                text: Math.round(parent.parent.parent.parent.playerData.progress || 0) + "% complete (" + 
                                      (parent.parent.parent.parent.playerData.done_games || 0) + "/" + 
                                      (parent.parent.parent.parent.playerData.total_games || 0) + " games)"
                                color: "#9ca3af"
                                font.pixelSize: 12
                            }
                            
                            Text {
                                visible: parent.parent.parent.parent.playerData.status !== "pending"
                                text: "Requested: " + new Date(parent.parent.parent.parent.playerData.requested_at).toLocaleDateString()
                                color: "#9ca3af"
                                font.pixelSize: 12
                            }
                        }
                        
                        RowLayout {
                            spacing: 5
                            
                            Button {
                                visible: parent.parent.parent.parent.playerData.status === "pending"
                                text: "⏹️"
                                width: 30
                                height: 30
                                
                                background: Rectangle {
                                    color: "#ef4444"
                                    opacity: 0.2
                                    radius: 4
                                    border.color: "#ef4444"
                                    border.width: 1
                                }
                                
                                onClicked: {
                                    root.stopAnalysis(parent.parent.parent.parent.parent.playerData.username)
                                }
                            }
                            
                            Button {
                                text: "🗑️"
                                width: 30
                                height: 30
                                
                                background: Rectangle {
                                    color: "#ef4444"
                                    opacity: 0.2
                                    radius: 4
                                    border.color: "#ef4444"
                                    border.width: 1
                                }
                                
                                onClicked: {
                                    root.deletePlayer(parent.parent.parent.parent.parent.playerData.username)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
