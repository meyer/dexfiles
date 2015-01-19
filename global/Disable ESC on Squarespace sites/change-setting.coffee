if typeof Static?.SQUARESPACE_CONTEXT?.websiteSettings == "object"
	console.log "Squarespace detected, useEscapeKeyToLogin =",
		Static.SQUARESPACE_CONTEXT.websiteSettings.useEscapeKeyToLogin

	Static.SQUARESPACE_CONTEXT.websiteSettings.useEscapeKeyToLogin = false
	console.log "useEscapeKeyToLogin set to false"
else
	console.log "No Squarespace in here..."