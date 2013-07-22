$(function(){
	$('#shots ol.group div[data-picture]').removeAttr('data-picture').each(function() {
		var $div = $(this);
		var retinaURL = $('div[data-media]', $div).data('src').replace('_still.gif', '.gif');

		// This seems excessive.
		$div.after('<img src="' + retinaURL + '">').remove();
	});
});