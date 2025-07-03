import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    property string label: ""
    property string value: ""
    property string tooltipText: ""

    width: parent.width
    height: 60
    color: "transparent"

    Row {
        anchors.fill: parent
        spacing: 8

        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 0.65
            spacing: 4

            Text {
                text: label
                font.pixelSize: 14
                color: "#d1d5db"
                wrapMode: Text.WordWrap
                width: parent.width
            }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: value
            font.pixelSize: 16
            font.bold: true
            color: "white"
            horizontalAlignment: Text.AlignRight
            width: parent.width * 0.25
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 16
            height: 16
            color: "transparent"
            visible: tooltipText.length > 0

            Text {
                anchors.centerIn: parent
                text: "?"
                font.pixelSize: 12
                color: "#6b7280"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                Rectangle {
                    id: tooltip
                    visible: parent.containsMouse
                    x: parent.width + 5
                    y: -height/2 + parent.height/2
                    width: tooltipText.length > 50 ? 300 : 200
                    height: tooltipTextItem.height + 16
                    color: "#1f2937"
                    border.color: "#374151"
                    border.width: 1
                    radius: 6
                    z: 1000

                    Text {
                        id: tooltipTextItem
                        anchors.centerIn: parent
                        text: tooltipText
                        font.pixelSize: 12
                        color: "white"
                        wrapMode: Text.WordWrap
                        width: parent.width - 12
                    }
                }
            }
        }
    }
}
