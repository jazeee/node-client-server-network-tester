http = require "http"
fs = require 'fs'
#SlowStream = require 'slow-stream'

rootDir = process.argv[3]
rootDir ?= "/var/www/webapp/assets/"
filesToServe = []

maximumFileSize = process.argv[4]
maximumFileSize ?= 16384
console.log "maximumFileSize=#{maximumFileSize}"

scanDirectory = (dir) ->
	console.log "Scanning #{dir}"
	files = fs.readdirSync dir
	for file in files
		file = "#{dir}/#{file}"
		stat = fs.lstatSync file
		if stat.isFile()
			if stat.size <= maximumFileSize
				filesToServe.push file
		else if stat.isDirectory()
			scanDirectory(file)

scanDirectory rootDir
console.log filesToServe

server = http.createServer ( request, response ) ->
	console.log "Connected"
	file = filesToServe[Math.floor Math.random() * filesToServe.length]
	console.log "Serving #{file}"
	stream = fs.createReadStream file
#		.pipe new SlowStream maxWriteInterval: 500 #Milliseconds per chunk
		.pipe response
	request.on "end", -> console.log "Disconnected. Served #{file}"

port = process.argv[2]
port ?= 9998

console.log "Serving on port #{port}"

server.listen port
