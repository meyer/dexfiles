document.addEventListener "DOMContentLoaded", (e) ->
	ignored_caps = ['and','of','the']

	replacements =
		tool:
			'^cs$':  'CS'
			'^cc$':  'CC'

		# Foundries
		typeface:
			'^df$':  'DF'
			'^din$': 'DIN'
			'^ff$':  'FF'
			'^fr$':  'FR'
			'^gt$':  'GT'
			'^hfj$': 'H&FJ'
			'^htf$': 'HTF'
			'^itc$': 'ITC'
			'^let$': 'LET'
			'^lt$':  'LT'
			'^mr$':  'Mr.'
			'^mrs$': 'Mrs.'
			'^ms$':  'MS'
			'^mt$':  'MT'
			'^pt$':  'PT'
			'^se$':  'SE'
			'^tj$':  'TJ'
			'^vag$': 'VAG' # LOL
			'^y2k$': 'Y2K'

	$tags = $('#tags')

	if $tags.length

		$newTagContainer = $('<ol class="tags group">')

		formatSlug = (slug, category) ->
			list = slug.split('-')
			formatted = []

			slug = slug.toLowerCase()

			for word, i in list
				if word not in ignored_caps or i is 0
					word = word.charAt(0).toUpperCase()+word.substr(1)

				if category in replacements
					for regex, substitute of replacements[category]
						# TODO: Break on match
						word = word.replace("/#{regex}/gi", substitute)

				formatted.push word

			return formatted.join(' ')

		formatTags = (category_array) ->
			tagCount = 0

			for category in category_array
				$tags_to_format = $("a[href*='tags/#{category}:'][rel='tag']", $tags)
				$tags_to_format.each ->
					$tag = $(@)
					$s = $('strong', $tag);

					slug = $s.text()
					slug = slug.replace "#{category}:",''
					text = formatSlug(slug, category)

					$li = $tag.parent()
					$li.appendTo $newTagContainer

					$li.addClass "tag-#{category} special-tag"

					$s.html "<span class='key'>#{category}</span><span class='val'>#{text}</span>"

				tagCount += $tags_to_format.length

			return tagCount > 0

		if formatTags ['tool','typeface']
			$newTagContainer.prependTo($tags)