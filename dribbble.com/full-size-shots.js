// TODO: Make this sexier.

$(document).ready(function(){
	// Auto-load 2x shot
	$('ol.group div[data-picture]').removeAttr('data-picture').each(function(){
		$div = $(this);
		retinaURL = $('div[data-media]', $div).data('src');
		// Animate? Suuuure.
		retinaURL = retinaURL.replace('_still.gif', '.gif');
		$('<img src="'+retinaURL+'">').appendTo($div)
	});
});