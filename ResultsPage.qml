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

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

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
                        text: dummyMetrics.username
                        font.pixelSize: 20
                        font.bold: true
                        color: "white"
                    }

                    Text {
                        text: qsTr("Analysis completed ") + new Date(dummyMetrics.analyzed_at).toLocaleDateString()
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
                    value: formatNumber(dummyMetrics.risk.risk_score, 0) + "/100"
                }
                Card { 
                    title: qsTr("Partidas Analizadas")
                    value: dummyMetrics.games_analyzed.toString()
                }
                Card { 
                    title: qsTr("Rendimiento Intrínseco")
                    value: formatNumber(dummyMetrics.avg_ipr, 0)
                }
                Card { 
                    title: qsTr("Mejora Súbita")
                    value: dummyMetrics.step_function_detected ? qsTr("Detectada") : qsTr("No Detectada")
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
                    value: formatNumber(dummyMetrics.avg_acpl, 1)
                }
                Card { 
                    title: qsTr("Desv. ACPL")
                    value: formatNumber(dummyMetrics.std_acpl, 1)
                }
                Card { 
                    title: qsTr("Coincidencia con el Módulo")
                    value: formatNumber(dummyMetrics.avg_match_rate * 100, 1) + " %"
                }
                Card { 
                    title: qsTr("IPR")
                    value: formatNumber(dummyMetrics.avg_ipr, 0)
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
                    value: dummyMetrics.step_function_detected ? qsTr("Detectada") : qsTr("No Detectada")
                    subtitle: qsTr("Nivel de Confianza ") + formatNumber(dummyMetrics.risk.confidence_level * 100, 0) + " %"
                }
                
                Card {
                    title: qsTr("Nivel de Confianza")
                    value: formatNumber(dummyMetrics.risk.confidence_level * 100, 0) + "%"
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
                    value: formatNumber(dummyMetrics.roi_mean, 2)
                }
                Card { 
                    title: qsTr("ROI Máximo")
                    value: formatNumber(dummyMetrics.roi_max, 2)
                }
                Card { 
                    title: qsTr("Desviación ROI")
                    value: formatNumber(dummyMetrics.roi_std, 2)
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
                    value: formatNumber(dummyMetrics.performance.trend_acpl, 2) + " cp / 100 partidas"
                    subtitle: dummyMetrics.performance.trend_acpl > 0 ? qsTr("Empeoramiento") : qsTr("Mejora")
                }
                
                Card {
                    title: qsTr("Tendencia Match Rate")
                    value: formatNumber(dummyMetrics.performance.trend_match_rate * 100, 1) + "%"
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
                    value: formatNumber(dummyMetrics.opening_patterns.mean_entropy, 2)
                }
                Card { 
                    title: qsTr("Amplitud de Apertura")
                    value: dummyMetrics.opening_patterns.opening_breadth.toString()
                }
                Card { 
                    title: qsTr("Profundidad de Novedad")
                    value: formatNumber(dummyMetrics.opening_patterns.novelty_depth, 1)
                }
                Card { 
                    title: qsTr("Tasa Segunda Opción")
                    value: formatNumber(dummyMetrics.opening_patterns.second_choice_rate * 100, 1) + "%"
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
                    value: formatNumber(dummyMetrics.phase_quality.opening_acpl, 1)
                }
                Card { 
                    title: qsTr("ACPL Medio Juego")
                    value: formatNumber(dummyMetrics.phase_quality.middlegame_acpl, 1)
                }
                Card { 
                    title: qsTr("ACPL Final")
                    value: formatNumber(dummyMetrics.phase_quality.endgame_acpl, 1)
                }
                Card { 
                    title: qsTr("Tasa de Errores")
                    value: formatNumber(dummyMetrics.phase_quality.blunder_rate * 100, 1) + "%"
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
                    value: formatNumber(dummyMetrics.time_management.mean_move_time, 1) + "s"
                }
                Card { 
                    title: qsTr("Varianza de Tiempo")
                    value: formatNumber(dummyMetrics.time_management.time_variance, 1)
                }
                Card { 
                    title: qsTr("Puntuación de Uniformidad")
                    value: formatNumber(dummyMetrics.time_management.uniformity_score, 2)
                }
                Card { 
                    title: qsTr("Picos de Lag")
                    value: dummyMetrics.time_management.lag_spike_count.toString()
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
                    value: formatNumber(dummyMetrics.risk.risk_score, 0) + "/100"
                }
                Card { 
                    title: qsTr("Partidas Analizadas")
                    value: dummyMetrics.games_analyzed.toString()
                }
                Card { 
                    title: qsTr("Partidas Sospechosas")
                    value: dummyMetrics.risk.suspicious_games_count.toString()
                }
            }
        }
    }
