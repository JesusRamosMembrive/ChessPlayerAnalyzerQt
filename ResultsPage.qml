import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: resultsPage
    background: Rectangle {
        color: "#000000"
    }

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

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        visible: isLoading

        Column {
            anchors.centerIn: parent
            spacing: 16

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "⏳"
                font.pixelSize: 48
                color: "white"
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Loading player metrics..."
                font.pixelSize: 18
                color: "#9ca3af"
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        visible: !isLoading && errorMessage.length > 0

        Column {
            anchors.centerIn: parent
            spacing: 16

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "⚠️"
                font.pixelSize: 48
                color: "#ef4444"
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Error loading player data"
                font.pixelSize: 18
                font.bold: true
                color: "white"
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: errorMessage
                font.pixelSize: 14
                color: "#9ca3af"
                wrapMode: Text.WordWrap
                width: 400
                horizontalAlignment: Text.AlignHCenter
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 120
                height: 40
                color: "#374151"
                radius: 6

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (resultsPage.StackView.view) {
                            resultsPage.StackView.view.pop();
                        }
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: "← Back"
                    font.pixelSize: 14
                    color: "white"
                }
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        visible: !isLoading && errorMessage.length === 0 && playerMetrics !== null

        ColumnLayout {
            id: rootLayout
            width: parent.width
            spacing: 40

            // Header with back button
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 72

                Rectangle {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    color: "#374151"
                    radius: 6

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (resultsPage.StackView.view) {
                                resultsPage.StackView.view.pop();
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

                Rectangle {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    color: "#16a34a"
                    radius: 20

                    Text {
                        anchors.centerIn: parent
                        text: "👤"
                        font.pixelSize: 20
                        color: "white"
                    }
                }

                ColumnLayout {
                    spacing: 2

                    Text {
                        text: playerMetrics ? playerMetrics.username : username
                        font.pixelSize: 20
                        font.bold: true
                        color: "white"
                    }

                    Text {
                        text: playerMetrics ? qsTr("Analysis completed ") + new Date(playerMetrics.analyzed_at).toLocaleDateString() : ""
                        font.pixelSize: 14
                        color: "#9ca3af"
                    }
                }

                Item { Layout.fillWidth: true } // Spacer

                RowLayout {
                    spacing: 12

                    Rectangle {
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 32
                        color: "transparent"
                        border.color: "#374151"
                        border.width: 1
                        radius: 6

                        Text {
                            anchors.centerIn: parent
                            text: qsTr("📤 Share")
                            font.pixelSize: 12
                            color: "white"
                        }
                    }

                    Rectangle {
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 32
                        color: "transparent"
                        border.color: "#374151"
                        border.width: 1
                        radius: 6

                        Text {
                            anchors.centerIn: parent
                            text: qsTr("💾 Export")
                            font.pixelSize: 12
                            color: "white"
                        }
                    }
                }
            }

            /* ───────── KPIs superiores ───────── */
            RowLayout {
                Layout.fillWidth: true
                spacing: 32

                Card {
                    title: qsTr("Puntuación de Riesgo")
                    value: playerMetrics ? formatNumber(playerMetrics.risk.risk_score, 0) + "/100" : "N/A"
                }
                Card {
                    title: qsTr("Partidas Analizadas")
                    value: playerMetrics ? playerMetrics.games_analyzed.toString() : "N/A"
                }
                Card {
                    title: qsTr("Rendimiento Intrínseco")
                    value: playerMetrics ? formatNumber(playerMetrics.avg_ipr, 0) : "N/A"
                }
                Card {
                    title: qsTr("Mejora Súbita")
                    value: playerMetrics ? (playerMetrics.step_function_detected ? qsTr("Detectada") : qsTr("No Detectada")) : "N/A"
                }
            }

            /* ───────── Métricas de Calidad ───────── */
            Label {
                text: qsTr("Métricas de Calidad")
                font.bold: true
                color: "white"
                font.pixelSize: 18
            }
            GridLayout {
                id: qualityGrid
                columns: 2
                columnSpacing: 32
                rowSpacing: 32
                Layout.fillWidth: true

                Card {
                    title: qsTr("Pérdida Media (ACPL)")
                    value: playerMetrics ? formatNumber(playerMetrics.avg_acpl, 1) : "N/A"
                }
                Card {
                    title: qsTr("Desv. ACPL")
                    value: playerMetrics ? formatNumber(playerMetrics.std_acpl, 1) : "N/A"
                }
                Card {
                    title: qsTr("Coincidencia con el Módulo")
                    value: playerMetrics ? formatNumber(playerMetrics.avg_match_rate * 100, 1) + " %" : "N/A"
                }
                Card {
                    title: qsTr("IPR")
                    value: playerMetrics ? formatNumber(playerMetrics.avg_ipr, 0) : "N/A"
                }
            }

            /* ───────── Factores de Riesgo ───────── */
            Label {
                text: qsTr("Factores de Riesgo")
                font.bold: true
                color: "white"
                font.pixelSize: 18
            }
            GridLayout {
                columns: 2
                columnSpacing: 32
                rowSpacing: 32
                Layout.fillWidth: true

                Card {
                    title: qsTr("Step Function")
                    value: playerMetrics ? (playerMetrics.step_function_detected ? qsTr("Detectada") : qsTr("No Detectada")) : "N/A"
                    subtitle: playerMetrics ? qsTr("Nivel de Confianza ") + formatNumber(playerMetrics.risk.confidence_level * 100, 0) + " %" : ""
                }

                Card {
                    title: qsTr("Nivel de Confianza")
                    value: playerMetrics ? formatNumber(playerMetrics.risk.confidence_level * 100, 0) + "%" : "N/A"
                    subtitle: qsTr("Factores de Riesgo")
                }
            }

            /* ───────── Análisis Longitudinal ───────── */
            Label {
                text: qsTr("Análisis Longitudinal (ROI)")
                font.bold: true
                color: "white"
                font.pixelSize: 18
            }
            RowLayout {
                Layout.fillWidth: true
                spacing: 32

                Card {
                    title: qsTr("ROI Medio")
                    value: playerMetrics ? formatNumber(playerMetrics.roi_mean, 2) : "N/A"
                }
                Card {
                    title: qsTr("ROI Máximo")
                    value: playerMetrics ? formatNumber(playerMetrics.roi_max, 2) : "N/A"
                }
                Card {
                    title: qsTr("Desviación ROI")
                    value: playerMetrics ? formatNumber(playerMetrics.roi_std, 2) : "N/A"
                }
            }

            /* ───────── Tendencias ───────── */
            Label {
                text: qsTr("Tendencias")
                font.bold: true
                color: "white"
                font.pixelSize: 18
            }
            GridLayout {
                columns: 2
                columnSpacing: 32
                rowSpacing: 32
                Layout.fillWidth: true

                Card {
                    title: qsTr("Tendencia ACPL")
                    value: playerMetrics ? formatNumber(playerMetrics.performance.trend_acpl, 2) + " cp / 100 partidas" : "N/A"
                    subtitle: playerMetrics ? (playerMetrics.performance.trend_acpl > 0 ? qsTr("Empeoramiento") : qsTr("Mejora")) : ""
                }

                Card {
                    title: qsTr("Tendencia Match Rate")
                    value: playerMetrics ? formatNumber(playerMetrics.performance.trend_match_rate * 100, 1) + "%" : "N/A"
                    subtitle: qsTr("Análisis de tendencias temporales")
                }
            }

            /* ───────── Patrones de Apertura ───────── */
            Label {
                text: qsTr("Patrones de Apertura")
                font.bold: true
                color: "white"
                font.pixelSize: 18
            }
            GridLayout {
                columns: 2
                columnSpacing: 32
                rowSpacing: 32
                Layout.fillWidth: true

                Card {
                    title: qsTr("Entropía Media")
                    value: playerMetrics ? formatNumber(playerMetrics.opening_patterns.mean_entropy, 2) : "N/A"
                }
                Card {
                    title: qsTr("Amplitud de Apertura")
                    value: playerMetrics ? playerMetrics.opening_patterns.opening_breadth.toString() : "N/A"
                }
                Card {
                    title: qsTr("Profundidad de Novedad")
                    value: playerMetrics ? formatNumber(playerMetrics.opening_patterns.novelty_depth, 1) : "N/A"
                }
                Card {
                    title: qsTr("Tasa Segunda Opción")
                    value: playerMetrics ? formatNumber(playerMetrics.opening_patterns.second_choice_rate * 100, 1) + "%" : "N/A"
                }
            }

            /* ───────── Calidad por Fases ───────── */
            Label {
                text: qsTr("Calidad por Fases")
                font.bold: true
                color: "white"
                font.pixelSize: 18
            }
            GridLayout {
                columns: 2
                columnSpacing: 32
                rowSpacing: 32
                Layout.fillWidth: true

                Card {
                    title: qsTr("ACPL Apertura")
                    value: playerMetrics ? formatNumber(playerMetrics.phase_quality.opening_acpl, 1) : "N/A"
                }
                Card {
                    title: qsTr("ACPL Medio Juego")
                    value: playerMetrics ? formatNumber(playerMetrics.phase_quality.middlegame_acpl, 1) : "N/A"
                }
                Card {
                    title: qsTr("ACPL Final")
                    value: playerMetrics ? formatNumber(playerMetrics.phase_quality.endgame_acpl, 1) : "N/A"
                }
                Card {
                    title: qsTr("Tasa de Errores")
                    value: playerMetrics ? formatNumber(playerMetrics.phase_quality.blunder_rate * 100, 1) + "%" : "N/A"
                }
            }

            /* ───────── Gestión del Tiempo ───────── */
            Label {
                text: qsTr("Gestión del Tiempo")
                font.bold: true
                color: "white"
                font.pixelSize: 18
            }
            GridLayout {
                columns: 2
                columnSpacing: 32
                rowSpacing: 32
                Layout.fillWidth: true

                Card {
                    title: qsTr("Tiempo Medio por Jugada")
                    value: playerMetrics ? formatNumber(playerMetrics.time_management.mean_move_time, 1) + "s" : "N/A"
                }
                Card {
                    title: qsTr("Varianza de Tiempo")
                    value: playerMetrics ? formatNumber(playerMetrics.time_management.time_variance, 1) : "N/A"
                }
                Card {
                    title: qsTr("Puntuación de Uniformidad")
                    value: playerMetrics ? formatNumber(playerMetrics.time_management.uniformity_score, 2) : "N/A"
                }
                Card {
                    title: qsTr("Picos de Lag")
                    value: playerMetrics ? playerMetrics.time_management.lag_spike_count.toString() : "N/A"
                }
            }

            /* ───────── Resumen Final ───────── */
            Label {
                text: qsTr("Resumen del Análisis")
                font.bold: true
                color: "white"
                font.pixelSize: 18
            }
            RowLayout {
                Layout.fillWidth: true
                spacing: 32

                Card {
                    title: qsTr("Puntuación Final")
                    value: playerMetrics ? formatNumber(playerMetrics.risk.risk_score, 0) + "/100" : "N/A"
                }
                Card {
                    title: qsTr("Partidas Analizadas")
                    value: playerMetrics ? playerMetrics.games_analyzed.toString() : "N/A"
                }
                Card {
                    title: qsTr("Partidas Sospechosas")
                    value: playerMetrics ? playerMetrics.risk.suspicious_games_count.toString() : "N/A"
                }
            }
        }
    }
}
