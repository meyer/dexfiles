'use strict';

function destroyPage() {
  document.body.innerHTML = '';
  document.title = 'NOPE';
}

destroyPage();

let seeYa = setInterval(destroyPage, 500);
setTimeout(function(){ clearInterval(seeYa); }, 10000);
