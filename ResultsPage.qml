import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: resultsPage
    color: "#000000"
    
    property var dummyMetrics: {
        "username": "magnus_carlsen",
        "analyzed_at": "2024-07-02T21:30:00Z",
        "games_analyzed": 247,
        "first_game_date": "2024-01-15T10:00:00Z",
        "last_game_date": "2024-06-30T18:45:00Z",
        "avg_acpl": 18.5,
        "std_acpl": 12.3,
        "avg_match_rate": 0.68,
        "avg_ipr": 2847,
        "step_function_detected": false,
        "step_function_magnitude": 45,
        "roi_mean": 2.34,
        "roi_max": 4.12,
        "roi_std": 0.87,
        "longest_streak": 12,
        "selectivity_score": 73.2,
        "risk": {
            "risk_score": 28,
            "confidence_level": 0.85,
            "suspicious_games_count": 3,
            "risk_factors": {
                "high_match_rate": 0.15,
                "low_acpl_variance": 0.08,
                "timing_patterns": 0.05
            }
        },
        "opening_patterns": {
            "mean_entropy": 3.42,
            "novelty_depth": 8.7,
            "opening_breadth": 23,
            "second_choice_rate": 0.31
        },
        "phase_quality": {
            "opening_acpl": 15.2,
            "middlegame_acpl": 21.8,
            "endgame_acpl": 18.9,
            "blunder_rate": 0.04
        },
        "time_management": {
            "mean_move_time": 12.4,
            "time_variance": 145.6,
            "uniformity_score": -0.23,
            "lag_spike_count": 7
        },
        "clutch_accuracy": {
            "avg_clutch_diff": -2.1,
            "clutch_games_pct": 0.18
        },
        "benchmark": {
            "percentile_acpl": 88,
            "percentile_entropy": 65
        },
        "tactical": {
            "precision_burst_count": 4,
            "second_choice_rate": 0.28
        },
        "endgame": {
            "conversion_efficiency": 87,
            "tb_match_rate": 0.92,
            "dtz_deviation": 1.3
        },
        "performance": {
            "trend_acpl": -15.2,
            "trend_match_rate": 0.025
        }
    }

    function formatNumber(num, decimals) {
        if (decimals === undefined) decimals = 2;
        if (num === null || num === undefined) return "N/A";
        return num.toFixed(decimals);
    }

    function getRiskColor(score) {
        if (score > 75) return "#f87171";
        if (score > 50) return "#fb923c";
        if (score > 25) return "#fbbf24";
        return "#4ade80";
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: mainColumn.height

        Column {
            id: mainColumn
            width: parent.width
            spacing: 0

            // Header with back button
            Rectangle {
                width: parent.width
                height: 72
                color: "#000000"
                border.color: "#1f2937"
                border.width: 1

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 24
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 16

                    Rectangle {
                        width: 40
                        height: 40
                        color: "#374151"
                        radius: 6

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (parent.parent.parent.parent.parent.StackView.view) {
                                    parent.parent.parent.parent.parent.StackView.view.pop();
                                }
                            }
                        }

                        Text {
                            anchors.centerIn: parent
                            text: "←"
                            font.pixelSize: 20
                            color: "white"
                        }
                    }

                    Row {
                        spacing: 12
                        anchors.verticalCenter: parent.verticalCenter

                        Rectangle {
                            width: 40
                            height: 40
                            color: "#16a34a"
                            radius: 20

                            Text {
                                anchors.centerIn: parent
                                text: "👤"
                                font.pixelSize: 20
                                color: "white"
                            }
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 2

                            Text {
                                text: dummyMetrics.username
                                font.pixelSize: 20
                                font.bold: true
                                color: "white"
                            }

                            Text {
                                text: "Analysis completed " + new Date(dummyMetrics.analyzed_at).toLocaleDateString()
                                font.pixelSize: 14
                                color: "#9ca3af"
                            }
                        }
                    }
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 24
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 12

                    Rectangle {
                        width: 100
                        height: 32
                        color: "transparent"
                        border.color: "#374151"
                        border.width: 1
                        radius: 6

                        Text {
                            anchors.centerIn: parent
                            text: "📤 Share"
                            font.pixelSize: 12
                            color: "white"
                        }
                    }

                    Rectangle {
                        width: 100
                        height: 32
                        color: "transparent"
                        border.color: "#374151"
                        border.width: 1
                        radius: 6

                        Text {
                            anchors.centerIn: parent
                            text: "💾 Export"
                            font.pixelSize: 12
                            color: "white"
                        }
                    }
                }
            }

            // Main content area
            Rectangle {
                width: parent.width
                height: childrenRect.height + 48
                color: "#000000"

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 24
                    width: Math.min(1200, parent.width - 48)
                    spacing: 32

                    // Summary cards
                    Grid {
                        anchors.horizontalCenter: parent.horizontalCenter
                        columns: 4
                        columnSpacing: 24
                        rowSpacing: 24
                        width: parent.width

                        Rectangle {
                            width: (parent.width - 72) / 4
                            height: 120
                            color: "#1f2937"
                            border.color: "#374151"
                            border.width: 1
                            radius: 8

                            Column {
                                anchors.centerIn: parent
                                spacing: 8

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "🛡️ Risk Score"
                                    font.pixelSize: 14
                                    color: "#9ca3af"
                                }

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: formatNumber(dummyMetrics.risk.risk_score, 0) + "/100"
                                    font.pixelSize: 32
                                    font.bold: true
                                    color: getRiskColor(dummyMetrics.risk.risk_score)
                                }
                            }
                        }

                        Rectangle {
                            width: (parent.width - 72) / 4
                            height: 120
                            color: "#1f2937"
                            border.color: "#374151"
                            border.width: 1
                            radius: 8

                            Column {
                                anchors.centerIn: parent
                                spacing: 8

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "🎯 Games Analyzed"
                                    font.pixelSize: 14
                                    color: "#9ca3af"
                                }

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: dummyMetrics.games_analyzed
                                    font.pixelSize: 32
                                    font.bold: true
                                    color: "#60a5fa"
                                }
                            }
                        }

                        Rectangle {
                            width: (parent.width - 72) / 4
                            height: 120
                            color: "#1f2937"
                            border.color: "#374151"
                            border.width: 1
                            radius: 8

                            Column {
                                anchors.centerIn: parent
                                spacing: 8

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "⚡ Intrinsic Performance"
                                    font.pixelSize: 14
                                    color: "#9ca3af"
                                }

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: formatNumber(dummyMetrics.avg_ipr, 0)
                                    font.pixelSize: 32
                                    font.bold: true
                                    color: "#a855f7"
                                }
                            }
                        }

                        Rectangle {
                            width: (parent.width - 72) / 4
                            height: 120
                            color: "#1f2937"
                            border.color: "#374151"
                            border.width: 1
                            radius: 8

                            Column {
                                anchors.centerIn: parent
                                spacing: 8

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "📈 Sudden Improvement"
                                    font.pixelSize: 14
                                    color: "#9ca3af"
                                }

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: dummyMetrics.step_function_detected ? "DETECTED" : "NOT DETECTED"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: dummyMetrics.step_function_detected ? "#f87171" : "#4ade80"
                                }
                            }
                        }
                    }

                    // Quality Metrics Section
                    Rectangle {
                        width: parent.width
                        height: childrenRect.height + 48
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8

                        Column {
                            anchors.fill: parent
                            anchors.margins: 24
                            spacing: 16

                            Row {
                                spacing: 8

                                Text {
                                    text: "📊"
                                    font.pixelSize: 20
                                    color: "#60a5fa"
                                }

                                Text {
                                    text: "Quality Metrics"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "white"
                                }
                            }

                            Text {
                                text: "Core performance indicators and accuracy measurements."
                                font.pixelSize: 14
                                color: "#9ca3af"
                                wrapMode: Text.WordWrap
                                width: parent.width
                            }

                            Grid {
                                width: parent.width
                                columns: 2
                                columnSpacing: 32
                                rowSpacing: 24

                                Column {
                                    width: (parent.width - 32) / 2
                                    spacing: 20

                                    MetricCard {
                                        label: "Average Centipawn Loss (ACPL)"
                                        value: formatNumber(dummyMetrics.avg_acpl, 1)
                                        tooltipText: "Average centipawn loss per move. Lower values indicate stronger play."
                                    }

                                    MetricCard {
                                        label: "ACPL Standard Deviation"
                                        value: formatNumber(dummyMetrics.std_acpl, 1)
                                        tooltipText: "Consistency of play. Lower values may indicate engine assistance."
                                    }
                                }

                                Column {
                                    width: (parent.width - 32) / 2
                                    spacing: 20

                                    MetricCard {
                                        label: "Engine Match Rate"
                                        value: formatNumber(dummyMetrics.avg_match_rate * 100, 1) + "%"
                                        tooltipText: "Percentage of moves matching top engine recommendations."
                                    }

                                    MetricCard {
                                        label: "Intrinsic Performance Rating (IPR)"
                                        value: formatNumber(dummyMetrics.avg_ipr, 0)
                                        tooltipText: "Performance rating based on move quality, independent of results."
                                    }
                                }
                            }
                        }
                    }

                    // Risk Factors Section
                    Rectangle {
                        width: parent.width
                        height: childrenRect.height + 48
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8

                        Column {
                            anchors.fill: parent
                            anchors.margins: 24
                            spacing: 16

                            Row {
                                spacing: 8

                                Text {
                                    text: "⚠️"
                                    font.pixelSize: 20
                                    color: "#f87171"
                                }

                                Text {
                                    text: "Risk Factors"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "white"
                                }
                            }

                            Text {
                                text: "Specific patterns that contribute to the overall risk assessment."
                                font.pixelSize: 14
                                color: "#9ca3af"
                                wrapMode: Text.WordWrap
                                width: parent.width
                            }

                            Column {
                                width: parent.width
                                spacing: 12

                                Repeater {
                                    model: Object.keys(dummyMetrics.risk.risk_factors)

                                    Row {
                                        width: parent.width

                                        Text {
                                            text: modelData.replace(/_/g, " ").replace(/\b\w/g, function(l){ return l.toUpperCase() })
                                            font.pixelSize: 14
                                            color: "#d1d5db"
                                            width: parent.width * 0.7
                                        }

                                        Text {
                                            text: formatNumber(dummyMetrics.risk.risk_factors[modelData] * 100, 0) + "%"
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: "#f87171"
                                            horizontalAlignment: Text.AlignRight
                                        }
                                    }
                                }

                                Rectangle {
                                    width: parent.width
                                    height: 1
                                    color: "#374151"
                                }

                                MetricCard {
                                    label: "Confidence Level"
                                    value: formatNumber(dummyMetrics.risk.confidence_level * 100, 0) + "%"
                                    tooltipText: "Confidence level of the risk assessment based on available data."
                                }
                            }
                        }
                    }

                    // ROI Analysis Section
                    Rectangle {
                        width: parent.width
                        height: childrenRect.height + 48
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8

                        Column {
                            anchors.fill: parent
                            anchors.margins: 24
                            spacing: 16

                            Row {
                                spacing: 8

                                Text {
                                    text: "💰"
                                    font.pixelSize: 20
                                    color: "#fbbf24"
                                }

                                Text {
                                    text: "Análisis Longitudinal (ROI)"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "white"
                                }
                            }

                            Text {
                                text: "Return on Investment analysis measuring performance consistency over time."
                                font.pixelSize: 14
                                color: "#9ca3af"
                                wrapMode: Text.WordWrap
                                width: parent.width
                            }

                            Grid {
                                width: parent.width
                                columns: 3
                                columnSpacing: 24
                                rowSpacing: 24

                                Rectangle {
                                    width: (parent.width - 48) / 3
                                    height: 120
                                    color: "#374151"
                                    border.color: "#4b5563"
                                    border.width: 1
                                    radius: 8

                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 8

                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: "ROI Medio"
                                            font.pixelSize: 14
                                            color: "#9ca3af"
                                        }

                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: formatNumber(dummyMetrics.roi_mean, 2)
                                            font.pixelSize: 28
                                            font.bold: true
                                            color: "#fbbf24"
                                        }

                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: "Mean ROI"
                                            font.pixelSize: 12
                                            color: "#6b7280"
                                        }
                                    }
                                }

                                Rectangle {
                                    width: (parent.width - 48) / 3
                                    height: 120
                                    color: "#374151"
                                    border.color: "#4b5563"
                                    border.width: 1
                                    radius: 8

                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 8

                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: "ROI Máximo"
                                            font.pixelSize: 14
                                            color: "#9ca3af"
                                        }

                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: formatNumber(dummyMetrics.roi_max, 2)
                                            font.pixelSize: 28
                                            font.bold: true
                                            color: "#4ade80"
                                        }

                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: "Max ROI"
                                            font.pixelSize: 12
                                            color: "#6b7280"
                                        }
                                    }
                                }

                                Rectangle {
                                    width: (parent.width - 48) / 3
                                    height: 120
                                    color: "#374151"
                                    border.color: "#4b5563"
                                    border.width: 1
                                    radius: 8

                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 8

                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: "Desviación ROI"
                                            font.pixelSize: 14
                                            color: "#9ca3af"
                                        }

                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: formatNumber(dummyMetrics.roi_std, 2)
                                            font.pixelSize: 28
                                            font.bold: true
                                            color: "#f87171"
                                        }

                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: "ROI Std Dev"
                                            font.pixelSize: 12
                                            color: "#6b7280"
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Trends Section
                    Rectangle {
                        width: parent.width
                        height: childrenRect.height + 48
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8

                        Column {
                            anchors.fill: parent
                            anchors.margins: 24
                            spacing: 16

                            Row {
                                spacing: 8

                                Text {
                                    text: "📈"
                                    font.pixelSize: 20
                                    color: "#a855f7"
                                }

                                Text {
                                    text: "Tendencias"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "white"
                                }
                            }

                            Text {
                                text: "Performance trend analysis showing changes over time periods."
                                font.pixelSize: 14
                                color: "#9ca3af"
                                wrapMode: Text.WordWrap
                                width: parent.width
                            }

                            Grid {
                                width: parent.width
                                columns: 2
                                columnSpacing: 32
                                rowSpacing: 24

                                Column {
                                    width: (parent.width - 32) / 2
                                    spacing: 20

                                    Rectangle {
                                        width: parent.width
                                        height: 100
                                        color: "#374151"
                                        border.color: "#4b5563"
                                        border.width: 1
                                        radius: 8

                                        Column {
                                            anchors.centerIn: parent
                                            spacing: 4

                                            Text {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: "Tendencia ACPL"
                                                font.pixelSize: 14
                                                color: "#9ca3af"
                                            }

                                            Text {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: formatNumber(dummyMetrics.performance.trend_acpl, 1)
                                                font.pixelSize: 24
                                                font.bold: true
                                                color: dummyMetrics.performance.trend_acpl < 0 ? "#4ade80" : "#f87171"
                                            }

                                            Text {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: "Change per 100 games"
                                                font.pixelSize: 12
                                                color: "#6b7280"
                                            }
                                        }
                                    }

                                    Text {
                                        text: dummyMetrics.performance.trend_acpl < 0 ? 
                                              "✅ Improving accuracy over time" : 
                                              "⚠️ Declining accuracy trend"
                                        font.pixelSize: 12
                                        color: dummyMetrics.performance.trend_acpl < 0 ? "#4ade80" : "#f87171"
                                        wrapMode: Text.WordWrap
                                        width: parent.width
                                    }
                                }

                                Column {
                                    width: (parent.width - 32) / 2
                                    spacing: 20

                                    Rectangle {
                                        width: parent.width
                                        height: 100
                                        color: "#374151"
                                        border.color: "#4b5563"
                                        border.width: 1
                                        radius: 8

                                        Column {
                                            anchors.centerIn: parent
                                            spacing: 4

                                            Text {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: "Tendencia Match Rate"
                                                font.pixelSize: 14
                                                color: "#9ca3af"
                                            }

                                            Text {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: formatNumber(dummyMetrics.performance.trend_match_rate * 100, 1) + "%"
                                                font.pixelSize: 24
                                                font.bold: true
                                                color: dummyMetrics.performance.trend_match_rate > 0 ? "#f87171" : "#4ade80"
                                            }

                                            Text {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: "Change per 100 games"
                                                font.pixelSize: 12
                                                color: "#6b7280"
                                            }
                                        }
                                    }

                                    Text {
                                        text: dummyMetrics.performance.trend_match_rate > 0.02 ? 
                                              "⚠️ Suspicious improvement in engine match rate" : 
                                              "✅ Normal match rate progression"
                                        font.pixelSize: 12
                                        color: dummyMetrics.performance.trend_match_rate > 0.02 ? "#f87171" : "#4ade80"
                                        wrapMode: Text.WordWrap
                                        width: parent.width
                                    }
                                }
                            }
                        }
                    }

                    // Opening Patterns Section
                    Rectangle {
                        width: parent.width
                        height: childrenRect.height + 48
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8

                        Column {
                            anchors.fill: parent
                            anchors.margins: 24
                            spacing: 16

                            Row {
                                spacing: 8

                                Text {
                                    text: "🎯"
                                    font.pixelSize: 20
                                    color: "#10b981"
                                }

                                Text {
                                    text: "Opening Patterns"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "white"
                                }
                            }

                            Text {
                                text: "Analysis of opening repertoire diversity and novelty patterns."
                                font.pixelSize: 14
                                color: "#9ca3af"
                                wrapMode: Text.WordWrap
                                width: parent.width
                            }

                            Grid {
                                width: parent.width
                                columns: 2
                                columnSpacing: 32
                                rowSpacing: 24

                                Column {
                                    width: (parent.width - 32) / 2
                                    spacing: 20

                                    MetricCard {
                                        label: "Mean Entropy"
                                        value: formatNumber(dummyMetrics.opening_patterns.mean_entropy, 2)
                                        tooltipText: "Measure of opening diversity. Higher values indicate more varied opening choices."
                                    }

                                    MetricCard {
                                        label: "Opening Breadth"
                                        value: dummyMetrics.opening_patterns.opening_breadth
                                        tooltipText: "Number of different opening systems played."
                                    }
                                }

                                Column {
                                    width: (parent.width - 32) / 2
                                    spacing: 20

                                    MetricCard {
                                        label: "Novelty Depth"
                                        value: formatNumber(dummyMetrics.opening_patterns.novelty_depth, 1)
                                        tooltipText: "Average move number where theoretical novelties occur."
                                    }

                                    MetricCard {
                                        label: "Second Choice Rate"
                                        value: formatNumber(dummyMetrics.opening_patterns.second_choice_rate * 100, 1) + "%"
                                        tooltipText: "Frequency of playing the engine's second-best move in openings."
                                    }
                                }
                            }
                        }
                    }

                    // Phase Quality Section
                    Rectangle {
                        width: parent.width
                        height: childrenRect.height + 48
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8

                        Column {
                            anchors.fill: parent
                            anchors.margins: 24
                            spacing: 16

                            Row {
                                spacing: 8

                                Text {
                                    text: "⚔️"
                                    font.pixelSize: 20
                                    color: "#f59e0b"
                                }

                                Text {
                                    text: "Phase Quality"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "white"
                                }
                            }

                            Text {
                                text: "Performance analysis across different game phases."
                                font.pixelSize: 14
                                color: "#9ca3af"
                                wrapMode: Text.WordWrap
                                width: parent.width
                            }

                            Grid {
                                width: parent.width
                                columns: 2
                                columnSpacing: 32
                                rowSpacing: 24

                                Column {
                                    width: (parent.width - 32) / 2
                                    spacing: 20

                                    MetricCard {
                                        label: "Opening ACPL"
                                        value: formatNumber(dummyMetrics.phase_quality.opening_acpl, 1)
                                        tooltipText: "Average centipawn loss in opening phase (moves 1-15)."
                                    }

                                    MetricCard {
                                        label: "Endgame ACPL"
                                        value: formatNumber(dummyMetrics.phase_quality.endgame_acpl, 1)
                                        tooltipText: "Average centipawn loss in endgame phase."
                                    }
                                }

                                Column {
                                    width: (parent.width - 32) / 2
                                    spacing: 20

                                    MetricCard {
                                        label: "Middlegame ACPL"
                                        value: formatNumber(dummyMetrics.phase_quality.middlegame_acpl, 1)
                                        tooltipText: "Average centipawn loss in middlegame phase."
                                    }

                                    MetricCard {
                                        label: "Blunder Rate"
                                        value: formatNumber(dummyMetrics.phase_quality.blunder_rate * 100, 1) + "%"
                                        tooltipText: "Percentage of moves classified as blunders (>300cp loss)."
                                    }
                                }
                            }
                        }
                    }

                    // Time Management Section
                    Rectangle {
                        width: parent.width
                        height: childrenRect.height + 48
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8

                        Column {
                            anchors.fill: parent
                            anchors.margins: 24
                            spacing: 16

                            Row {
                                spacing: 8

                                Text {
                                    text: "⏱️"
                                    font.pixelSize: 20
                                    color: "#8b5cf6"
                                }

                                Text {
                                    text: "Time Management"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "white"
                                }
                            }

                            Text {
                                text: "Analysis of time usage patterns and consistency."
                                font.pixelSize: 14
                                color: "#9ca3af"
                                wrapMode: Text.WordWrap
                                width: parent.width
                            }

                            Grid {
                                width: parent.width
                                columns: 2
                                columnSpacing: 32
                                rowSpacing: 24

                                Column {
                                    width: (parent.width - 32) / 2
                                    spacing: 20

                                    MetricCard {
                                        label: "Mean Move Time"
                                        value: formatNumber(dummyMetrics.time_management.mean_move_time, 1) + "s"
                                        tooltipText: "Average time spent per move across all games."
                                    }

                                    MetricCard {
                                        label: "Uniformity Score"
                                        value: formatNumber(dummyMetrics.time_management.uniformity_score, 2)
                                        tooltipText: "Measure of time usage consistency. Values near 0 indicate uniform timing."
                                    }
                                }

                                Column {
                                    width: (parent.width - 32) / 2
                                    spacing: 20

                                    MetricCard {
                                        label: "Time Variance"
                                        value: formatNumber(dummyMetrics.time_management.time_variance, 1)
                                        tooltipText: "Variance in move times. Higher values indicate inconsistent timing."
                                    }

                                    MetricCard {
                                        label: "Lag Spike Count"
                                        value: dummyMetrics.time_management.lag_spike_count
                                        tooltipText: "Number of moves with unusually long thinking times."
                                    }
                                }
                            }
                        }
                    }

                    // Final summary section
                    Rectangle {
                        width: parent.width
                        height: 300
                        color: "#1f2937"
                        border.color: "#374151"
                        border.width: 1
                        radius: 8

                        Column {
                            anchors.fill: parent
                            anchors.margins: 24
                            spacing: 16

                            Row {
                                spacing: 8

                                Text {
                                    text: "🛡️"
                                    font.pixelSize: 20
                                    color: "#60a5fa"
                                }

                                Text {
                                    text: "Analysis Summary"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "white"
                                }
                            }

                            Text {
                                text: "Comprehensive evaluation based on all analyzed metrics."
                                font.pixelSize: 14
                                color: "#9ca3af"
                                wrapMode: Text.WordWrap
                                width: parent.width
                            }

                            Grid {
                                width: parent.width
                                columns: 3
                                columnSpacing: 24
                                rowSpacing: 16

                                Column {
                                    width: (parent.width - 48) / 3
                                    spacing: 8

                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: formatNumber(dummyMetrics.risk.risk_score, 0) + "/100"
                                        font.pixelSize: 32
                                        font.bold: true
                                        color: getRiskColor(dummyMetrics.risk.risk_score)
                                    }

                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: "Final Risk Score"
                                        font.pixelSize: 14
                                        color: "#9ca3af"
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }

                                Column {
                                    width: (parent.width - 48) / 3
                                    spacing: 8

                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: dummyMetrics.games_analyzed
                                        font.pixelSize: 32
                                        font.bold: true
                                        color: "#60a5fa"
                                    }

                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: "Games Analyzed"
                                        font.pixelSize: 14
                                        color: "#9ca3af"
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }

                                Column {
                                    width: (parent.width - 48) / 3
                                    spacing: 8

                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: dummyMetrics.risk.suspicious_games_count
                                        font.pixelSize: 32
                                        font.bold: true
                                        color: "#a855f7"
                                    }

                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: "Suspicious Games"
                                        font.pixelSize: 14
                                        color: "#9ca3af"
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }
                            }

                            Rectangle {
                                width: parent.width
                                height: childrenRect.height + 24
                                color: "#374151"
                                opacity: 0.3
                                radius: 8

                                Text {
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.margins: 12
                                    text: {
                                        var conclusion = "Conclusion: ";
                                        if (dummyMetrics.risk.risk_score >= 75) {
                                            conclusion += "Analysis indicates HIGH risk of external assistance. Detailed investigation recommended.";
                                        } else if (dummyMetrics.risk.risk_score >= 50) {
                                            conclusion += "Analysis indicates MODERATE risk. Some patterns require additional attention.";
                                        } else if (dummyMetrics.risk.risk_score >= 25) {
                                            conclusion += "Analysis indicates LOW risk. Patterns are within normal ranges with minor anomalies.";
                                        } else {
                                            conclusion += "Analysis indicates VERY LOW risk. Play patterns are consistent with natural human behavior.";
                                        }
                                        return conclusion;
                                    }
                                    font.pixelSize: 14
                                    color: "#d1d5db"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
