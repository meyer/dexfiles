seeYa = setInterval ->
	document.body.innerHTML = "";
	document.title = "NOPE"
	return
, 500

setTimeout ->
	clearInterval(seeYa)
, 10000