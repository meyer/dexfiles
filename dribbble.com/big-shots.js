// Hello “UTF-8™ test”

$('#shots ol.group div[data-picture]').removeAttr('data-picture').each(function() {
	var $div, retinaURL;
	$div = $(this);
	retinaURL = $('div[data-media]', $div).data('src');
	retinaURL = retinaURL.replace('_still.gif', '.gif');

	return $('<img src="' + retinaURL + '">').appendTo($div);
});