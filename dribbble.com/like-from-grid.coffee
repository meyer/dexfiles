profile_url = $('#t-profile>a').attr('href')

likePending = false

SHOTS_BY_ID = {}

changeFavStatus = (shotID, like_or_unlike) ->
	if likePending
		console.log "ALREADY LIKING SHOT #{likePending}"
		return false
	likePending = shotID
	shot = SHOTS_BY_ID[shotID]
	$shot = $("#screenshot-#{shotID}")
	$shotLink = $('.dribbble-over', $shot)

	# Favorite indicator with fav count
	$likeLink = $('li.fav a',$shot)

	# Are we toggling?
	if like_or_unlike == 'toggle'
		like_or_unlike = 'like'
		if shot.liked
			like_or_unlike = 'unlike'

	# Ignore everything but like/unlike
	if like_or_unlike != 'like' && like_or_unlike != 'unlike'
		likePending = false
		return

	post_obj =
		data: {}
		type: 'POST'
		url: "#{profile_url}/likes"

	if shot.liked && like_or_unlike == 'like'
		$likeIndicator = $('<div class="like-indicator"><div></div></div>')
		$('.dribbble-img', $shot).append $likeIndicator
		setTimeout ->
			$likeIndicator.remove()
		, 1000

		console.log "Shot #{shot.id} already liked! Dummy!"
		likePending = false
		return
	else if !shot.liked && like_or_unlike == 'unlike'
		console.log "Shot #{shot.id} already unliked! Stupid!"
		likePending = false
		return

	if like_or_unlike == 'unlike'
		post_obj.data = _method: 'delete'
		post_obj.url = "#{post_obj.url}/#{shot.id}"
	else
		post_obj.url = "#{post_obj.url}?screenshot_id=#{shot.id}"

	console.log "Here’s the plan: we’re gonna #{like_or_unlike} shot number #{shot.id}"

	$.ajax(post_obj).complete (x, status) ->
		if status == 'success'
			if like_or_unlike == 'unlike'
				# Unlike it!
				$likeLink.parent().removeClass 'marked'
				$likeLink.text --shot.likes_count

				shot.liked = false

				$likeIndicator = $('<div class="un like-indicator"><div></div></div>')
				$('.dribbble-img', $shot).append $likeIndicator
				setTimeout ->
					$likeIndicator.remove()
				, 1000

				console.log "Succesfully unliked shot #{shot.id}"
			else
				# Like it!
				$likeLink.parent().addClass 'marked'
				$likeLink.text ++shot.likes_count

				shot.liked = true

				$likeIndicator = $('<div class="like-indicator"><div></div></div>')
				$('.dribbble-img', $shot).append $likeIndicator
				setTimeout ->
					$likeIndicator.remove()
				, 1000

				console.log "Succesfully liked shot #{shot.id}"

		likePending = false
		return

# Might need to be bumped to ~400ms
clickTime = 300
dblclkTimeout = false

if typeof SHOTS != 'undefined'
	for shot in SHOTS

		SHOTS_BY_ID[shot.id] = shot

		do (shot) -> # let’s do shots!
			$shot = $("#screenshot-#{shot.id}")

			# Click tiny heart to like. Might nuke this. idk.
			$("li.fav a", $shot).click ->
				changeFavStatus(shot.id, 'toggle')
				return false

			# Double-click to like
			clickCount = 0
			$('.dribbble-over', $shot).click ->
				clickCount++
				clearTimeout dblclkTimeout
				if clickCount >= 2
					if clickCount == 2
						changeFavStatus(shot.id, 'like')
					else
						console.log clickCount + ' clicks and counting!'
					dblclkTimeout = setTimeout ->
						clickCount = 0
					, clickTime
				else
					dblclkTimeout = setTimeout =>
						if clickCount != 2
							console.log 'Double-click didn’t happen. *single tear rolls down face*'
							document.location.href = $(@).attr 'href'
						clickCount = 0
					, clickTime

				return false