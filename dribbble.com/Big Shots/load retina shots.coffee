document.addEventListener "DOMContentLoaded", (e) ->
	do(d = dex.config) ->
		if d.shots
			# document.body.classList.add("has-shots")

			for id, s of d.shots
				do (id) ->
					shot = document.getElementById "screenshot-#{id}"
					div = shot.querySelectorAll('div[data-picture]')[0]

					shot.classList.add 'image-loading'

					retinaURL = shot.querySelectorAll('div[data-media]')[0].getAttribute 'data-src'

					# Animated shots
					retinaURL = retinaURL.replace('_still.gif', '.gif')
					retinaURL = retinaURL.replace('_animated_1x.gif', '_animated.gif')
					retinaURL = retinaURL.replace('_1x.gif', '.gif')

					# TODO: Load retina shot if window.devicePixelRatio > 1.5
					if ~retinaURL.indexOf "_1x."
						shot.classList.add 'retina-shot'

					p = div.parentNode
					img = new Image()
					img.src = retinaURL
					img.className = 'full-image'
					img.addEventListener 'load', (-> p.appendChild img), false
		else
			console.log 'No shots to process :('