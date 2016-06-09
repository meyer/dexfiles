// http://stackoverflow.com/a/5278132/112733
document.addEventListener('DOMContentLoaded', function() {
  for (let i = 0; i < document.styleSheets.length; i++) {
    if (/lato/i.test(document.styleSheets[i].href)) {
      document.styleSheets.item(i).disabled = true
      break
    }
  }
})
