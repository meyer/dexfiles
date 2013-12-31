do(d = dex.config) ->
    likePending = false
    likeIndicatorTime = 1200

    changeFavStatus = (shotID, like_or_unlike) ->
        # try
        throw "ALREADY LIKING SHOT #{likePending}" if likePending
        likePending = shotID
        shotMeta = d.shots[shotID]
        shot = document.getElementById "screenshot-#{shotID}"
        shotLink = shot.querySelector '.dribbble-over'
        likeLink = shot.querySelector 'li.fav a'

        post_obj =
            data: {}
            type: 'POST'
            url: "#{d.profileURL}/likes"

        switch like_or_unlike
            when 'like'
                if shotMeta.liked
                    showLikeIndicator shotMeta.id, action: 'like'
                    likePending = false
                    throw "Shot #{shotMeta.id} already liked! Dummy!"
                post_obj.url = "#{post_obj.url}?screenshot_id=#{shotMeta.id}"

            when 'unlike'
                unless shotMeta.liked
                    likePending = false
                    throw "Shot #{shotMeta.id} already unliked! Stupid!"
                post_obj.data = {_method: 'delete'}
                post_obj.url = "#{post_obj.url}/#{shotMeta.id}"

            when 'toggle'
                like_or_unlike = if shotMeta.liked then 'unlike' else 'like'

            else throw "invalid option: #{like_or_unlike}"

        console.log "Here’s the plan: we’re gonna #{like_or_unlike} shot number #{shotMeta.id}"

        jQuery.ajax post_obj.url, post_obj.data, (x, status) ->
            likePending = false
            throw "AJAX error" unless status is 'success'

            switch like_or_unlike
                when 'unlike'
                    likeLink.parentNode.classList.remove 'marked'
                    likeLink.innerHTML = --shotMeta.likes_count
                    shotMeta.liked = false
                    showLikeIndicator shotMeta.id, action: 'unlike'
                    console.log 'UN LIEK'

                when 'like'
                    likeLink.parentNode.classList.add 'marked'
                    likeLink.innerHTML = ++shotMeta.likes_count
                    shotMeta.liked = true
                    showLikeIndicator shotMeta.id, action: 'like'
                    console.log 'LIEK'

            return

        # catch e
        #     console.log "changeFavStatus error: #{e}"
        #     console.log e

    showLikeIndicator = (shotID, options) ->
        if likePending
            throw "likePending != shotID" unless (likePending|0) is (shotID|0)

        unnn = ""

        if 'action' of options
            switch options.action
                when 'like' then break
                when 'unlike' then unnn = 'un '
                else throw "invalid action: #{options.action}"

        shot = document.getElementById("screenshot-#{shotID}")
        likeIndicator = document.createElement 'div'
        likeIndicator.classList.add '#{unnn}like-indicator'
        likeIndicator.appendChild document.createElement 'div'

        eff = shot.querySelector '.dribbble-shot'
        eff.appendChild likeIndicator

        setTimeout ->
            eff.removeChild likeIndicator
            likePending = false
        , likeIndicatorTime


    try
        throw "not logged in" unless d.loggedIn
        throw "no shots" unless d.shots

        # Might need to be bumped to ~400ms
        clickTime = 300
        dblclkTimeout = false


        for id, shotMeta of d.shots
            do (id, shotMeta) ->
                shot = document.getElementById "screenshot-#{shotMeta.id}"

                # Click tiny heart to like. Might nuke this. idk.
                shot.querySelector("li.fav a").addEventListener 'click', (e) ->
                    changeFavStatus(shotMeta.id, 'toggle')
                    e.preventDefault()
                , false

                # Double-click to like
                clickCount = 0
                shot.querySelector('.dribbble-over').addEventListener 'click', (e) ->
                    if e.metaKey # command-clicked?
                        console.log "command click’d"
                        return

                    e.preventDefault()

                    clickCount++
                    clearTimeout dblclkTimeout

                    if clickCount >= 2
                        if clickCount == 2
                            changeFavStatus(shotMeta.id, 'like')
                        else
                            console.log clickCount + ' clicks and counting!'
                        dblclkTimeout = setTimeout ->
                            clickCount = 0
                        , clickTime
                    else
                        dblclkTimeout = setTimeout =>
                            if clickCount != 2
                                console.log 'Double-click didn’t happen. *single tear rolls down face*'
                                console.log e.target.href
                                document.location.href = e.target.href
                            clickCount = 0
                        , clickTime

    catch e
        console.log "like from grid error: #{e}"