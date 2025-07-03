import QtQuick 2.15

QtObject {
    id: apiService
    
    property string baseUrl: "http://localhost:8000"
    
    signal playersLoaded(var players)
    signal playersError(string error)
    signal metricsLoaded(var metrics)
    signal metricsError(string error)
    signal analysisStarted(string taskId)
    signal analysisError(string error)
    
    function fetchPlayers() {
        var xhr = new XMLHttpRequest()
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    try {
                        var response = JSON.parse(xhr.responseText)
                        playersLoaded(response)
                    } catch (e) {
                        playersError("Failed to parse players response: " + e.message)
                    }
                } else {
                    playersError("Failed to fetch players: " + xhr.status + " " + xhr.statusText)
                }
            }
        }
        xhr.open("GET", baseUrl + "/api/players")
        xhr.send()
    }
    
    function fetchPlayerMetrics(username) {
        var xhr = new XMLHttpRequest()
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    try {
                        var response = JSON.parse(xhr.responseText)
                        metricsLoaded(response)
                    } catch (e) {
                        metricsError("Failed to parse metrics response: " + e.message)
                    }
                } else {
                    metricsError("Failed to fetch metrics: " + xhr.status + " " + xhr.statusText)
                }
            }
        }
        xhr.open("GET", baseUrl + "/api/metrics/player/" + encodeURIComponent(username))
        xhr.send()
    }
    
    function analyzePlayer(username) {
        var xhr = new XMLHttpRequest()
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    try {
                        var response = JSON.parse(xhr.responseText)
                        analysisStarted(response.task_id || "Analysis started")
                    } catch (e) {
                        analysisError("Failed to parse analysis response: " + e.message)
                    }
                } else {
                    analysisError("Failed to start analysis: " + xhr.status + " " + xhr.statusText)
                }
            }
        }
        xhr.open("POST", baseUrl + "/api/analyze")
        xhr.setRequestHeader("Content-Type", "application/json")
        xhr.send(JSON.stringify({username: username}))
    }
}
