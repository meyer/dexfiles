do(d = dex.config) ->

	$shot = $(".the-shot")

	if $shot.length
		$shotContainer = $(".single", $shot)
		$shotImage = $(".single-img img", $shot).first().addClass("original")
		retinaShotURL = $(".twotimes").attr("href")
		if retinaShotURL is `undefined`
			console.log "No retina shot URL."
			return false
		console.log "Retina shot URL: " + retinaShotURL

		# We have a retina shot!
		$shotContainer.addClass "retina-shot"

		img = new Image()
		img.src = retinaShotURL
		img.onload = ->

			bkgOffsetX = (if img.width / 2 < 400 then Math.ceil((400 - img.width / 2) / 2) else 0)
			bkgOffsetY = (if img.height / 2 < 300 then Math.ceil((300 - img.height / 2) / 2) else 0)
			loupeVisible = false
			$retinaLoupe = $("<div id='retina-loupe'><div style='background-image:url(#{retinaShotURL});'></div></div>").appendTo $shotContainer

			updateLoupeLocation = (e) ->
				os = $shotContainer.offset()
				mouseX = e.pageX - os.left
				mouseY = e.pageY - os.top
				if mouseX >= 0 and mouseX <= 440 and mouseY >= 0 and mouseY <= 340
					$shotContainer.removeClass "loupe-hidden" unless loupeVisible
					loupeVisible = true

					# We're in bidness
					$retinaLoupe.css(
						left: mouseX
						top: mouseY
					).children("div").css backgroundPosition: (75 - mouseX * 2 + 40 + bkgOffsetX) + "px " + (75 - mouseY * 2 + 40 + bkgOffsetY) + "px"
				else
					$shotContainer.addClass "loupe-hidden"	if loupeVisible
					loupeVisible = false

			$shotContainer.addClass("loupe-hidden").hover (->
				$(document).bind "mousemove.retinaloupe", updateLoupeLocation
			), ->
				# $(document).unbind "mousemove.retinaloupe"


			# Break the loop
			false