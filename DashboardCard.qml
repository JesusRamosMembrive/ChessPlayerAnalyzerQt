import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: card
    
    property string header: ""
    property string value: ""
    property string subtitle: ""
    property string iconName: ""
    property color iconColor: "#6E7681"
    property color valueColor: "#E6EDF3"
    property bool showProgressBar: false
    property real progressValue: 0.0
    property color progressColor: "#17E88D"
    
    color: "#0F1A28"
    radius: 12
    
    Layout.preferredWidth: 320
    Layout.minimumWidth: 280
    Layout.fillHeight: true
    Layout.preferredHeight: 140
    
    // Subtle shadow effect
    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 2
        anchors.leftMargin: 1
        anchors.rightMargin: -1
        anchors.bottomMargin: -2
        color: "#000000"
        opacity: 0.3
        radius: parent.radius
        z: -1
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8
        
        // Header with icon
        RowLayout {
            spacing: 8
            Layout.fillWidth: true
            
            Text {
                text: iconName
                font.family: "FontAwesome"
                font.pixelSize: 16
                color: iconColor
                visible: iconName.length > 0
            }
            
            Text {
                text: header.toUpperCase()
                font.pixelSize: 14
                font.weight: Font.Medium
                font.family: "Inter, SF Pro Display, sans-serif"
                color: "#8B949E"
                Layout.fillWidth: true
            }
        }
        
        // Main value
        Text {
            text: value
            font.pixelSize: 32
            font.weight: Font.DemiBold
            font.family: "Inter, SF Pro Display, sans-serif"
            color: valueColor
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillHeight: true
        }
        
        // Subtitle
        Text {
            text: subtitle
            font.pixelSize: 12
            font.family: "Inter, SF Pro Display, sans-serif"
            color: "#8B949E"
            opacity: 0.6
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            visible: subtitle.length > 0
        }
        
        // Progress bar
        Rectangle {
            Layout.fillWidth: true
            height: 6
            color: "#2D3748"
            radius: 3
            visible: showProgressBar
            
            Rectangle {
                width: parent.width * Math.min(progressValue, 1.0)
                height: parent.height
                color: progressColor
                radius: parent.radius
                
                Behavior on width {
                    NumberAnimation {
                        duration: 800
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
    }
    
    // Hover effect
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: parent.color = "#1A2332"
        onExited: parent.color = "#0F1A28"
    }
}
