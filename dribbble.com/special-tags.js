// Generated by CoffeeScript 1.6.3
(function() {
  var $newTagContainer, $tags, formatSlug, formatTags, ignored_caps, replacements,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  ignored_caps = ['and', 'of', 'the'];

  replacements = {
    tool: {
      '^cs$': 'CS'
    },
    typeface: {
      '^df$': 'DF',
      '^din$': 'DIN',
      '^ff$': 'FF',
      '^fr$': 'FR',
      '^gt$': 'GT',
      '^hfj$': 'H&FJ',
      '^htf$': 'HTF',
      '^itc$': 'ITC',
      '^let$': 'LET',
      '^lt$': 'LT',
      '^mr$': 'Mr.',
      '^mrs$': 'Mrs.',
      '^ms$': 'MS',
      '^mt$': 'MT',
      '^pt$': 'PT',
      '^se$': 'SE',
      '^tj$': 'TJ',
      '^vag$': 'VAG',
      '^y2k$': 'Y2K'
    }
  };

  $tags = $('#tags');

  if ($tags.length) {
    $newTagContainer = $('<ol class="tags group">').prependTo($tags);
    formatSlug = function(slug, category) {
      var formatted, i, list, regex, substitute, word, _i, _len, _ref;
      list = slug.split('-');
      formatted = [];
      slug = slug.toLowerCase();
      for (i = _i = 0, _len = list.length; _i < _len; i = ++_i) {
        word = list[i];
        if (__indexOf.call(ignored_caps, word) < 0 || (i === 0 && __indexOf.call(ignored_caps, word) >= 0)) {
          word = word.charAt(0).toUpperCase() + word.substr(1);
        }
        if (__indexOf.call(replacements, category) >= 0) {
          _ref = replacements[category];
          for (regex in _ref) {
            substitute = _ref[regex];
            word = word.replace("/" + regex + "/gi", substitute);
          }
        }
        formatted.push(word);
      }
      return formatted.join(' ');
    };
    formatTags = function(category) {
      return $("a[href*='tags/" + category + ":'][rel='tag']", $tags).each(function() {
        var $li, $s, $tag, slug, text;
        $tag = $(this);
        $s = $('strong', $tag);
        slug = $s.text().replace("" + category + ":", '');
        text = formatSlug(slug, category);
        $li = $tag.parent();
        $li.appendTo($newTagContainer);
        $li.addClass("tag-" + category + " special-tag");
        return $s.html("<span class='key'>" + category + "</span><span class='val'>" + text + "</span>");
      });
    };
    formatTags('tool');
    formatTags('typeface');
  }

}).call(this);
