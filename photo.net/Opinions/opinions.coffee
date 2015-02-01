document.addEventListener "DOMContentLoaded", (e) ->
	console.log "DOMContentLoaded"

	imgs = document.querySelectorAll("img[src*='/member-status-icons/']:not([src*='/member-status-icons/large/'])")

	[].forEach.call imgs, (img) ->
		console.info img
		img.src = img.src.replace("/member-status-icons/", "/member-status-icons/large/")