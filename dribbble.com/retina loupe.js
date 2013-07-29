$(function(){
	var $shot = $('.the-shot');

	if( $shot.length ){
		var $shotContainer = $('.single',$shot);
		var $shotImage = $(".single-img img",$shot).first().addClass('original');
		var retinaShotURL = $('.twotimes').attr('href');

		if( retinaShotURL === undefined ) {
			console.log('No retina shot URL.');
			return false;
		}

		console.log('Retina shot URL: '+retinaShotURL);

		// We have a retina shot!
		$shotContainer.addClass('retina-shot');

		var img = new Image();
		img.src = retinaShotURL;

		img.onload = function() {
			var bkgOffsetX = img.width/2 < 400 ? Math.ceil((400-img.width/2)/2) : 0;
			var bkgOffsetY = img.height/2 < 300 ? Math.ceil((300-img.height/2)/2) : 0;

			var loupeVisible = false;
			var $retinaLoupe = $('<div id="retina-loupe"><div style="background-image:url('+retinaShotURL+');"></div></div>').appendTo($shotContainer);

			var updateLoupeLocation = function(e){
				var os = $shotContainer.offset();
				var mouseX = e.pageX-os.left;
				var mouseY = e.pageY-os.top;
				if(
					mouseX >= 0 &&
					mouseX <= 440 &&
					mouseY >= 0 &&
					mouseY <= 340
				){
					if (!loupeVisible){
						$shotContainer.removeClass('loupe-hidden');
					}
					loupeVisible = true;

					// We're in bidness
					$retinaLoupe.css({
						left: mouseX,
						top: mouseY
					}).children('div').css({
						backgroundPosition: (75-mouseX*2+40+bkgOffsetX)+'px '+(75-mouseY*2+40+bkgOffsetY)+'px'
					});
				} else {
					if (loupeVisible){
						$shotContainer.addClass('loupe-hidden');
					}
					loupeVisible = false;
				}
			};

			$shotContainer.addClass('loupe-hidden').hover(
				function(){
					$(document).bind('mousemove.retinaloupe',updateLoupeLocation)
				},
				function(){
					// $(document).unbind('mousemove.retinaloupe');
				}
			);

			// Break the loop
			return false;
		}
	}
});