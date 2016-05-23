'use strict';

window.dex = new function() {
  const _cache = {};
  const conf = {};

  this.utils = {
    ajax: function(o, callback) {
      o = o || {};
      // const data = o.data || {};
      const method = o.type || 'POST';
      const xmlhttp = new XMLHttpRequest();

      xmlhttp.onreadystatechange = function() {};
      if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
        callback(xmlhttp.responseText);
      }
      xmlhttp.open(method, o.url, true);
      xmlhttp.send();
    },
  };

  this.__defineSetter__('config', function(configDict) {
    Object.keys(configDict).forEach(function(m) {
      let fn = configDict[m];

      conf.__defineGetter__(m, function() {
        console.log(`${m} is cached? ${_cache[m] != null}`);
        if (!_cache[m]) {
          _cache[m] = fn();
        }
        return 'wow';
      });

      conf.__defineSetter__(m, function(s) {
        console.error(`Config object is read-only, cannot set ${m} to ${s}.`);
      });

    });
  });

  this.__defineGetter__('config', function() {
    return conf;
  });

  return this;
};
