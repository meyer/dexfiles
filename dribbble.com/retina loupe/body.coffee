do(d = dex.config) ->
    try
        throw "No shot!" unless dribbleShot = document.querySelector ".the-shot"

        shotContainer = dribbleShot.querySelector ".single"
        shotImage = dribbleShot.querySelector ".single-img img"
        retinaShotURL = document.querySelector(".twotimes").href

        # Outta here unless we have a retina shot
        throw "No retina shot URL!" unless retinaShotURL
        shotContainer.classList.add "retina-shot"
        shotContainer.classList.add "loupe-hidden"
        loupeVisible = false

        loupe = document.createElement 'div'
        loupe.id = "retina-loupe"
        loupe.innerHTML = "<div style='background-image:url(#{retinaShotURL});'></div>"

        loupeStyle = document.createElement 'style'

        rect = shotContainer.getBoundingClientRect()

        updateLoupeLocation = (e) ->
            loupeCSS = []
            loupeBkgCSS = []

            mouseX = document.body.scrollLeft + e.x - rect.left
            mouseY = document.body.scrollTop  + e.y - rect.top

            # TODO: Does Dribbble allow shots smaller than 400x300?
            if mouseX >= 0 and mouseX <= rect.width and mouseY >= 0 and mouseY <= rect.height
                shotContainer.classList.remove "loupe-hidden" unless loupeVisible
                loupeVisible = true

                # TODO: CSS3 translate instead of position? maybe?
                loupeCSS.push "left: #{mouseX}px"
                loupeCSS.push "top: #{mouseY}px"

                loupeBkgCSS.push "background-position-x: " + (100 - mouseX * 2 + 40) + "px"
                loupeBkgCSS.push "background-position-y: " + (100 - mouseY * 2 + 40) + "px"

                loupeStyle.innerHTML = "#retina-loupe{#{loupeCSS.join(';')}}\n#retina-loupe div{#{loupeBkgCSS.join(';')}}"
            else
                # loupeStyle.innerHTML = ""
                shotContainer.classList.add "loupe-hidden" if loupeVisible
                loupeVisible = false

        img = new Image()
        img.src = retinaShotURL
        img.onload = ->
            document.body.appendChild loupeStyle
            shotContainer.appendChild loupe

            lastMove = 0
            updatesPerSecond = 60

            document.addEventListener "mousemove", (e) ->
                if Date.now() - lastMove > 1000 / updatesPerSecond
                    lastMove = Date.now()
                    console.log '!!!'
                    updateLoupeLocation(e)

    catch e
        console.log e

    return