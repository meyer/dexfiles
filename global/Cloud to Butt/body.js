// Generated by CoffeeScript 1.8.0
(function() {
  var badWords, e, handleText, walk;

  try {
    badWords = {
      "My Butt": /\bThe Cloud\b/g,
      "My butt": /\bThe cloud\b/g,
      "my Butt": /\bthe Cloud\b/g,
      "my butt": /\bthe cloud\b/g,
      "butt": /\bcloud\b/g,
      "Butt": /\bCloud\b/g
    };
    walk = function(node) {
      var child, next, _results;
      switch (node.nodeType) {
        case 1:
        case 9:
        case 11:
          child = node.firstChild;
          _results = [];
          while (child) {
            next = child.nextSibling;
            walk(child);
            _results.push(child = next);
          }
          return _results;
          break;
        case 3:
          handleText(node);
          break;
      }
    };
    handleText = function(textNode) {
      var regex, replacement, v;
      v = textNode.nodeValue;
      for (replacement in badWords) {
        regex = badWords[replacement];
        v = v.replace(regex, replacement);
      }
      return textNode.nodeValue = v;
    };
    walk(document.body);
  } catch (_error) {
    e = _error;
    console.error(e.message);
  }

}).call(this);
