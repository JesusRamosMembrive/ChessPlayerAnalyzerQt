import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ScrollView {
    id: root

    property var parentWindow
    property string username: "SamplePlayer"
    property var metrics: ({
        "username": "SamplePlayer",
        "analyzed_at": "2024-07-04T12:00:00Z",
        "games_analyzed": 247,
        "first_game_date": "2024-01-15T10:30:00Z",
        "last_game_date": "2024-06-30T18:45:00Z",
        "avg_ipr": 1847,
        "step_function_detected": true,
        "step_function_magnitude": 156,
        "avg_acpl": 28.4,
        "std_acpl": 12.7,
        "avg_match_rate": 0.42,
        "std_match_rate": 0.18,
        "risk": {
            "risk_score": 73,
            "confidence_level": 0.87,
            "risk_factors": {
                "low_acpl_for_rating": 0.85,
                "high_engine_correlation": 0.78,
                "sudden_improvement": 0.92,
                "time_management_inconsistency": 0.34,
                "opening_preparation_anomaly": 0.67
            }
        },
        "roi_analysis": {
            "roi_mean": -188,
            "roi_max": 2514,
            "roi_std": 3364
        },
        "opening_patterns": {
            "entropy": 3.2,
            "diversity_index": 0.78,
            "novelty_depth": 12.4,
            "preparation_score": 0.85,
            "opening_breadth": 15,
            "second_choice_rate": 0.23
        },
        "phase_quality": {
            "opening_acpl": 18.2,
            "middlegame_acpl": 24.8,
            "endgame_acpl": 35.1,
            "blunder_rate": 0.08
        },
        "time_management": {
            "mean_move_time": 45.2,
            "time_variance": 234.7,
            "uniformity_score": -0.34,
            "lag_spike_count": 12
        },
        "clutch_accuracy": {
            "avg_clutch_diff": -15.3,
            "clutch_games_pct": 0.18
        },
        "benchmark": {
            "percentile_acpl": 87,
            "percentile_accuracy": 92,
            "percentile_speed": 74,
            "peer_comparison": "Superior"
        },
        "tactical_analysis": {
            "tactical_rating": 1923,
            "puzzle_rush_score": 28,
            "combination_accuracy": 0.76
        },
        "endgame_analysis": {
            "endgame_rating": 1756,
            "conversion_rate": 0.68,
            "defensive_accuracy": 0.72
        },
        "performance": {
            "trend_acpl": -2.3,
            "trend_match_rate": 0.05
        }
    })
    property bool loading: false
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

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 8

                                    Text {
                                        text: "Low ACPL for Rating"
                                        color: "#d1d5db"
                                        font.pixelSize: 13
                                    }
                                    Text {
                                        text: root.formatNumber(root.metrics.risk.risk_factors.low_acpl_for_rating * 100, 0) + "%"
                                        color: "#ef4444"
                                        font.pixelSize: 14
                                        font.weight: Font.Bold
                                    }
                                }

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 1
                                    color: "#374151"
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 8

                                    Text {
                                        text: "High Engine Correlation"
                                        color: "#d1d5db"
                                        font.pixelSize: 13
                                    }
                                    Text {
                                        text: root.formatNumber(root.metrics.risk.risk_factors.high_engine_correlation * 100, 0) + "%"
                                        color: "#ef4444"
                                        font.pixelSize: 14
                                        font.weight: Font.Bold
                                    }
                                }

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 1
                                    color: "#374151"
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 8

                                    Text {
                                        text: "Sudden Improvement"
                                        color: "#d1d5db"
                                        font.pixelSize: 13
                                    }
                                    Text {
                                        text: root.formatNumber(root.metrics.risk.risk_factors.sudden_improvement * 100, 0) + "%"
                                        color: "#ef4444"
                                        font.pixelSize: 14
                                        font.weight: Font.Bold
                                    }
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

            GridLayout {
                columns: 2
                columnSpacing: 20
                rowSpacing: 20
                Layout.fillWidth: true

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 180
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
                                text: "📈"
                                font.pixelSize: 16
                                color: "#10b981"
                            }

                            Text {
                                text: "Análisis Longitudinal (ROI)"
                                color: "white"
                                font.pixelSize: 16
                                font.weight: Font.Bold
                            }
                        }

                        Text {
                            text: "Métricas clave del rendimiento del jugador a lo largo del tiempo"
                            color: "#9ca3af"
                            font.pixelSize: 14
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 30

                            ColumnLayout {
                                spacing: 5
                                Text {
                                    text: "ROI Mean"
                                    color: "#9ca3af"
                                    font.pixelSize: 12
                                }
                                Text {
                                    text: root.metrics.roi_analysis.roi_mean.toString()
                                    color: root.metrics.roi_analysis.roi_mean < 0 ? "#10b981" : "#ef4444"
                                    font.pixelSize: 24
                                    font.weight: Font.Bold
                                }
                            }

                            ColumnLayout {
                                spacing: 5
                                Text {
                                    text: "ROI Max"
                                    color: "#9ca3af"
                                    font.pixelSize: 12
                                }
                                Text {
                                    text: root.metrics.roi_analysis.roi_max.toString()
                                    color: "#3b82f6"
                                    font.pixelSize: 24
                                    font.weight: Font.Bold
                                }
                            }

                            ColumnLayout {
                                spacing: 5
                                Text {
                                    text: "ROI Std"
                                    color: "#9ca3af"
                                    font.pixelSize: 12
                                }
                                Text {
                                    text: root.metrics.roi_analysis.roi_std.toString()
                                    color: "#8b5cf6"
                                    font.pixelSize: 24
                                    font.weight: Font.Bold
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 180
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
                                text: "📊"
                                font.pixelSize: 16
                                color: "#f59e0b"
                            }

                            Text {
                                text: "Tendencias"
                                color: "white"
                                font.pixelSize: 16
                                font.weight: Font.Bold
                            }
                        }

                        Text {
                            text: "Análisis de tendencias temporales"
                            color: "#9ca3af"
                            font.pixelSize: 14
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Tendencia ACPL"
                                value: root.formatNumber(root.metrics.performance.trend_acpl, 1) + " cp/100 partidas"
                                tooltipText: "Cambio en ACPL por cada 100 partidas. Valores negativos indican mejora."
                            }

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Tendencia Match Rate"
                                value: root.formatNumber(root.metrics.performance.trend_match_rate * 100, 1) + "%"
                                tooltipText: "Cambio en tasa de coincidencia por cada 100 partidas."
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 250
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
                            text: "♟️"
                            font.pixelSize: 16
                            color: "#8b5cf6"
                        }

                        Text {
                            text: "Patrones de Apertura"
                            color: "white"
                            font.pixelSize: 16
                            font.weight: Font.Bold
                        }
                    }

                    Text {
                        text: "Análisis de la diversidad y preparación en aperturas"
                        color: "#9ca3af"
                        font.pixelSize: 14
                    }

                    GridLayout {
                        Layout.fillWidth: true
                        columns: 3
                        columnSpacing: 20
                        rowSpacing: 15

                        ColumnLayout {
                            spacing: 8
                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Entropía de Apertura"
                                value: root.formatNumber(root.metrics.opening_patterns.entropy, 1)
                                tooltipText: "Medida de la diversidad en la elección de aperturas."
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                height: 4
                                color: "#374151"
                                radius: 2
                                Rectangle {
                                    width: parent.width * (root.metrics.opening_patterns.entropy / 5.0)
                                    height: parent.height
                                    color: "#3b82f6"
                                    radius: 2
                                }
                            }
                        }

                        ColumnLayout {
                            spacing: 8
                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Índice de Diversidad"
                                value: root.formatNumber(root.metrics.opening_patterns.diversity_index, 2)
                                tooltipText: "Índice que mide la variedad en las aperturas jugadas."
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                height: 4
                                color: "#374151"
                                radius: 2
                                Rectangle {
                                    width: parent.width * root.metrics.opening_patterns.diversity_index
                                    height: parent.height
                                    color: "#10b981"
                                    radius: 2
                                }
                            }
                        }

                        ColumnLayout {
                            spacing: 8
                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Profundidad de Novedad"
                                value: root.formatNumber(root.metrics.opening_patterns.novelty_depth, 1)
                                tooltipText: "Profundidad promedio donde se desvía de la teoría conocida."
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                height: 4
                                color: "#374151"
                                radius: 2
                                Rectangle {
                                    width: parent.width * (root.metrics.opening_patterns.novelty_depth / 20.0)
                                    height: parent.height
                                    color: "#f59e0b"
                                    radius: 2
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
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
                            text: "🏰"
                            font.pixelSize: 16
                            color: "#6366f1"
                        }

                        Text {
                            text: "Calidad por Fase de Juego"
                            color: "white"
                            font.pixelSize: 16
                            font.weight: Font.Bold
                        }
                    }

                    Text {
                        text: "Análisis del rendimiento (ACPL) en cada fase de la partida"
                        color: "#9ca3af"
                        font.pixelSize: 14
                    }

                    GridLayout {
                        Layout.fillWidth: true
                        columns: 4
                        columnSpacing: 15
                        rowSpacing: 10

                        MetricDisplay {
                            Layout.fillWidth: true
                            label: "ACPL en Apertura"
                            value: root.formatNumber(root.metrics.phase_quality.opening_acpl, 1)
                            tooltipText: "Pérdida media de centipeones durante la fase de apertura."
                        }

                        MetricDisplay {
                            Layout.fillWidth: true
                            label: "ACPL en Medio Juego"
                            value: root.formatNumber(root.metrics.phase_quality.middlegame_acpl, 1)
                            tooltipText: "Pérdida media de centipeones durante el medio juego."
                        }

                        MetricDisplay {
                            Layout.fillWidth: true
                            label: "ACPL en Final"
                            value: root.formatNumber(root.metrics.phase_quality.endgame_acpl, 1)
                            tooltipText: "Pérdida media de centipeones durante la fase final."
                        }

                        MetricDisplay {
                            Layout.fillWidth: true
                            label: "Tasa de Errores Graves"
                            value: root.formatNumber(root.metrics.phase_quality.blunder_rate * 100, 1) + "%"
                            tooltipText: "Porcentaje de jugadas que son errores graves (>300 cp)."
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
                                text: "⏱️"
                                font.pixelSize: 16
                                color: "#06b6d4"
                            }

                            Text {
                                text: "Gestión del Tiempo"
                                color: "white"
                                font.pixelSize: 16
                                font.weight: Font.Bold
                            }
                        }

                        Text {
                            text: "Análisis de los patrones de uso del tiempo"
                            color: "#9ca3af"
                            font.pixelSize: 14
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Tiempo Medio por Jugada"
                                value: root.formatNumber(root.metrics.time_management.mean_move_time, 1) + "s"
                                tooltipText: "Tiempo promedio en segundos que el jugador tarda en realizar una jugada."
                            }

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Varianza del Tiempo"
                                value: root.formatNumber(root.metrics.time_management.time_variance, 1)
                                tooltipText: "Mide la variabilidad en el tiempo de reflexión."
                            }

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Picos de Lag"
                                value: root.metrics.time_management.lag_spike_count.toString()
                                tooltipText: "Número de veces que el jugador tarda mucho y luego responde muy rápido."
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
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
                                text: "🎯"
                                font.pixelSize: 16
                                color: "#f43f5e"
                            }

                            Text {
                                text: "Precisión Bajo Presión (Clutch)"
                                color: "white"
                                font.pixelSize: 16
                                font.weight: Font.Bold
                            }
                        }

                        Text {
                            text: "Rendimiento en momentos críticos de la partida"
                            color: "#9ca3af"
                            font.pixelSize: 14
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Diferencia Media en 'Clutch'"
                                value: root.formatNumber(root.metrics.clutch_accuracy.avg_clutch_diff, 1)
                                tooltipText: "Diferencia promedio en la evaluación en momentos críticos."
                            }

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Porcentaje de Partidas 'Clutch'"
                                value: root.formatNumber(root.metrics.clutch_accuracy.clutch_games_pct * 100, 1) + "%"
                                tooltipText: "Porcentaje de partidas con precisión inusualmente alta bajo presión."
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
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
                            text: "👥"
                            font.pixelSize: 16
                            color: "#10b981"
                        }

                        Text {
                            text: "Benchmarking vs Pares"
                            color: "white"
                            font.pixelSize: 16
                            font.weight: Font.Bold
                        }
                    }

                    Text {
                        text: "Comparación con jugadores de ELO similar (±200 puntos)"
                        color: "#9ca3af"
                        font.pixelSize: 14
                    }

                    GridLayout {
                        Layout.fillWidth: true
                        columns: 4
                        columnSpacing: 20
                        rowSpacing: 15

                        ColumnLayout {
                            spacing: 8
                            Text {
                                text: "Percentil ACPL"
                                color: "#9ca3af"
                                font.pixelSize: 12
                            }
                            Text {
                                text: root.metrics.benchmark.percentile_acpl + "%"
                                color: "#3b82f6"
                                font.pixelSize: 18
                                font.weight: Font.Bold
                            }
                            Text {
                                text: "Calidad de Juego"
                                color: "#94a3b8"
                                font.pixelSize: 11
                            }
                        }

                        ColumnLayout {
                            spacing: 8
                            Text {
                                text: "Percentil Precisión"
                                color: "#9ca3af"
                                font.pixelSize: 12
                            }
                            Text {
                                text: root.metrics.benchmark.percentile_accuracy + "%"
                                color: "#10b981"
                                font.pixelSize: 18
                                font.weight: Font.Bold
                            }
                            Text {
                                text: "Excelente"
                                color: "#10b981"
                                font.pixelSize: 11
                            }
                        }

                        ColumnLayout {
                            spacing: 8
                            Text {
                                text: "Percentil Velocidad"
                                color: "#9ca3af"
                                font.pixelSize: 12
                            }
                            Text {
                                text: root.metrics.benchmark.percentile_speed + "%"
                                color: "#f59e0b"
                                font.pixelSize: 18
                                font.weight: Font.Bold
                            }
                            Text {
                                text: "Bueno"
                                color: "#f59e0b"
                                font.pixelSize: 11
                            }
                        }

                        ColumnLayout {
                            spacing: 8
                            Text {
                                text: "Comparación General"
                                color: "#9ca3af"
                                font.pixelSize: 12
                            }
                            Text {
                                text: root.metrics.benchmark.peer_comparison
                                color: "#8b5cf6"
                                font.pixelSize: 18
                                font.weight: Font.Bold
                            }
                            Text {
                                text: "vs Rating Similar"
                                color: "#94a3b8"
                                font.pixelSize: 11
                            }
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
                    Layout.preferredHeight: 180
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
                                text: "⚔️"
                                font.pixelSize: 16
                                color: "#ef4444"
                            }

                            Text {
                                text: "Análisis Táctico"
                                color: "white"
                                font.pixelSize: 16
                                font.weight: Font.Bold
                            }
                        }

                        Text {
                            text: "Evaluación de habilidades tácticas"
                            color: "#9ca3af"
                            font.pixelSize: 14
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Rating Táctico"
                                value: root.metrics.tactical_analysis.tactical_rating.toString()
                                tooltipText: "Rating estimado basado en habilidades tácticas."
                            }

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Puzzle Rush Score"
                                value: root.metrics.tactical_analysis.puzzle_rush_score.toString()
                                tooltipText: "Puntuación en resolución rápida de problemas tácticos."
                            }

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Precisión Combinaciones"
                                value: root.formatNumber(root.metrics.tactical_analysis.combination_accuracy * 100, 0) + "%"
                                tooltipText: "Precisión en la ejecución de combinaciones tácticas."
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 180
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
                                text: "♔"
                                font.pixelSize: 16
                                color: "#fbbf24"
                            }

                            Text {
                                text: "Análisis de Finales"
                                color: "white"
                                font.pixelSize: 16
                                font.weight: Font.Bold
                            }
                        }

                        Text {
                            text: "Evaluación de técnica en finales"
                            color: "#9ca3af"
                            font.pixelSize: 14
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Rating de Finales"
                                value: root.metrics.endgame_analysis.endgame_rating.toString()
                                tooltipText: "Rating estimado basado en técnica de finales."
                            }

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Tasa de Conversión"
                                value: root.formatNumber(root.metrics.endgame_analysis.conversion_rate * 100, 0) + "%"
                                tooltipText: "Porcentaje de finales ganadores convertidos exitosamente."
                            }

                            MetricDisplay {
                                Layout.fillWidth: true
                                label: "Precisión Defensiva"
                                value: root.formatNumber(root.metrics.endgame_analysis.defensive_accuracy * 100, 0) + "%"
                                tooltipText: "Precisión en la defensa de finales difíciles."
                            }
                        }
                    }
                }
            }
        }
    }
}
