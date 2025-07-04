import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components"

ScrollView {
    id: root
    
    property var parentWindow
    property string username: ""
    property var metrics: null
    property bool loading: true
    property string error: ""
    
    signal backRequested()
    signal shareRequested()
    signal exportRequested()
    
    function formatNumber(num, decimals) {
        if (num === null || num === undefined) return "N/A"
        return Number(num).toFixed(decimals || 2)
    }
    
    function getRiskColor(score) {
        if (score > 75) return "#f87171"
        if (score > 50) return "#fb923c"
        if (score > 25) return "#fbbf24"
        return "#4ade80"
    }
    
    Rectangle {
        color: "#000000"
        implicitWidth: root.width
        implicitHeight: mainColumn.implicitHeight + 40
        
        ColumnLayout {
            id: mainColumn
            anchors.fill: parent
            anchors.margins: 0
            spacing: 0
            
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
                    
                    RowLayout {
                        spacing: 15
                        
                        Button {
                            text: "← Back"
                            
                            background: Rectangle {
                                color: "transparent"
                                radius: 4
                            }
                            
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            
                            onClicked: root.backRequested()
                        }
                        
                        RowLayout {
                            spacing: 12
                            
                            Rectangle {
                                width: 40
                                height: 40
                                color: "#16a34a"
                                radius: 20
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "👤"
                                    font.pixelSize: 16
                                }
                            }
                            
                            ColumnLayout {
                                spacing: 2
                                
                                Text {
                                    text: root.username
                                    color: "white"
                                    font.pixelSize: 20
                                    font.weight: Font.Bold
                                }
                                
                                Text {
                                    text: root.metrics ? "Analysis completed on " + new Date(root.metrics.analyzed_at).toLocaleDateString() : ""
                                    color: "#9ca3af"
                                    font.pixelSize: 12
                                }
                            }
                        }
                    }
                    
                    Item { Layout.fillWidth: true }
                    
                    RowLayout {
                        spacing: 8
                        
                        Button {
                            text: "📤 Share"
                            
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
                            
                            onClicked: root.shareRequested()
                        }
                        
                        Button {
                            text: "💾 Export"
                            
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
                            
                            onClicked: root.exportRequested()
                        }
                    }
                }
            }
            
            ColumnLayout {
                Layout.fillWidth: true
                Layout.margins: 20
                spacing: 30
                
                Loader {
                    Layout.fillWidth: true
                    
                    sourceComponent: {
                        if (root.loading) {
                            return loadingComponent
                        } else if (root.error !== "") {
                            return errorComponent
                        } else if (!root.metrics) {
                            return noDataComponent
                        } else {
                            return contentComponent
                        }
                    }
                }
            }
        }
    }
    
    Component {
        id: loadingComponent
        
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 20
            
            Text {
                text: "Loading analysis results..."
                color: "white"
                font.pixelSize: 18
                Layout.alignment: Qt.AlignHCenter
            }
            
            GridLayout {
                columns: 4
                columnSpacing: 20
                rowSpacing: 20
                Layout.fillWidth: true
                
                Repeater {
                    model: 4
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 120
                        color: "#1f2937"
                        radius: 8
                        opacity: 0.5
                    }
                }
            }
        }
    }
    
    Component {
        id: errorComponent
        
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 20
            
            Text {
                text: "⚠️"
                font.pixelSize: 64
                color: "#ef4444"
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: "Error loading analysis data"
                color: "#ef4444"
                font.pixelSize: 24
                font.weight: Font.Bold
                Layout.alignment: Qt.AlignHCenter
            }
            
            Text {
                text: root.error
                color: "#9ca3af"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.maximumWidth: 400
            }
        }
    }
    
    Component {
        id: noDataComponent
        
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 20
            
            Text {
                text: "No analysis data available for this player"
                color: "white"
                font.pixelSize: 24
                font.weight: Font.Bold
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
    
    Component {
        id: contentComponent
        
        ColumnLayout {
            spacing: 30
            
            GridLayout {
                columns: 4
                columnSpacing: 20
                rowSpacing: 20
                Layout.fillWidth: true
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#1f2937"
                    border.color: "#374151"
                    border.width: 1
                    radius: 8
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 8
                        
                        RowLayout {
                            Layout.fillWidth: true
                            
                            Text {
                                text: "Risk Score"
                                color: "#9ca3af"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                            }
                            
                            Item { Layout.fillWidth: true }
                            
                            Text {
                                text: "🛡️"
                                font.pixelSize: 16
                                color: root.getRiskColor(root.metrics ? root.metrics.risk.risk_score : 0)
                            }
                        }
                        
                        Text {
                            text: root.formatNumber(root.metrics ? root.metrics.risk.risk_score : 0, 0) + "/100"
                            color: root.getRiskColor(root.metrics ? root.metrics.risk.risk_score : 0)
                            font.pixelSize: 32
                            font.weight: Font.Bold
                        }
                        
                        Text {
                            text: "Overall suspicion assessment"
                            color: "#6b7280"
                            font.pixelSize: 12
                        }
                    }
                }
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#1f2937"
                    border.color: "#374151"
                    border.width: 1
                    radius: 8
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 8
                        
                        RowLayout {
                            Layout.fillWidth: true
                            
                            Text {
                                text: "Games Analyzed"
                                color: "#9ca3af"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                            }
                            
                            Item { Layout.fillWidth: true }
                            
                            Text {
                                text: "📊"
                                font.pixelSize: 16
                                color: "#60a5fa"
                            }
                        }
                        
                        Text {
                            text: root.metrics ? root.metrics.games_analyzed.toString() : "0"
                            color: "#4ade80"
                            font.pixelSize: 32
                            font.weight: Font.Bold
                        }
                        
                        Text {
                            text: root.metrics ? 
                                  "From " + new Date(root.metrics.first_game_date).toLocaleDateString() + 
                                  " to " + new Date(root.metrics.last_game_date).toLocaleDateString() : ""
                            color: "#6b7280"
                            font.pixelSize: 12
                            wrapMode: Text.WordWrap
                        }
                    }
                }
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#1f2937"
                    border.color: "#374151"
                    border.width: 1
                    radius: 8
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 8
                        
                        RowLayout {
                            Layout.fillWidth: true
                            
                            Text {
                                text: "Intrinsic Performance"
                                color: "#9ca3af"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                            }
                            
                            Item { Layout.fillWidth: true }
                            
                            Text {
                                text: "⚡"
                                font.pixelSize: 16
                                color: "#a78bfa"
                            }
                        }
                        
                        Text {
                            text: root.formatNumber(root.metrics ? root.metrics.avg_ipr : 0, 0)
                            color: "#4ade80"
                            font.pixelSize: 32
                            font.weight: Font.Bold
                        }
                        
                        Text {
                            text: "Estimated ELO based on moves"
                            color: "#6b7280"
                            font.pixelSize: 12
                        }
                    }
                }
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 120
                    color: "#1f2937"
                    border.color: "#374151"
                    border.width: 1
                    radius: 8
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 8
                        
                        RowLayout {
                            Layout.fillWidth: true
                            
                            Text {
                                text: "Sudden Improvement"
                                color: "#9ca3af"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                            }
                            
                            Item { Layout.fillWidth: true }
                            
                            Text {
                                text: "📈"
                                font.pixelSize: 16
                                color: "#fb923c"
                            }
                        }
                        
                        Text {
                            text: root.metrics && root.metrics.step_function_detected ? "Detected" : "No"
                            color: root.metrics && root.metrics.step_function_detected ? "#fb923c" : "#4ade80"
                            font.pixelSize: 32
                            font.weight: Font.Bold
                        }
                        
                        Text {
                            text: "Magnitude: " + root.formatNumber(root.metrics ? root.metrics.step_function_magnitude : 0, 0)
                            color: "#6b7280"
                            font.pixelSize: 12
                        }
                    }
                }
            }
            
            GridLayout {
                columns: 2
                columnSpacing: 20
                rowSpacing: 20
                Layout.fillWidth: true
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 300
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
                                text: "🧠"
                                font.pixelSize: 16
                                color: "#60a5fa"
                            }
                            
                            Text {
                                text: "Quality Metrics"
                                color: "white"
                                font.pixelSize: 16
                                font.weight: Font.Bold
                            }
                        }
                        
                        Text {
                            text: "Indicators of game quality and consistency."
                            color: "#9ca3af"
                            font.pixelSize: 14
                        }
                        
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 15
                            
                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Average Centipawn Loss (ACPL)"
                                value: root.formatNumber(root.metrics ? root.metrics.avg_acpl : 0)
                                tooltipText: "Average value lost due to suboptimal moves. Lower is better. Very low ACPL for the player's rating may be suspicious."
                            }
                            
                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "ACPL Standard Deviation"
                                value: root.formatNumber(root.metrics ? root.metrics.std_acpl : 0)
                                tooltipText: "Measures consistency. Very low values may indicate unnatural uniformity."
                            }
                            
                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Engine Match Rate"
                                value: root.formatNumber(root.metrics ? root.metrics.avg_match_rate * 100 : 0) + "%"
                                tooltipText: "Average percentage of moves matching the engine's first choice."
                            }
                            
                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Match Rate Std Dev"
                                value: root.formatNumber(root.metrics ? root.metrics.std_match_rate * 100 : 0) + "%"
                                tooltipText: "Consistency of match rate. Low variability can be a warning sign."
                            }
                        }
                    }
                }
                
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 300
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
                                text: "🛡️"
                                font.pixelSize: 16
                                color: "#ef4444"
                            }
                            
                            Text {
                                text: "Risk Factors"
                                color: "white"
                                font.pixelSize: 16
                                font.weight: Font.Bold
                            }
                        }
                        
                        Text {
                            text: "Specific factors contributing to the risk score."
                            color: "#9ca3af"
                            font.pixelSize: 14
                        }
                        
                        ScrollView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            
                            ColumnLayout {
                                width: parent.width
                                spacing: 10
                                
                                Text {
                                    text: root.metrics && Object.keys(root.metrics.risk.risk_factors).length > 0 ? 
                                          "Risk factors detected" : "No specific risk factors detected."
                                    color: "#9ca3af"
                                    font.pixelSize: 14
                                    Layout.alignment: Qt.AlignHCenter
                                }
                                
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 1
                                    color: "#374151"
                                    Layout.topMargin: 10
                                }
                                
                                MetricDisplay {
                                    Layout.fillWidth: true
                                    label: "Confidence Level"
                                    value: root.formatNumber(root.metrics ? root.metrics.risk.confidence_level * 100 : 0, 0) + "%"
                                    tooltipText: "The confidence level of the risk assessment, based on available data."
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
