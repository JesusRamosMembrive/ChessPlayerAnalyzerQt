import QtQuick 2.15
import QtQuick.Controls 2.15
import ChessAnalyzer 1.0

RootLayout {
    id: app
    
    Component.onCompleted: {
        console.log("Chess Analyzer Qt application started")
    }
    
    Connections {
        target: app.contentItem
        
        function onAnalysisRequested(username) {
            console.log("Analysis requested for:", username)
        }
        
        function onPlayerClicked(username) {
            console.log("Player clicked:", username)
            app.navigateTo("ResultsPage")
            if (app.contentItem && typeof app.contentItem.username !== "undefined") {
                app.contentItem.username = username
            }
        }
        
        function onBackRequested() {
            console.log("Back requested")
            app.navigateTo("HomePage")
        }
        
        function onShareRequested() {
            console.log("Share requested")
        }
        
        function onExportRequested() {
            console.log("Export requested")
        }
    }
}
