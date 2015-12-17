http = require "http"

host = process.argv[2]
host ?= "localhost"

port = process.argv[3]
port ?= 9999

retryCount = process.argv[4]
retryCount = 10

for i in [1..retryCount]
	do ->
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
