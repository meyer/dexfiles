itemsBlocked = 0

naughtyURLs = [
    "/resource/ContextLogResource/create/"
    "/resource/UserHomefeedResource/get/"
    "/resource/UpdatesResource/get/"
]

$(document).ready ->
    $(document).ajaxSuccess (e,x,s) ->
        url = s.url.split("?")[0]
        if ~naughtyURLs.indexOf(url)
            # I love you, Sizzle.
            $newItems = $(".recommendationReason").closest(".item:not(.related-pin)")
            itemsBlocked += $newItems.length

            console.log "#{$newItems.length} items blocked (total: #{itemsBlocked})"

            $newItems.addClass("related-pin")
        else
            console.log "URL #{url} is not any of our concern."