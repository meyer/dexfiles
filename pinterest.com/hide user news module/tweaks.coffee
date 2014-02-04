itemsBlocked = 0

naughtyURLs = [
    "/resource/ContextLogResource/create/"
    "/resource/UserHomefeedResource/get/"
]

$(document).ready ->
    $(document).ajaxSuccess (e,x,s) ->
        if ~naughtyURLs.indexOf(s.url)
            # I love you, Sizzle.
            $newItems = $(".pickedForYou").closest(".item:not(.related-pin)")
            itemsBlocked += $newItems.length

            console.log "#{$newItems.length} items blocked (total: #{itemsBlocked})"

            $newItems.addClass("related-pin")
        else
            console.log "URL #{s.url} is not any of our concern."