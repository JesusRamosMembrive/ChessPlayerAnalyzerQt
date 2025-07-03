import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    width: 1200
    height: 800
    visible: true
    title: "Chess Analyzer"
    color: "#000000"

    property string currentUsername: ""
    property bool isAnalyzing: false
    property bool isLoadingPlayers: false
    property var analyzedPlayers: []
    property string errorMessage: ""

    ApiService {
        id: apiService
        
        onPlayersLoaded: function(players) {
            isLoadingPlayers = false
            analyzedPlayers = players
        }
        
        onPlayersError: function(error) {
            isLoadingPlayers = false
            errorMessage = error
        }
        
        onAnalysisStarted: function(taskId) {
            isAnalyzing = false
            usernameInput.text = ""
            apiService.fetchPlayers()
        }
        
        onAnalysisError: function(error) {
            isAnalyzing = false
            errorMessage = error
        }
    }

    Component.onCompleted: {
        apiService.fetchPlayers()
        isLoadingPlayers = true
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainPageComponent
    }

    Component {
        id: mainPageComponent
        Rectangle {
            anchors.fill: parent
            color: "#000000"

            ScrollView {
                anchors.fill: parent
                contentWidth: window.width
                contentHeight: mainContent.height

                Rectangle {
                    id: mainContent
                    width: parent.width
                    height: childrenRect.height
                    color: "#000000"

                    Column {
                        width: parent.width
                        spacing: 0

                        Rectangle {
                            width: parent.width
                            height: 72
                            color: "#000000"
                            border.color: "#1f2937"
                            border.width: 1

                            Rectangle {
                                anchors.fill: parent
                                color: "transparent"

                                Row {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 24
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 12

                                    Rectangle {
                                        width: 32
                                        height: 32
                                        color: "#16a34a"
                                        radius: 8

                                        Text {
                                            anchors.centerIn: parent
                                            text: "📈"
                                            font.pixelSize: 20
                                            color: "white"
                                        }
                                    }

                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "Chess Analyzer"
                                        font.pixelSize: 20
                                        font.bold: true
                                        color: "white"
                                    }
                                }
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: childrenRect.height + 96
                            color: "#000000"

                            Column {
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: 48
                                width: Math.min(896, parent.width - 48)
                                spacing: 48

                                Column {
                                    width: parent.width
                                    spacing: 32

                                    Column {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 16

                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: "Analyze Chess Performance"
                                            font.pixelSize: 36
                                            font.bold: true
                                            color: "white"
                                        }

                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: "Discover patterns, detect anomalies, and gain insights from chess.com game data"
                                            font.pixelSize: 18
                                            color: "#9ca3af"
                                            horizontalAlignment: Text.AlignHCenter
                                            wrapMode: Text.WordWrap
                                            width: Math.min(600, parent.width)
                                        }
                                    }

                                    Rectangle {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        width: Math.min(384, parent.width)
                                        height: childrenRect.height
                                        color: "#1f2937"
                                        border.color: "#374151"
                                        border.width: 1
                                        radius: 8

                                        Column {
                                            width: parent.width
                                            spacing: 0

                                            Rectangle {
                                                width: parent.width
                                                height: childrenRect.height + 32
                                                color: "transparent"

                                                Column {
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    anchors.top: parent.top
                                                    anchors.margins: 24
                                                    spacing: 8

                                                    Row {
                                                        spacing: 8

                                                        Text {
                                                            text: "🔍"
                                                            font.pixelSize: 20
                                                            color: "white"
                                                        }

                                                        Text {
                                                            text: "New Analysis"
                                                            font.pixelSize: 18
                                                            font.bold: true
                                                            color: "white"
                                                        }
                                                    }

                                                    Text {
                                                        text: "Enter a chess.com username to analyze"
                                                        font.pixelSize: 14
                                                        color: "white"
                                                    }
                                                }
                                            }

                                            Rectangle {
                                                width: parent.width
                                                height: childrenRect.height + 32
                                                color: "transparent"

                                                Column {
                                                    anchors.left: parent.left
                                                    anchors.right: parent.right
                                                    anchors.top: parent.top
                                                    anchors.margins: 24
                                                    spacing: 16

                                                    Rectangle {
                                                        width: parent.width
                                                        height: 40
                                                        color: "#374151"
                                                        border.color: "#4b5563"
                                                        border.width: 1
                                                        radius: 6

                                                        TextInput {
                                                            id: usernameInput
                                                            anchors.left: parent.left
                                                            anchors.right: parent.right
                                                            anchors.verticalCenter: parent.verticalCenter
                                                            anchors.margins: 12
                                                            font.pixelSize: 14
                                                            color: "white"
                                                            selectByMouse: true
                                                            enabled: !isAnalyzing

                                                            Keys.onReturnPressed: {
                                                                if (text.trim().length > 0 && !isAnalyzing) {
                                                                    startAnalysis()
                                                                }
                                                            }

                                                            Text {
                                                                anchors.left: parent.left
                                                                anchors.verticalCenter: parent.verticalCenter
                                                                text: "Enter chess.com username"
                                                                font.pixelSize: 14
                                                                color: "#9ca3af"
                                                                visible: parent.text.length === 0
                                                            }
                                                        }
                                                    }

                                                    Rectangle {
                                                        width: parent.width
                                                        height: 40
                                                        color: isAnalyzing ? "#374151" : "#16a34a"
                                                        radius: 6

                                                        MouseArea {
                                                            anchors.fill: parent
                                                            hoverEnabled: true
                                                            enabled: !isAnalyzing && usernameInput.text.trim().length > 0
                                                            onEntered: if (enabled) parent.color = "#15803d"
                                                            onExited: if (enabled) parent.color = "#16a34a"
                                                            onClicked: startAnalysis()
                                                        }

                                                        Row {
                                                            anchors.centerIn: parent
                                                            spacing: 8

                                                            Text {
                                                                text: isAnalyzing ? "⏳" : ""
                                                                font.pixelSize: 14
                                                                color: "white"
                                                                visible: isAnalyzing
                                                            }

                                                            Text {
                                                                text: isAnalyzing ? "Starting Analysis..." : "Start Analysis"
                                                                font.pixelSize: 14
                                                                font.bold: true
                                                                color: "white"
                                                            }
                                                        }
                                                    }

                                                    Text {
                                                        width: parent.width
                                                        text: errorMessage
                                                        font.pixelSize: 12
                                                        color: "#ef4444"
                                                        wrapMode: Text.WordWrap
                                                        visible: errorMessage.length > 0
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                                Grid {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    columns: 4
                                    columnSpacing: 24
                                    rowSpacing: 24
                                    width: parent.width

                                    FeatureCard {
                                        iconText: "📊"
                                        iconColor: "#1e40af"
                                        iconBgColor: "#1e3a8a"
                                        title: "Opening Entropy"
                                        description: "Analyze opening diversity vs ELO consistency"
                                    }

                                    FeatureCard {
                                        iconText: "⏰"
                                        iconColor: "#7c3aed"
                                        iconBgColor: "#5b21b6"
                                        title: "Move Timing"
                                        description: "Detect suspicious timing patterns"
                                    }

                                    FeatureCard {
                                        iconText: "📈"
                                        iconColor: "#16a34a"
                                        iconBgColor: "#15803d"
                                        title: "Win/Loss Stats"
                                        description: "Comprehensive game outcome analysis"
                                    }

                                    FeatureCard {
                                        iconText: "⚡"
                                        iconColor: "#ea580c"
                                        iconBgColor: "#c2410c"
                                        title: "Comeback Analysis"
                                        description: "Identify dramatic game turnarounds"
                                    }
                                }

                                Rectangle {
                                    width: parent.width
                                    height: childrenRect.height
                                    color: "#1f2937"
                                    border.color: "#374151"
                                    border.width: 1
                                    radius: 8

                                    Column {
                                        width: parent.width
                                        spacing: 0

                                        Rectangle {
                                            width: parent.width
                                            height: childrenRect.height + 32
                                            color: "transparent"

                                            Row {
                                                anchors.left: parent.left
                                                anchors.top: parent.top
                                                anchors.margins: 24
                                                spacing: 8

                                                Text {
                                                    text: "👥"
                                                    font.pixelSize: 20
                                                    color: "white"
                                                }

                                                Text {
                                                    text: "Analyzed Players"
                                                    font.pixelSize: 18
                                                    font.bold: true
                                                    color: "white"
                                                }
                                            }
                                        }

                                        Rectangle {
                                            width: parent.width
                                            height: childrenRect.height + 32
                                            color: "transparent"

                                            Column {
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                anchors.top: parent.top
                                                anchors.margins: 24
                                                spacing: 12

                                                Repeater {
                                                    model: isLoadingPlayers ? 3 : 0
                                                    Rectangle {
                                                        width: parent.width
                                                        height: 64
                                                        color: "#374151"
                                                        opacity: 0.5
                                                        radius: 8

                                                        SequentialAnimation on opacity {
                                                            running: true
                                                            loops: Animation.Infinite
                                                            NumberAnimation { to: 0.3; duration: 1000 }
                                                            NumberAnimation { to: 0.5; duration: 1000 }
                                                        }
                                                    }
                                                }

                                                Repeater {
                                                    model: analyzedPlayers
                                                    Rectangle {
                                                        width: parent.width
                                                        height: 64
                                                        color: "#374151"
                                                        radius: 8

                                                        MouseArea {
                                                            anchors.fill: parent
                                                            hoverEnabled: true
                                                            onEntered: parent.color = "#4b5563"
                                                            onExited: parent.color = "#374151"
                                                            onClicked: {
                                                                currentUsername = modelData.username
                                                                stackView.push("ResultsPage.qml", {username: modelData.username})
                                                            }
                                                        }

                                                        Row {
                                                            anchors.left: parent.left
                                                            anchors.verticalCenter: parent.verticalCenter
                                                            anchors.margins: 16
                                                            spacing: 12

                                                            Rectangle {
                                                                width: 32
                                                                height: 32
                                                                color: "#16a34a"
                                                                radius: 16

                                                                Text {
                                                                    anchors.centerIn: parent
                                                                    text: "👤"
                                                                    font.pixelSize: 16
                                                                    color: "white"
                                                                }
                                                            }

                                                            Column {
                                                                anchors.verticalCenter: parent.verticalCenter
                                                                spacing: 2

                                                                Text {
                                                                    text: modelData.username
                                                                    font.pixelSize: 16
                                                                    font.bold: true
                                                                    color: "white"
                                                                }

                                                                Text {
                                                                    text: "Analyzed " + new Date(modelData.analyzed_at || modelData.requested_at).toLocaleDateString()
                                                                    font.pixelSize: 12
                                                                    color: "#9ca3af"
                                                                }
                                                            }
                                                        }
                                                    }
                                                }

                                                Column {
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    spacing: 16
                                                    visible: !isLoadingPlayers && analyzedPlayers.length === 0

                                                    Text {
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        text: "No players analyzed yet\nStart analyzing a player to see results here"
                                                        font.pixelSize: 14
                                                        color: "#6b7280"
                                                        horizontalAlignment: Text.AlignHCenter
                                                    }

                                                    Rectangle {
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        width: 200
                                                        height: 40
                                                        color: "#7c3aed"
                                                        radius: 6

                                                        MouseArea {
                                                            anchors.fill: parent
                                                            hoverEnabled: true
                                                            onEntered: parent.color = "#6d28d9"
                                                            onExited: parent.color = "#7c3aed"
                                                            onClicked: {
                                                                stackView.push("ResultsPage.qml", {
                                                                    username: "sample_player",
                                                                    useFakeData: true
                                                                })
                                                            }
                                                        }

                                                        Text {
                                                            anchors.centerIn: parent
                                                            text: "🎯 View Sample Results"
                                                            font.pixelSize: 14
                                                            font.bold: true
                                                            color: "white"
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function startAnalysis() {
        if (usernameInput.text.trim().length > 0 && !isAnalyzing) {
            isAnalyzing = true
            errorMessage = ""
            apiService.analyzePlayer(usernameInput.text.trim())
        }
    }
}
