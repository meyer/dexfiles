'use strict';

function modifyShots(nodeList) {
  // Convert nodeList to an array
  Array.prototype.slice.call(nodeList).forEach(function(node) {
    if (node.tagName !== 'LI') {
      console.log(`Take your ${node.tagName} and git out`);
      return;
    }
    const img = node.querySelector('.dribbble-img img').src;
    const retinaImg = node.querySelector('div[data-media*="ratio: 1.5"]').dataset.src;

    console.log('img:', img);
    console.log('retinaImg:', retinaImg);

    if (img !== retinaImg && /_1x.\w+$/.test(img)) {
      console.log('node (2x):', node);
    } else {
      console.log('node (1x):', node);
      node.style.backgroundColor = 'red';
    }
  });
}

console.log('Wow!');

function firstRun() {
  console.log('DOING IT');
  // Initial modification
  modifyShots(document.querySelectorAll('.dribbbles.group > li'));

  const target = document.querySelector('.dribbbles.group');

  const observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      if (mutation.type === 'childList') {
        console.log('Mutation:', mutation.addedNodes);
        modifyShots(mutation.addedNodes);
      } else {
        console.log(`Ignored mutation: ${mutation.type}:`, mutation);
      }
    });
  });

  observer.observe(target, { attributes: true, childList: true, characterData: true });
}

if (document.readyState == 'complete' || document.readyState == 'loaded') {
  console.log('ALREADY DID IT');
  firstRun();
} else {
  document.addEventListener('DOMContentLoaded', firstRun, false);
}
