// Generated by CoffeeScript 1.6.3
(function() {
  var metaTags, pinterestMetaTagFound, tag, _i, _len;

  metaTags = document.getElementsByTagName('meta');

  pinterestMetaTagFound = false;

  for (_i = 0, _len = metaTags.length; _i < _len; _i++) {
    tag = metaTags[_i];
    if (tag.name === 'pinterest') {
      tag.name = 'fuck-pinterest';
      pinterestMetaTagFound = true;
    }
  }

  console.log("Pinterest meta tag located? " + pinterestMetaTagFound);

}).call(this);