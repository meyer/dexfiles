do(d = dex.config) ->
	likePending = false
	likeIndicatorTime = 1200

	changeFavStatus = (shotID, like_or_unlike) ->
		if likePending
			console.log "ALREADY LIKING SHOT #{likePending}"
			return false
		likePending = shotID
		shotMeta = d.shots[shotID]
		shot = document.getElementById "screenshot-#{shotID}"
		shotLink = shot.getElementsByClassName('dribbble-over')[0]

		# Favorite indicator with fav count
		likeLink = shot.querySelectorAll('li.fav a')[0]

		# Are we toggling?
		if like_or_unlike == 'toggle'
			like_or_unlike = 'like'
			if shotMeta.liked
				like_or_unlike = 'unlike'

		# Ignore everything but like/unlike
		if like_or_unlike != 'like' && like_or_unlike != 'unlike'
			likePending = false
			return

		post_obj =
			data: {}
			type: 'POST'
			url: "#{d.profileURL}/likes"

		if shotMeta.liked && like_or_unlike == 'like'

			showLikeIndicator shotMeta.id, action: 'like'

			console.log "Shot #{shotMeta.id} already liked! Dummy!"
			likePending = false
			return
		else if !shotMeta.liked && like_or_unlike == 'unlike'
			console.log "Shot #{shotMeta.id} already unliked! Stupid!"
			likePending = false
			return

		if like_or_unlike == 'unlike'
			post_obj.data = _method: 'delete'
			post_obj.url = "#{post_obj.url}/#{shotMeta.id}"
		else
			post_obj.url = "#{post_obj.url}?screenshot_id=#{shotMeta.id}"

		console.log "Here’s the plan: we’re gonna #{like_or_unlike} shot number #{shotMeta.id}"

		dex.utils.ajax post_obj, (x, status) ->
			if status == 'success'
				if like_or_unlike == 'unlike'
					# Unlike it!
					likeLink.parentNode.classList.remove 'marked'
					likeLink.innerHTML = --shotMeta.likes_count

					shotMeta.liked = false

					showLikeIndicator shotMeta.id,
						action: 'unlike'

					console.log 'UN LIEK'
				else
					# Like it!
					likeLink.parentNode.classList.add 'marked'
					likeLink.innerHTML = ++shotMeta.likes_count

					shotMeta.liked = true

					showLikeIndicator shotMeta.id,
						action: 'like'

					console.log 'LIEK'

			likePending = false
			return

	showLikeIndicator = (shotID, options) ->
		if likePending
			if parseInt(likePending) != parseInt(shotID)
				console.log 'WAT'
				return false

		unnn = ''

		if 'action' of options
			if options.action == 'like'
			else if options.action == 'unlike'
				unnn = 'un '
			else
				return false

		shot = document.getElementById("screenshot-#{shotID}")
		likeIndicator = document.createElement 'div'
		likeIndicator.classList = '#{unnn}like-indicator'
		likeIndicator.appendChild document.createElement 'div'

		eff = shot.getElementsByClassName('dribbble-shot')[0]
		eff.appendChild likeIndicator

		setTimeout ->
			eff.removeChild likeIndicator
			likePending = false
		, likeIndicatorTime


	# The Loop
	if d.loggedIn

		# Might need to be bumped to ~400ms
		clickTime = 300
		dblclkTimeout = false

		if d.shots
			for id, shotMeta of d.shots
				do (id,shotMeta) ->
					shot = document.getElementById "screenshot-#{shotMeta.id}"

					# Click tiny heart to like. Might nuke this. idk.
					shot.querySelectorAll("li.fav a")[0].addEventListener 'click', (e) ->
						changeFavStatus(shotMeta.id, 'toggle')
						e.preventDefault()
					, false

					# Double-click to like
					clickCount = 0
					shot.getElementsByClassName('dribbble-over')[0].addEventListener 'click', (e) ->
						return if e.metaKey # command-clicked?

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

						e.preventDefault()