if typeof SHOTS != 'undefined'
	for shot in SHOTS
		do (shot) ->
			$shot = $("#screenshot-#{shot.id}")
			$div = $('div[data-picture]',$shot).removeAttr('data-picture')
			retinaURL = $('div[data-media]', $div).data('src').replace '_still.gif', '.gif'

			if ~retinaURL.indexOf "_1x."
				$shot.addClass 'retina-shot'

			# This seems excessive.
			$div.after("<img src='#{retinaURL}'>").remove()
else
	console.log 'Not on a shot grid page!'