http = require "http"
crypto = require 'crypto'

generateRandomStringsTwoWays = ->
	randomBytes = crypto.randomBytes 1024 * 1024

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
