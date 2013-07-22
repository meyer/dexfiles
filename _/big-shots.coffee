# Nuke picturefill on the grid page
# TODO: Make this sexier.

$('#shots ol.group div[data-picture]').removeAttr('data-picture').each ->
	$div = $(@)
	retinaURL = $('div[data-media]', $div).data 'src'
	# Animate? Suuuure.
	retinaURL = retinaURL.replace '_still.gif', '.gif'
	$('<img src="'+retinaURL+'">').appendTo $div