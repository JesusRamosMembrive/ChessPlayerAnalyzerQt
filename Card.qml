import QtQuick 2.15
import QtQuick.Controls 2.15

Frame {
    id: root
    property alias title:  titleLabel.text
    property alias value:  valueLabel.text
    property alias subtitle: subtitleLabel.text    // opcional

    padding: 12
    background: Rectangle {           // mismo estilo para todos
        color: "#111d30"
        radius: 8
        border.color: "#223347"
    }

    Column {
        spacing: 4
        width: parent.width
        Text { id: titleLabel;   color: "#8fa3bc"; font.pixelSize: 13 }
        Text { id: valueLabel;   color: "white";  font.pixelSize: 26; font.bold: true }
        Text { id: subtitleLabel; color: "#f39c12"; font.pixelSize: 11; visible: subtitle !== "" }
    }

    implicitWidth: 140               // valores mínimos para layout
    implicitHeight: 80
}
