http = require "http"

host = process.argv[2]
host ?= "localhost"

port = process.argv[3]
port ?= 9999

delayTimeInMilliseconds = process.argv[4] * 1000
if !process.argv[4]?
	delayTimeInMilliseconds = 10000

retryCount = process.argv[5]
retryCount ?= 10

i = 1
getRequest = ->
	iteration = "iteration #{i}"
	http.get({host, port}, (response)->
		body = ""
		response.on 'data', (data) ->
			body += data
		response.on 'end', ->
			byteStrings = JSON.parse body
			{base64, hex} = byteStrings
			base64Buffer = new Buffer base64, 'base64'
			hexBuffer = new Buffer hex, 'hex'
			if base64Buffer.equals hexBuffer
				console.log "Match on #{iteration}."
			else
				console.error "Mismatch on #{iteration}."
	)
	if i < retryCount
		setTimeout getRequest, delayTimeInMilliseconds
	i++

getRequest()
