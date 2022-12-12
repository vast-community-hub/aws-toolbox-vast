Extension {
	#name : 'SstHttpClient'
}

{ #category : 'HTTP Methods' }
SstHttpClient >> head: aUrlObject withHeaders: headers [
	"Perform the HTTP HEAD Request
	 The HTTP HEAD method requests the headers that are returned if the specified resource would be
	 requested with an HTTP GET method. Such a request can be done before deciding to download a
	 large resource to save bandwidth, for example.

	 A response to a HEAD method should not have a body. If so, it must be ignored.
	 Even so, entity headers describing the content of the body, like Content-Length may be included in the response.
	 They don't relate to the body of the HEAD response, which should be empty, but to the body of similar request
	 using the GET method would have returned as a response.
	 
	 For more details see comment in method
	 #createRequestFor:typed:using:withHeaders:templateMessage:data:onSuccessDo:"

^self
		createAndSendRequestFor: aUrlObject
		typed: nil
		using: nil
		withHeaders: headers
		templateMessage: self templateHttpHEADMessage copy
		data: nil
		assemblerPolicy: (self newAssemblerPolicy ignoreContent: true)

]
