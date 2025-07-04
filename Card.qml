import QtQuick 2.15
import QtQuick.Controls 2.15

Frame {
    id: root
    property alias title:  titleLabel.text
    property alias value:  valueLabel.text
    property alias subtitle: subtitleLabel.text    // opcional

    padding: 24
    background: Rectangle {           // mismo estilo para todos
        color: "#111d30"
        radius: 8
        border.color: "#223347"
        border.width: 1
    }

    Column {
        spacing: 16
        width: parent.width
        Text {
            id: titleLabel
            color: "#8fa3bc"
            font.pixelSize: 20
            font.weight: Font.Medium
            wrapMode: Text.WordWrap
            width: parent.width
        }
        Text {
            id: valueLabel
            color: "white"
            font.pixelSize: 48
            font.bold: true
            wrapMode: Text.WordWrap
            width: parent.width
        }
        Text {
            id: subtitleLabel
            color: "#f39c12"
            font.pixelSize: 18
            visible: subtitle !== ""
            wrapMode: Text.WordWrap
            width: parent.width
        }
    }

    implicitWidth: 350               // valores mínimos para layout aún más grandes
    implicitHeight: 180
}
