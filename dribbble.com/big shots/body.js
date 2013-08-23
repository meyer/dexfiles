// Generated by CoffeeScript 1.6.3
(function() {
  (function(d) {
    var id, s, _ref, _results;
    if (d.shots) {
      _ref = d.shots;
      _results = [];
      for (id in _ref) {
        s = _ref[id];
        _results.push((function(id) {
          var div, img, p, retinaURL, shot;
          shot = document.getElementById("screenshot-" + id);
          div = shot.querySelectorAll('div[data-picture]')[0];
          shot.classList.add('image-loading');
          retinaURL = shot.querySelectorAll('div[data-media]')[0].getAttribute('data-src');
          if (~retinaURL.indexOf("_1x.")) {
            shot.classList.add('retina-shot');
          }
          p = div.parentNode;
          img = new Image();
          img.src = retinaURL;
          img.className = 'full-image';
          return img.addEventListener('load', (function() {
            return p.appendChild(img);
          }), false);
        })(id));
      }
      return _results;
    }
  })(window.dexfiles.dribbble);

}).call(this);
