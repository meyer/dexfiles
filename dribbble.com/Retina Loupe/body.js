// Generated by CoffeeScript 1.8.0
(function() {
  (function(d) {
    var dribbleShot, e, img, loupe, loupeStyle, loupeVisible, rect, retinaShotURL, shotContainer, shotImage, updateLoupeLocation;
    try {
      if (!(dribbleShot = document.querySelector(".the-shot"))) {
        throw "No shot!";
      }
      shotContainer = dribbleShot.querySelector(".single");
      shotImage = dribbleShot.querySelector(".single-img img");
      retinaShotURL = document.querySelector(".twotimes").href;
      if (!retinaShotURL) {
        throw "No retina shot URL!";
      }
      shotContainer.classList.add("retina-shot");
      shotContainer.classList.add("loupe-hidden");
      loupeVisible = false;
      loupe = document.createElement('div');
      loupe.id = "retina-loupe";
      loupe.innerHTML = "<div style='background-image:url(" + retinaShotURL + ");'></div>";
      loupeStyle = document.createElement('style');
      rect = shotContainer.getBoundingClientRect();
      updateLoupeLocation = function(e) {
        var loupeBkgCSS, loupeCSS, mouseX, mouseY;
        loupeCSS = [];
        loupeBkgCSS = [];
        mouseX = document.body.scrollLeft + e.x - rect.left;
        mouseY = document.body.scrollTop + e.y - rect.top;
        if (mouseX >= 0 && mouseX <= rect.width && mouseY >= 0 && mouseY <= rect.height) {
          if (!loupeVisible) {
            shotContainer.classList.remove("loupe-hidden");
          }
          loupeVisible = true;
          loupeCSS.push("left: " + mouseX + "px");
          loupeCSS.push("top: " + mouseY + "px");
          loupeBkgCSS.push("background-position-x: " + (100 - mouseX * 2 + 40) + "px");
          loupeBkgCSS.push("background-position-y: " + (100 - mouseY * 2 + 40) + "px");
          return loupeStyle.innerHTML = "#retina-loupe{" + (loupeCSS.join(';')) + "}\n#retina-loupe div{" + (loupeBkgCSS.join(';')) + "}";
        } else {
          if (loupeVisible) {
            shotContainer.classList.add("loupe-hidden");
          }
          return loupeVisible = false;
        }
      };
      img = new Image();
      img.src = retinaShotURL;
      img.onload = function() {
        var lastMove, updatesPerSecond;
        document.body.appendChild(loupeStyle);
        shotContainer.appendChild(loupe);
        lastMove = 0;
        updatesPerSecond = 60;
        return document.addEventListener("mousemove", function(e) {
          if (Date.now() - lastMove > 1000 / updatesPerSecond) {
            lastMove = Date.now();
            console.log('!!!');
            return updateLoupeLocation(e);
          }
        });
      };
    } catch (_error) {
      e = _error;
      console.log(e);
    }
  })(dex.config);

}).call(this);