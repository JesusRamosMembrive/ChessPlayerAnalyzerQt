import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    property string label: ""
    property string value: ""
    property string tooltipText: ""

    implicitHeight: 40
    implicitWidth: parent.width

    RowLayout {
        anchors.fill: parent
        spacing: 8

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Text {
                text: root.label
                color: "#d1d5db"
                font.pixelSize: 14
            }

            Rectangle {
                width: 16
                height: 16
                color: "transparent"

                Text {
                    anchors.centerIn: parent
                    text: "?"
                    color: "#6b7280"
                    font.pixelSize: 12
                    font.bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    ToolTip {
                        visible: parent.containsMouse
                        text: root.tooltipText
                        delay: 100
                        timeout: 5000
                        background: Rectangle {
                            color: "#111827"
                            border.color: "#374151"
                            border.width: 1
                            radius: 4
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 12
                            wrapMode: Text.WordWrap
                        }
                    }
                }
            }
        }

        Text {
            text: root.value
            color: "white"
            font.pixelSize: 14
            font.weight: Font.DemiBold
            Layout.alignment: Qt.AlignRight
        }
    }
}
