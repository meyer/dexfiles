# Nuke picturefill on the grid page
# TODO: Make this sexier.

$('#shots ol.group div[data-picture]').removeAttr('data-picture').each ->
	$div = $(@)
	retinaURL = $('div[data-media]', $div).data 'src'
	# Animate? Suuuure.
	retinaURL = retinaURL.replace '_still.gif', '.gif'
	$('<img src="'+retinaURL+'">').appendTo $div

	###

	DRIBBBLE SHOT LIKE API NOTES
	============================

	Text after the ID is optional.

	I guess they’re just chopping off the non-integer stuff
	when they look up the shot (smart).

	To like and unlike shot 123456, respectively:
	POST /$username/likes?screenshot_id=123456[-Shot-URL]
	POST /$username/likes/123456[-Shot-URL] ? _method: 'delete'

	Here’s what I don’t get… the goofy URLs. Why not something like:

	LIKE URL:   /meyer/liked/123456
	UNLIKE URL: /meyer/unliked/123456

	or:

	LIKE URL:   /shot/123456-Shot-URL?action=like
	UNLIKE URL: /shot/123456-Shot-URL?action=dislike

	??

	Whatever.

	##

	if single_shot_page

		post_obj=
			data: {}
			url: "/#{username}/likes"
			complete: (x, status) ->
				if status == 'success'
					console.log "Succesfully did that thing."
				else
					console.log "Fuck."

		if $('indicator').hasClass 'liked'
			post_obj.url = _method: 'delete'
			post_obj.url = "#{post_data.url}/#{shot_id}"
		else
			post_obj.url = "#{post_data.url}?screenshot_id=#{shot_id}"

		# Do Ajax thing

	###