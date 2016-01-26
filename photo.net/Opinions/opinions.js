'use strict';

function embiggenImages() {
  console.log('DOMContentLoaded');
  let imgs = document.querySelectorAll('img[src*="/member-status-icons/"]:not([src*="/member-status-icons/large/"])');
  [].forEach.call(imgs, function(img) {
    console.info(img);
    img.src = img.src.replace('/member-status-icons/', '/member-status-icons/large/');
  });
}

document.addEventListener('DOMContentLoaded', embiggenImages);