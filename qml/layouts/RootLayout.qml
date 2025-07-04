import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: window
    
    property string appTitle: "Chess Analyzer"
    property string appDescription: "Analyze chess performance and detect patterns"
    
    width: 1200
    height: 800
    visible: true
    title: appTitle
    color: "#000000"
    
    property alias contentItem: contentLoader.item
    property string currentPage: "HomePage"
    
    Loader {
        id: contentLoader
        anchors.fill: parent
        source: "../pages/" + window.currentPage + ".qml"
        
        onLoaded: {
            if (item && typeof item.parentWindow !== "undefined") {
                item.parentWindow = window
            }
        }
    }
    
    function navigateTo(pageName) {
        currentPage = pageName
    }
}
