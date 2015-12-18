http = require "http"
fs = require 'fs'

rootDir = process.argv[3]
rootDir ?= "/var/www/webapp/assets/"
filesToServe = []

scanDirectory = (dir) ->
	console.log "Scanning #{dir}"
	files = fs.readdirSync dir
	for file in files
		file = "#{dir}/#{file}"
		stat = fs.lstatSync file
		if stat.isFile()
			filesToServe.push file
		else if stat.isDirectory()
			scanDirectory(file)
		console.log filesToServe

scanDirectory rootDir

server = http.createServer ( request, response ) ->
	console.log "Connected"
	file = filesToServe[Math.floor Math.random() * filesToServe.length]
	console.log "Serving #{file}"
	stream = fs.createReadStream file
	stream.pipe response
	request.on "end", -> console.log "Disconnected"

port = process.argv[2]
port ?= 9998

console.log "Serving on port #{port}"

server.listen port
