Class {
	#name : 'ZnClient',
	#superclass : 'Object',
	#instVars : [
		'request',
		'response',
		'options',
		'nativeClient'
	],
	#pools : [
		'SstHttpConstants'
	],
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'Resources' }
ZnClient class >> httpClientClass [

	^SstHttpClient
]

{ #category : 'private protocol' }
ZnClient >> cleanupConnection [

	self close
]

{ #category : 'private protocol' }
ZnClient >> close [
		
	self nativeClient isNil ifTrue: [^self].
	
	self nativeClient shutDown
]

{ #category : 'accessing - options' }
ZnClient >> contentReader [
	"Return the current content reader, an object conforming 
	to the #value: protocol to convert a response entity
	as used by #contents. Defaults to nil.
	Can be used to parse incoming data."

	^self optionAt: #contentReader ifAbsent: [nil]
]

{ #category : 'accessing' }
ZnClient >> contents [
	"Answer the contents or HTTP payload of the last response, 
	assuming the current request was executed.
	If I have a contentReader, it will be used to compute the contents.
	Otherwise I delegate to ZnResponse>>#contents, unless I am #streaming,
	in which case I return the stream of the streaming entity."

	^response ifNotNil: [
		self contentReader
			ifNil: [self streaming ifTrue: [response entity stream] ifFalse: [response contents]]
			ifNotNil: [:reader | reader value: response entity]]
]

{ #category : 'accessing - options' }
ZnClient >> enforceAcceptContentType [
	"Return whether or not I enforce that the content type of the
	response matches the content type specified in the accept request header."

	^self optionAt: #enforceAcceptContentType ifAbsent: [false]
]

{ #category : 'accessing - options',
 #vaCategories : ['accessing - options','not implemented (yet)','utilities'] }
ZnClient >> enforceAcceptContentType: aBoolean [
	"Not implemented yet"


]

{ #category : 'accessing - options' }
ZnClient >> enforceHttpSuccess [
	"Return whether or not I enforce that the response 
	to the request is an HTTP success code."

	^self optionAt: #enforceHttpSuccess ifAbsent: [false]
]

{ #category : 'not implemented (yet)',
 #vaCategories : ['not implemented (yet)','utilities'] }
ZnClient >> enforceHttpSuccess: aBoolean [
	"Not implemented yet"


]

{ #category : 'operations' }
ZnClient >> execute [
	"Execute the currently set up request to generate a response.
	Return the #contents of the response, if any."

	| result |

	result := nil. "Keep Smalllint happy."

	self prepareRequest.
	self withProgressDo: [result := self executeWithTimeout].
	self prepareNextRequest.
	^result
]

{ #category : 'private protocol' }
ZnClient >> executeRequestResponse [

	response := ZnResponse wrap: self privateExecute
]

{ #category : 'private protocol' }
ZnClient >> executeWithRedirectsRemaining: redirectCount [

	self getConnectionAndExecute.
	response isRedirect
		ifTrue: [
			(redirectCount > 0 and: [self followRedirects])
				ifTrue: [
					self
						prepareRedirect;
						executeWithRedirectsRemaining: redirectCount - 1]
				ifFalse: [self followRedirects ifTrue: [ZnTooManyRedirects signal]]].
	^self handleResponse
]

{ #category : 'private protocol' }
ZnClient >> executeWithRetriesRemaining: retryCount [

	^[self executeWithRedirectsRemaining: self maxNumberOfRedirects]
		on: self retryExceptionSet
		do: [:exception |
			retryCount > 0
				ifTrue: [
					self
						handleRetry: exception;
						executeWithRetriesRemaining: retryCount - 1]
				ifFalse: [exception pass]]
]

{ #category : 'private protocol' }
ZnClient >> executeWithTimeout [

	^self withTimeoutDo: [
		[self executeWithRetriesRemaining: self numberOfRetries] on: Error do: self ifFailBlock]
]

{ #category : 'accessing - options' }
ZnClient >> followRedirects [
	"Return whether I will automatically following of HTTP redirects.
	This is still subject to #maxNumberOfRedirects. Defaults to true.
	When set to false, redirects will be returned as normal responses."

	^self optionAt: #followRedirects ifAbsent: [true]
]

{ #category : 'private protocol' }
ZnClient >> getConnectionAndExecute [
	"self canReuseConnection 
		ifTrue: [ 
			[ ^ self executeRequestResponse; cleanupConnection ] 
				on: Exception 
				do: [ :exception | self logIgnoringExceptionOnReusedConnection: exception; close ] ]."

	self newConnectionTo: request url.
	[self executeRequestResponse] ensure: [self cleanupConnection]
]

{ #category : 'private protocol' }
ZnClient >> handleResponse [

	self receiveCookies.
	(self enforceHttpSuccess and: [response isSuccess not])
		ifTrue: [
			(self followRedirects not and: [response isRedirect])
				ifFalse: [(ZnHttpUnsuccessful response: response) signal]].
	(self enforceAcceptContentType and: [self isContentTypeAcceptable not])
		ifTrue: [
			(ZnUnexpectedContentType
				expected: request accept asZnMimeType
				actual: response contentType)
					signal].
	^self contents
]

{ #category : 'not implemented (yet)',
 #vaCategories : ['not implemented (yet)','utilities'] }
ZnClient >> handleRetry: exception [
	"No Retry mechanism yet, so not implemented"


]

{ #category : 'accessing - options' }
ZnClient >> ifFailBlock [
	"Return the block that I should execute if the request fails.
	Defaults to #pass-ing the exception up. 
	Accepts an exception as argument."

	^self optionAt: #ifFailBlock ifAbsentPut: [[:exception | exception pass]]
]

{ #category : 'not implemented (yet)',
 #vaCategories : ['not implemented (yet)','testing'] }
ZnClient >> isContentTypeAcceptable [
	"Not implemented yet, so false for now"

	^false
]

{ #category : 'testing' }
ZnClient >> isDelete [

	^self request isDelete
]

{ #category : 'testing' }
ZnClient >> isGet [

	^self request isGet
]

{ #category : 'testing' }
ZnClient >> isHead [

	^self request isHead
]

{ #category : 'accessing - options' }
ZnClient >> isOneShot [
	"Return if I use connections only for a single request/response cycle.
	By default, I will keep HTTP connections open according to the HTTP 1.1 spec.
	When oneShot is true, I will add a Connection: close header to requests."

	^self optionAt: #oneShot ifAbsent: [false]
]

{ #category : 'testing' }
ZnClient >> isPost [

	^self request isPost
]

{ #category : 'testing' }
ZnClient >> isPut [

	^self request isPut
]

{ #category : 'accessing - options' }
ZnClient >> loggingOff [
	"Turn logging completely off - do not generate log events."

	self logLevel: 0
]

{ #category : 'accessing',
 #vaCategories : ['accessing','not implemented (yet)'] }
ZnClient >> logLevel: integer [
	"No logging implemented yet"


]

{ #category : 'not implemented (yet)',
 #vaCategories : ['not implemented (yet)','private protocol'] }
ZnClient >> logRedirect: url [
	"Logging is not enabled yet"
	"^ (self newLogEvent: ZnClientFollowingRedirectEvent)
		target: url;
		emit"


]

{ #category : 'accessing - options' }
ZnClient >> maxNumberOfRedirects [
	"Return the maximum number of HTTP redirect that will be followed.
	Note that when the #followsRedirect option is false, 
	no redirects will ever be followed regardless of the value of this option.
	Defaults to 3. A ZnTooManyRedirects will be signalled when the count reaches zero."

	^self optionAt: #maxNumberOfRedirects ifAbsent: [3]
]

{ #category : 'accessing' }
ZnClient >> nativeClient [

	^nativeClient
]

{ #category : 'private protocol' }
ZnClient >> newConnectionTo: aZnUrl [

	(nativeClient := SstHttpClient forTransportScheme: self transportScheme) startUp.
	self nativeClient proxyEnabled: true
]

{ #category : 'accessing - options' }
ZnClient >> numberOfRetries [
	"Return how many times I will retry a failed request.
	Defaults to 0."

	^self optionAt: #numberOfRetries ifAbsent: [0]
]

{ #category : 'accessing - options' }
ZnClient >> optionAt: key ifAbsent: block [
	"Return my option/settings stored under key.
	Execute block if I have no such option/setting.
	This is a generic interface, see my options protocol for specific usages."

	options ifNil: [^block value].
	^options at: key ifAbsent: block
]

{ #category : 'accessing - options' }
ZnClient >> optionAt: key ifAbsentPut: block [
	"Return my option/settings stored under key.
	If I have no such option/setting, store the result of evaluating block as new value and return it.
	This is a generic interface, see my options protocol for specific usages."

	options ifNil: [options := Dictionary new].
	^options at: key ifAbsentPut: block
]

{ #category : 'private protocol' }
ZnClient >> prepareNextRequest [
	"The request could be modified destructively in the next run,
	but the request can also be part of a log event, hence copy it"

	request := request copy
]

{ #category : 'private protocol' }
ZnClient >> prepareRedirect [
	"We implement the common behavior that POST/PUT redirects turn into GET request
	and that the body data is dropped, except for a 307 or 308 where this is explicitly forbidden.
	Note the cookie handling too."

	| targetUrl |

	targetUrl := self redirectUrl.
	self logRedirect: targetUrl.
	self receiveCookies.
	self prepareNextRequest.
	(#(307 308) includes: response code)
		ifFalse: [
			(#(POST PUT) includes: request method) ifTrue: [self request beGet].
			request hasEntity ifTrue: [request resetEntity: nil]].
	self url: targetUrl.
	self sendCookies
]

{ #category : 'private protocol' }
ZnClient >> prepareRequest [

	self isOneShot ifTrue: [request setConnectionClose].
	request hasEntity
		ifTrue: [
			"This is necessary because entities are often modified after first being added empty,
			and a wrong content length is cached at the request level"
			request resetEntity: request entity].
	self sendCookies.
	self prepareRequestHook ifNotNil: [:hook | hook value: request]
]

{ #category : 'private protocol' }
ZnClient >> prepareRequestHook [
	"Return the current request preparation hook, an object conforming 
	to the #value: protocol that gets the final chance to change a request 
	right before it gets executed. Defaults to nil.
	Typically used to sign requests. See also #prepareRequest: "

	^self optionAt: #prepareRequestHook ifAbsent: [nil]
]

{ #category : 'private protocol' }
ZnClient >> privateExecute [

	self isGet ifTrue: [^self nativeClient get: self request url asString using: nil withHeaders: self request headersDict].
	self isPost ifTrue: [^self nativeClient post: self request entityContents typed: nil at: self request url asString using: nil withHeaders: self request headersDict].
	self isHead ifTrue: [^self nativeClient head:self request url asString withHeaders: self request headersDict].
	self isPut ifTrue: [^self nativeClient put: self request entityContents typed: nil at: self request url asString using: nil withHeaders: self request headersDict].
	self isDelete ifTrue: [^self nativeClient delete: self request url asString typed: nil using: nil withHeaders: self request headersDict].
	
	^self error: 'Execution of HttpMethod not implemented yet'
]

{ #category : 'private protocol' }
ZnClient >> receiveCookies [
	"Not implemented yet"


]

{ #category : 'private protocol' }
ZnClient >> redirectUrl [
	"We support relative locations although they are not the standard (http://en.wikipedia.org/wiki/HTTP_location)"

	| redirectUrl |

	redirectUrl := response location asZnUrl.
	^redirectUrl isAbsolute ifTrue: [redirectUrl] ifFalse: [redirectUrl inContextOf: request url]
]

{ #category : 'accessing' }
ZnClient >> request [

	^request
]

{ #category : 'accessing' }
ZnClient >> request: aZnRequest [

	request := aZnRequest
]

{ #category : 'accessing' }
ZnClient >> response [

	^response
]

{ #category : 'private protocol' }
ZnClient >> retryExceptionSet [

	^ExError
]

{ #category : 'private protocol' }
ZnClient >> sendCookies [
	"Cookies are not needed yet, so not implemented"


]

{ #category : 'not implemented (yet)' }
ZnClient >> setBasicAuthenticationUsername: aUsername password: aPassword [
	"not needed so net implemented yet"


]

{ #category : 'private protocol' }
ZnClient >> setConnectionClose [
	"Not implemented yet"


]

{ #category : 'accessing - options' }
ZnClient >> streaming [
	"Return whether I will return streaming response objects (see ZnStreamingEntity).
	If true, my users are responsible for actually reading the incoming response entity data stream."

	^self optionAt: #streaming ifAbsent: [false]
]

{ #category : 'private protocol' }
ZnClient >> systemPolicy [


]

{ #category : 'private protocol' }
ZnClient >> transportScheme [

	^self request url scheme , 'l'
]

{ #category : 'private protocol' }
ZnClient >> url: urlObject [
	"Modify the URL of the current request object to urlObject.
	This is done using ZnUrl>>#inContextOf: so that either scheme, 
	host, port or path are set and merged.
	Default the URL using ZnUrl>>#asZnUrlWithDefaults to fall back
	to http or the default http/https ports."

	| url |

	url := urlObject asZnUrl.
	request url ifNotNil: [url := url inContextOf: request url].
	url := url asZnUrlWithDefaults.
	self validateConnectionForHost: url host port: url port.
	request url: url.
	url hasUsername & url hasPassword
		ifTrue: [self setBasicAuthenticationUsername: url username password: url password]
]

{ #category : 'private protocol' }
ZnClient >> validateConnectionForHost: host port: port [
	"Method taken from Pharo"

	"(connection isNil or: [ request url isNil ]) 
		ifTrue: [ ^ self ].
	(request url host = host and: [ request url port = port ])
		ifFalse: [ self close ]"

	" Adapted for VASt."

	request url isNil ifTrue: [^self close].
	(request url host = host and: [request url port = port]) ifFalse: [self close]
]

{ #category : 'not implemented (yet)',
 #vaCategories : ['not implemented (yet)','private protocol'] }
ZnClient >> withProgressDo: aBlock [
	"For server runtime, nog progress indication is needed"

	^aBlock value
]

{ #category : 'not implemented (yet)',
 #vaCategories : ['not implemented (yet)','private protocol'] }
ZnClient >> withTimeoutDo: aBlock [

	^aBlock
		value
		"^ ZnConnectionTimeout value
		ifNil: [
			ZnConnectionTimeout 
				value: self timeout 
				during: [ ^ block value ] ]
		ifNotNil: [ 
			block value ]"

]
