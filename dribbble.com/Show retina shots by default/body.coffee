document.addEventListener "DOMContentLoaded", (e) ->
	setTimeout (->
		if twotimes = document.querySelector(".twotimes")
			console.log "Clicking a.twotimes"
			twotimes.dispatchEvent(
				new MouseEvent 'click', {
					view: window,
					bubbles: true,
					cancelable: true
				}
			)
		else
			console.log "Not on an individual shot page"
	), 100

	return