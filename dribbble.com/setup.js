// Generated by CoffeeScript 1.6.3
(function() {
  dex.config = {
    'loggedIn': function() {
      return document.body.classList.contains('logged-in');
    },
    'profileURL': function() {
      return $('#t-profile>a').attr('href');
    },
    'shots': function() {
      var shot, shotsByID, _i, _len;
      shotsByID = {};
      if (typeof SHOTS !== 'undefined') {
        for (_i = 0, _len = SHOTS.length; _i < _len; _i++) {
          shot = SHOTS[_i];
          shotsByID[shot.id] = shot;
        }
      } else {
        shotsByID = false;
      }
      return shotsByID;
    }
  };

}).call(this);
