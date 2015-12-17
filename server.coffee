http = require "http"
crypto = require 'crypto'

minimumSize = process.argv[3]
minimumSize ?= 256
minimumSize = (+minimumSize) * 1024

maximumSize = process.argv[4]
maximumSize ?= 1024
maximumSize = (+maximumSize) * 1024

console.log "Generating bytes between #{minimumSize} and #{maximumSize}"

generateRandomStringsTwoWays = ->
	size = minimumSize + Math.random() * (maximumSize - minimumSize)
	size = Math.floor size
	console.log "Byte size: #{size/1024} KB"
	randomBytes = crypto.randomBytes size

	result = {
		base64: randomBytes.toString 'base64'
		hex: randomBytes.toString 'hex'
	}

server = http.createServer ( request, response ) ->
	response.writeHead 200, { 'Content-Type': 'application/json' }
	response.write JSON.stringify generateRandomStringsTwoWays()
	response.end()

port = process.argv[2]
port ?= 9999

console.log "Serving on port #{port}"

server.listen port
