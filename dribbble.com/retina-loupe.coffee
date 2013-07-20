$shot = $('.the-shot')

if $shot.length

	$shotContainer = $('.single', $shot).addClass 'retina-unavailable'
	$shotImage = $(".single-img img", $shot).first().addClass 'original'

	retinaShotURL = $('.twotimes').attr 'href'

	console.log 'Retina shot URL: '+retinaShotURL

	return false if retinaShotURL == undefined

	# We have a retina shot!
	$shotContainer.removeClass 'retina-unavailable'

	img = new Image()
	img.src = retinaShotURL
	img.onload = ->

		# Center the background image.
		# Not sure how important this is anymore?
		bkgOffsetX = (if img.width / 2 < 400 then Math.ceil((400 - img.width / 2) / 2) else 0)
		bkgOffsetY = (if img.height / 2 < 300 then Math.ceil((300 - img.height / 2) / 2) else 0)

		loupeVisible = false

		$retinaLoupe = $("<div id='retina-loupe'>"+
			"<div style='background-image:url(#{retinaShotURL});'></div>"+
			"</div>"
			).appendTo($shotContainer)

		# Hide loupe if page is inactive
		handleVisibilityChange = ->
			if document.webkitHidden
				console.log 'hide loupe!!'
				$shotContainer.addClass 'loupe-hidden'
			else
				console.log 'show loupe maybe!!'

		document.addEventListener "webkitvisibilitychange", handleVisibilityChange, false

		updateLoupeLocation = (e) ->
			os = $shotContainer.offset()
			mouseX = e.pageX - os.left
			mouseY = e.pageY - os.top

			if mouseX >= 0 && mouseX <= 440 && mouseY >= 0 && mouseY <= 340
				if !loupeVisible
					$shotContainer.removeClass 'loupe-hidden'

				loupeVisible = true

				# We're in bidness
				$retinaLoupe.css
					left: mouseX,
					top: mouseY
				.children('div').css
					backgroundPosition: (75-mouseX*2+40+bkgOffsetX)+'px '+(75-mouseY*2+40+bkgOffsetY)+'px'

			else
				if loupeVisible
					$shotContainer.addClass 'loupe-hidden'
				loupeVisible = false

		###
		oddeven = 0
		$('.twotimes').click ->
			if oddeven % 2
				$(document).unbind '.retinaloupe'
				console.log 'LOUPE DISABLED'
			else
				$(document).bind 'mousemove.retinaloupe',updateLoupeLocation
				console.log 'LOUPE ENABLED'
			oddeven++

		###

		$shotContainer.addClass('loupe-hidden').hover (->
				$(document).bind 'mousemove.retinaloupe',updateLoupeLocation
			), ->
				# $(document).unbind('mousemove.retinaloupe')

		false
