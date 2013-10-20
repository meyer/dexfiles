dex.config =
	'loggedIn': ->
		document.body.classList.contains 'logged-in'

	'profileURL': ->
		$('#t-profile>a').attr 'href'

	'shots': ->
		shotsByID = {}
		unless typeof SHOTS is 'undefined'
			shotsByID[shot.id] = shot for shot in SHOTS
		else
			shotsByID = false
		shotsByID