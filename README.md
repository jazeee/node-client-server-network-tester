## Simple Node http client server test utility

To run:
coffee server <port>
coffee client <hostname> <port> <delayInSeconds> <iterations>


All parameters are optional.

The server responds to all http requests with a JSON string containing the same random 1MB byte array encoded as base64 and as hex.

The client decodes the JSON, and then decodes the byte arrays and compares them.

If you have network corruption issues, most likely the JSON parse will fail, but if that somehow passes, then the byte arrays will likely not match.

