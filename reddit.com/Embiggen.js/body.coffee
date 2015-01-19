# Source: https://gist.github.com/elliottkember/6121258

x = $(".content")
	.find("a")
	.each ->
		href = $(this).attr "href"
		ext = ''

		if !$(this).hasClass("drowsapMorphed") and $(this).next(".drowsapMorphed").length == 0

			if href and ( href.indexOf('imgur') >= 0 or href.indexOf('jpeg') >= 0 or href.indexOf('jpg') >= 0 or href.indexOf('png') >= 0)

				if href.indexOf('imgur') >= 0 and href.indexOf('jpg') < 0 and href.indexOf('png') < 0
					ext = '.jpg'

				console.log "#{href}#{ext}"

				img = $("<a class='drowsapMorphed' href='#{href}' target='blank' style='border: 10px solid #333; display:block'><img style='display:block;max-width:780px;' src='#{href}#{ext}' /></a>")

				# $(this).after img