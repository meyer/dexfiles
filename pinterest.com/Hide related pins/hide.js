'use strict';
let itemsBlocked = 0;
const naughtyURLs = [
  '/resource/ContextLogResource/create/',
  '/resource/UserHomefeedResource/get/',
  '/resource/UpdatesResource/get/',
];

window.$(document).ready(function() {
  window.$(document).ajaxSuccess(function(e, x, s) {
    const url = s.url.split('?')[0];
    if (~naughtyURLs.indexOf(url)) {
      let $newItems = window.$('.recommendationReason').closest('.item:not(.related-pin)');
      itemsBlocked += $newItems.length;
      console.log(`${$newItems.length} items blocked (total: ${itemsBlocked})`);
      $newItems.addClass('related-pin');
    } else {
      console.log(`URL '${url}' is not any of our concern.`);
    }
  });
});
