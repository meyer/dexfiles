metaTags = document.getElementsByTagName 'meta'

pinterestMetaTagFound = false

for tag in metaTags
	if tag.name == 'pinterest'
		tag.name = 'fuck-pinterest'
		pinterestMetaTagFound = true

console.log "Pinterest meta tag located? #{pinterestMetaTagFound}"