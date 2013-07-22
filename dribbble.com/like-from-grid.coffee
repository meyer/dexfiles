###

DRIBBBLE SHOT LIKE API NOTES
============================

Text after the ID is optional.

To like and unlike shot 123456, respectively:
POST /$username/likes?screenshot_id=123456[-Shot-URL]
POST /$username/likes/123456[-Shot-URL] ? _method: 'delete'

###

profile_url = $('#t-profile>a').attr('href')

console.log "Profile URL: #{profile_url}"

if typeof SHOTS != 'undefined'
	for shot in SHOTS
		do (shot) -> # let’s do shots!
			# attachments_count: 0
			# commented_on: false
			# comments_count: 12
			# comments_since_last_view: true
			# created_at: "July 21, 2013"
			# id: 1164032
			# is_rebound: false
			# liked: true
			# liked_by_html: null
			# likes_count: 114
			# rebounds_count: 0
			# view_count: 1445

			$shot = $("#screenshot-#{shot.id}")
			shotTitle = $('.dribbble-over strong', $shot).text()
			$li = $('li.fav',$shot)

			$li.children('a').click ->
				$a = $(@)

				post_obj =
					data: {}
					type: 'POST'
					url: "#{profile_url}/likes"

				if shot.liked
					post_obj.data = _method: 'delete'
					post_obj.url = "#{post_obj.url}/#{shot.id}"
				else
					post_obj.url = "#{post_obj.url}?screenshot_id=#{shot.id}"

				$.ajax(post_obj).complete (x, status) ->
					if status == 'success'
						if shot.liked
							# Unlike it!
							$li.removeClass 'marked'
							$a.text --shot.likes_count
							shot.liked = false
							console.log "Succesfully unliked shot #{shot.id}: “#{shotTitle}”"
						else
							# Like it!
							$li.addClass 'marked'
							$a.text ++shot.likes_count
							shot.liked = true
							console.log "Succesfully liked shot #{shot.id}: “#{shotTitle}”"

					else
						console.log "Fuck."

				false