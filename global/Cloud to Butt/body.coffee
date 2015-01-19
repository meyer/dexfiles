# Cloud to Butt™
# All the hard work done by Steven Frank
# https://github.com/panicsteve/cloud-to-butt

try

    badWords =
        "My Butt": /\bThe Cloud\b/g
        "My butt": /\bThe cloud\b/g
        "my Butt": /\bthe Cloud\b/g
        "my butt": /\bthe cloud\b/g
        "butt": /\bcloud\b/g
        "Butt": /\bCloud\b/g

    walk = (node) ->
        # I stole this function from here:
        # http://is.gd/mwZp7E
        switch node.nodeType
            when 1, 9, 11  # element, document, document fragment
                child = node.firstChild
                while child
                    next = child.nextSibling
                    walk child
                    child = next

            when 3 # Text node
                handleText node
                break

    handleText = (textNode) ->
        v = textNode.nodeValue

        for replacement, regex of badWords
            v = v.replace regex, replacement

        textNode.nodeValue = v

    walk document.body
catch e
    console.log "cloud2butt: #{e}"