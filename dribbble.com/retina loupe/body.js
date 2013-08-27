// Generated by CoffeeScript 1.6.3
(function() {
  (function(d, $) {
    var $shot, $shotContainer, $shotImage, img, retinaShotURL;
    $shot = $(".the-shot");
    if ($shot.length) {
      $shotContainer = $(".single", $shot);
      $shotImage = $(".single-img img", $shot).first().addClass("original");
      retinaShotURL = $(".twotimes").attr("href");
      if (retinaShotURL === undefined) {
        console.log("No retina shot URL.");
        return false;
      }
      console.log("Retina shot URL: " + retinaShotURL);
      $shotContainer.addClass("retina-shot");
      img = new Image();
      img.src = retinaShotURL;
      return img.onload = function() {
        var $retinaLoupe, bkgOffsetX, bkgOffsetY, loupeVisible, updateLoupeLocation;
        bkgOffsetX = (img.width / 2 < 400 ? Math.ceil((400 - img.width / 2) / 2) : 0);
        bkgOffsetY = (img.height / 2 < 300 ? Math.ceil((300 - img.height / 2) / 2) : 0);
        loupeVisible = false;
        $retinaLoupe = $("<div id='retina-loupe'><div style='background-image:url(" + retinaShotURL + ");'></div></div>").appendTo($shotContainer);
        updateLoupeLocation = function(e) {
          var mouseX, mouseY, os;
          os = $shotContainer.offset();
          mouseX = e.pageX - os.left;
          mouseY = e.pageY - os.top;
          if (mouseX >= 0 && mouseX <= 440 && mouseY >= 0 && mouseY <= 340) {
            if (!loupeVisible) {
              $shotContainer.removeClass("loupe-hidden");
            }
            loupeVisible = true;
            return $retinaLoupe.css({
              left: mouseX,
              top: mouseY
            }).children("div").css({
              backgroundPosition: (75 - mouseX * 2 + 40 + bkgOffsetX) + "px " + (75 - mouseY * 2 + 40 + bkgOffsetY) + "px"
            });
          } else {
            if (loupeVisible) {
              $shotContainer.addClass("loupe-hidden");
            }
            return loupeVisible = false;
          }
        };
        $shotContainer.addClass("loupe-hidden").hover((function() {
          return $(document).bind("mousemove.retinaloupe", updateLoupeLocation);
        }), function() {});
        return false;
      };
    }
  })(dex.config, dex.utils.jquery);

}).call(this);
