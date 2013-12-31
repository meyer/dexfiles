// Generated by CoffeeScript 1.6.3
(function() {
  (function(d) {
    var changeFavStatus, clickTime, dblclkTimeout, e, id, likeIndicatorTime, likePending, shotMeta, showLikeIndicator, _ref, _results;
    likePending = false;
    likeIndicatorTime = 1200;
    changeFavStatus = function(shotID, like_or_unlike) {
      var likeLink, post_obj, shot, shotLink, shotMeta;
      if (likePending) {
        throw "ALREADY LIKING SHOT " + likePending;
      }
      likePending = shotID;
      shotMeta = d.shots[shotID];
      shot = document.getElementById("screenshot-" + shotID);
      shotLink = shot.querySelector('.dribbble-over');
      likeLink = shot.querySelector('li.fav a');
      post_obj = {
        data: {},
        type: 'POST',
        url: "" + d.profileURL + "/likes"
      };
      switch (like_or_unlike) {
        case 'like':
          if (shotMeta.liked) {
            showLikeIndicator(shotMeta.id, {
              action: 'like'
            });
            likePending = false;
            throw "Shot " + shotMeta.id + " already liked! Dummy!";
          }
          post_obj.url = "" + post_obj.url + "?screenshot_id=" + shotMeta.id;
          break;
        case 'unlike':
          if (!shotMeta.liked) {
            likePending = false;
            throw "Shot " + shotMeta.id + " already unliked! Stupid!";
          }
          post_obj.data = {
            _method: 'delete'
          };
          post_obj.url = "" + post_obj.url + "/" + shotMeta.id;
          break;
        case 'toggle':
          like_or_unlike = shotMeta.liked ? 'unlike' : 'like';
          break;
        default:
          throw "invalid option: " + like_or_unlike;
      }
      console.log("Here’s the plan: we’re gonna " + like_or_unlike + " shot number " + shotMeta.id);
      return jQuery.ajax(post_obj.url, post_obj.data, function(x, status) {
        likePending = false;
        if (status !== 'success') {
          throw "AJAX error";
        }
        switch (like_or_unlike) {
          case 'unlike':
            likeLink.parentNode.classList.remove('marked');
            likeLink.innerHTML = --shotMeta.likes_count;
            shotMeta.liked = false;
            showLikeIndicator(shotMeta.id, {
              action: 'unlike'
            });
            console.log('UN LIEK');
            break;
          case 'like':
            likeLink.parentNode.classList.add('marked');
            likeLink.innerHTML = ++shotMeta.likes_count;
            shotMeta.liked = true;
            showLikeIndicator(shotMeta.id, {
              action: 'like'
            });
            console.log('LIEK');
        }
      });
    };
    showLikeIndicator = function(shotID, options) {
      var eff, likeIndicator, shot, unnn;
      if (likePending) {
        if ((likePending | 0) !== (shotID | 0)) {
          throw "likePending != shotID";
        }
      }
      unnn = "";
      if ('action' in options) {
        switch (options.action) {
          case 'like':
            break;
          case 'unlike':
            unnn = 'un ';
            break;
          default:
            throw "invalid action: " + options.action;
        }
      }
      shot = document.getElementById("screenshot-" + shotID);
      likeIndicator = document.createElement('div');
      likeIndicator.classList.add('#{unnn}like-indicator');
      likeIndicator.appendChild(document.createElement('div'));
      eff = shot.querySelector('.dribbble-shot');
      eff.appendChild(likeIndicator);
      return setTimeout(function() {
        eff.removeChild(likeIndicator);
        return likePending = false;
      }, likeIndicatorTime);
    };
    try {
      if (!d.loggedIn) {
        throw "not logged in";
      }
      if (!d.shots) {
        throw "no shots";
      }
      clickTime = 300;
      dblclkTimeout = false;
      _ref = d.shots;
      _results = [];
      for (id in _ref) {
        shotMeta = _ref[id];
        _results.push((function(id, shotMeta) {
          var clickCount, shot;
          shot = document.getElementById("screenshot-" + shotMeta.id);
          shot.querySelector("li.fav a").addEventListener('click', function(e) {
            changeFavStatus(shotMeta.id, 'toggle');
            return e.preventDefault();
          }, false);
          clickCount = 0;
          return shot.querySelector('.dribbble-over').addEventListener('click', function(e) {
            var _this = this;
            if (e.metaKey) {
              console.log("command click’d");
              return;
            }
            e.preventDefault();
            clickCount++;
            clearTimeout(dblclkTimeout);
            if (clickCount >= 2) {
              if (clickCount === 2) {
                changeFavStatus(shotMeta.id, 'like');
              } else {
                console.log(clickCount + ' clicks and counting!');
              }
              return dblclkTimeout = setTimeout(function() {
                return clickCount = 0;
              }, clickTime);
            } else {
              return dblclkTimeout = setTimeout(function() {
                if (clickCount !== 2) {
                  console.log('Double-click didn’t happen. *single tear rolls down face*');
                  console.log(e.target.href);
                  document.location.href = e.target.href;
                }
                return clickCount = 0;
              }, clickTime);
            }
          });
        })(id, shotMeta));
      }
      return _results;
    } catch (_error) {
      e = _error;
      return console.log("like from grid error: " + e);
    }
  })(dex.config);

}).call(this);
