$(function(){
	$('#shots ol.group div[data-picture]').removeAttr('data-picture').each(function() {
		var $div = $(this);
		var retinaURL = $('div[data-media]', $div).data('src').replace('_still.gif', '.gif');

		if ( ~retinaURL.indexOf("_1x.") ) {
			$div.closest('li').addClass('retina-shot');
		}

		// This seems excessive.
		$div.after('<img src="' + retinaURL + '">').remove();
	});
});