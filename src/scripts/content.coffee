chrome.extension.sendMessage {}, (response) ->
    readyStateCheckInterval = setInterval ->
        if document.readyState == "complete"
            clearInterval readyStateCheckInterval
            console.log "Hello. This message was sent from content.js"
        return
    , 10
    return
