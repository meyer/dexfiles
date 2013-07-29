window.dexfiles = {}
window.DexConfig = (getters) ->
	_cache = {}
	# Object to return
	conf = {}
	for m, fn of getters
		do (m, fn) =>
			conf.__defineGetter__ m, ->
				# console.log 'Cached? '+_cache[m]?
				_cache[m] || _cache[m] = fn()
	conf