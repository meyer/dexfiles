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

###

# SHOTS has everything we need and is also unaccessible. FML.

profile_url = $('#t-profile>a').attr('href')

$('#shots ol.dribbbles>li').each ->
	$shot = $(@)
	shot_id = $shot.attr('id').replace 'screenshot-',''
	$li = $('li.fav',$shot)

	$li.children('a').click ->
		faved = $li.hasClass 'marked'
		console.log "Shot #{shot_id} fav status: #{faved}"

		post_obj =
			data: {}
			url: "#{profile_url}/likes"

		if faved
			post_obj.data = _method: 'delete'
			post_obj.url = "#{post_obj.url}/#{shot_id}"
		else
			post_obj.url = "#{post_obj.url}?screenshot_id=#{shot_id}"

		console.log post_obj

		$.ajax(post_obj).complete (x, status) ->
			if status == 'success'
				if faved
					$li.removeClass 'marked'
				else
					$li.addClass 'marked'

				console.log "Succesfully did that thing."
			else
				console.log "Fuck."
			console.log "Output:"
			console.log x

		false