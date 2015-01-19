try
    document.querySelector('meta[name=pinterest]').name = 'please-pin-anything'
    console.log "Removed nopin meta tag. Go forth and pin!"
catch
    console.log "nopin meta tag was not found."

try
    images = document.querySelectorAll('img[nopin]')
    throw "No unpinnable images found." unless images.length
    images.forEach (img) ->
        console.log "- #{img.src} is now pinnable."
        img.removeAttribute 'nopin'
catch e
    console.log e