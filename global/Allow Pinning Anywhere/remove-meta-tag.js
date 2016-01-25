'use strict';

let images;

try {
  document.querySelector('meta[name=pinterest]').name = 'please-pin-anything';
  console.log('Removed nopin meta tag. Go forth and pin!');
} catch (_error) {
  console.log('nopin meta tag was not found.');
}

try {
  images = document.querySelectorAll('img[nopin]');
  if (!images.length) {
    throw 'No unpinnable images found.';
  }
  images.forEach(function(img) {
    console.log(`- #{img.src} is now pinnable.`);
    img.removeAttribute('nopin');
  });
} catch (err) {
  console.log(err);
}
