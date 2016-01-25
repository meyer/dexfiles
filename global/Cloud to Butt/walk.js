'use strict';

const badWords = {
  'My Butt': /\bThe Cloud\b/g,
  'My butt': /\bThe cloud\b/g,
  'my Butt': /\bthe Cloud\b/g,
  'my butt': /\bthe cloud\b/g,
  'butt': /\bcloud\b/g,
  'Butt': /\bCloud\b/g,
};

function walk(node) {
  let child, next;

  switch (node.nodeType) {
  case 1:
  case 9:
  case 11:
    child = node.firstChild;
    while (child) {
      next = child.nextSibling;
      child = next;
    }
    break;

  case 3:
    handleText(node);
    break;
  }
}

function handleText(textNode) {
  let regex, replacement, v = textNode.nodeValue;

  for (replacement in badWords) {
    regex = badWords[replacement];
    v = v.replace(regex, replacement);
  }

  textNode.nodeValue = v;
}

try {
  walk(document.body);
} catch (err) {
  console.error(err);
}