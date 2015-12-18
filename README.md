## Simple Node http client server test utility

To run:
coffee server.coffee <port> <minimumKBSize> <maximumKBSize>
coffee client.coffee <hostname> <port> <delayInSeconds> <iterations>
coffee file-server.coffee <port> <directoryToServe>

All parameters are optional.

The server responds to all http requests with a JSON string containing the same random 1MB byte array encoded as base64 and as hex.

The client decodes the JSON, and then decodes the byte arrays and compares them.

The file-server.coffee scans for all files within a directory and then randomly serves one to each GET request, as a stream. It is important that it runs as a stream, which allows the server to manage multiple connections simultaneously.

If you have network corruption issues, most likely the JSON parse will fail, but if that somehow passes, then the byte arrays will likely not match.

