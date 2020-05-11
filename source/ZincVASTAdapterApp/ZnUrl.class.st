Class {
	#name : 'ZnUrl',
	#superclass : 'Object',
	#instVars : [
		'scheme',
		'host',
		'port',
		'segments',
		'query',
		'fragment',
		'username',
		'password'
	],
	#pools : [
		'SstConstants'
	],
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'accessing' }
ZnUrl class >> defaultPortForScheme: scheme [

	(#(http ws) includes: scheme) ifTrue: [^80].
	(#(https wss) includes: scheme) ifTrue: [^443].
	^nil
]

{ #category : 'instance creation' }
ZnUrl class >> fromString: string [

	^self new
		parseFrom: string;
		yourself
]

{ #category : 'accessing' }
ZnUrl class >> schemesNotUsingDoubleSlash [
	"Most URL schemes use a double slash, as in http://
	but some don't, return a list of those"

	^#(mailto telnet)
]

{ #category : 'accessing' }
ZnUrl class >> schemesNotUsingPath [
	"Most URL schemes use a hierarchical path
	but some don't, return a list of those"

	^#(mailto)
]

{ #category : 'adding' }
ZnUrl >> / object [

	^object addedToZnUrl: self
]

{ #category : 'adding' }
ZnUrl >> addedToZnUrl: url [

	^url withPathSegments: self pathSegments
]

{ #category : 'adding' }
ZnUrl >> addPathSegment: segment [
	"Modify the receiver's path by adding segment at the end"

	segments isNil ifTrue: [segments := OrderedCollection new].
	segments add: segment
]

{ #category : 'adding' }
ZnUrl >> addPathSegments: pathSegments [
	"Modify the receiver's path by adding the elements of pathSegments at the end"

	pathSegments do: [:each | self addPathSegment: each]
]

{ #category : 'converting' }
ZnUrl >> asZnUrl [

	^self
]

{ #category : 'converting' }
ZnUrl >> asZnUrlWithDefaults [

	^self copy
		setDefaults;
		yourself
]

{ #category : 'accessing' }
ZnUrl >> authority [

	^self hasNonDefaultPort
		ifTrue: [
			self stringClass streamContents: [:stream |
				stream
					nextPutAll: self host;
					nextPut: $:;
					print: self port]]
		ifFalse: [self host]
]

{ #category : 'actions' }
ZnUrl >> closePath [

	self isDirectoryPath ifFalse: [self addPathSegment: #/]
]

{ #category : 'encoding-decoding' }
ZnUrl >> decodePercent: string [

	^ZnResourceMetaUtils decodePercent: string
]

{ #category : 'printing' }
ZnUrl >> encode: aString on: aStream [

	aStream nextPutAll: (ZnResourceMetaUtils encodePercent: aString)
]

{ #category : 'encoding-decoding' }
ZnUrl >> encodePath: aString on: aStream [

	aStream nextPutAll: aString urlEncoded
]

{ #category : 'encoding-decoding' }
ZnUrl >> encodePercent: string [

	^ZnResourceMetaUtils encodePercent: string
]

{ #category : 'encoding-decoding' }
ZnUrl >> encodeQuery: aString on: aStream [

	aStream nextPutAll: (self encodePercent: aString)
]

{ #category : 'accessing' }
ZnUrl >> fragment [

	^fragment
]

{ #category : 'accessing' }
ZnUrl >> fragment: aString [

	fragment := aString
]

{ #category : 'testing' }
ZnUrl >> hasFragment [

	^fragment notNil
]

{ #category : 'testing' }
ZnUrl >> hasHost [

	^host notNil
]

{ #category : 'testing' }
ZnUrl >> hasNonDefaultPort [

	^self hasPort and: [self port ~= (self class defaultPortForScheme: self schemeOrDefault)]
]

{ #category : 'testing' }
ZnUrl >> hasPassword [

	^password notNil
]

{ #category : 'testing' }
ZnUrl >> hasPath [

	^segments notNil and: [segments isEmpty not]
]

{ #category : 'testing' }
ZnUrl >> hasPort [

	^port notNil
]

{ #category : 'testing' }
ZnUrl >> hasQuery [

	^query notNil and: [query isEmpty not]
]

{ #category : 'testing' }
ZnUrl >> hasScheme [

	^scheme notNil
]

{ #category : 'testing' }
ZnUrl >> hasUsername [

	^username notNil
]

{ #category : 'accessing' }
ZnUrl >> host [

	^host
]

{ #category : 'accessing' }
ZnUrl >> host: aString [

	host := aString
]

{ #category : 'accessing' }
ZnUrl >> hostport [

	^self port
]

{ #category : 'copying' }
ZnUrl >> inContextOf: absoluteUrl [
	"Return a copy of the receiver where scheme, host and port
	are taken from absoluteUrl unless they are already in the receiver.
	Path merging is not supported. See also #withRelativeReference: "

	| copy |

	copy := self copy.
	copy hasScheme ifFalse: [copy scheme: absoluteUrl scheme].
	copy hasHost ifFalse: [copy host: absoluteUrl host].
	(copy hasPort not and: [copy scheme = absoluteUrl scheme]) ifTrue: [copy port: absoluteUrl port].
	^copy
]

{ #category : 'testing' }
ZnUrl >> isAbsolute [
	"We consider URLs with scheme://host as absolute (port is not relevant here).
	See also #inContextOf: and #withRelativeReference:"

	^self hasScheme and: [self hasHost]
]

{ #category : 'testing' }
ZnUrl >> isDirectoryPath [

	^self hasPath ifTrue: [segments last = #/] ifFalse: [true]
]

{ #category : 'testing' }
ZnUrl >> isFile [

	^false
]

{ #category : 'not implemented' }
ZnUrl >> isSchemeNotUsingDoubleSlash: aString [

	"Not Implemented Yet"


]

{ #category : 'testing' }
ZnUrl >> isSchemeUsingDoubleSlash [

	^(self class schemesNotUsingDoubleSlash includes: self scheme) not
]

{ #category : 'testing' }
ZnUrl >> isSchemeUsingPath [

	^(self class schemesNotUsingPath includes: self scheme) not
]

{ #category : 'parsing' }
ZnUrl >> parseAuthority: aString from: start to: stop [

	| index |

	((index := aString indexOf: $@ startingAt: start) > 0 and: [index < stop])
		ifTrue: [
			self parseUserInfo: (ReadStream on: aString from: start to: index - 1).
			self parseHostPort: (ReadStream on: aString from: index + 1 to: stop)]
		ifFalse: [self parseHostPort: (ReadStream on: aString from: start to: stop)]
]

{ #category : 'parsing' }
ZnUrl >> parseFrom: string [

	self parseFrom: string defaultScheme: nil
]

{ #category : 'parsing' }
ZnUrl >> parseFrom: string defaultScheme: defaultScheme [

	| start end index |

	start := 1.
	end := string size.
	(index := string indexOf: $#) > 0
		ifTrue: [
			self fragment: (self decodePercent: (string copyFrom: index + 1 to: end)).
			end := index - 1].
	(index := string indexOf: $?) > 0
		ifTrue: [
			self query:
				(ZnResourceMetaUtils parseQueryFrom: (ReadStream on: string from: index + 1 to: end)).
			end := index - 1].
	((index := string indexOfSubCollection: '://') > 0 and: [index <= end])
		ifTrue: [
			self scheme: (string copyFrom: 1 to: index - 1).
			start := index + 3]
		ifFalse: [
			((index := string indexOf: $:) > 0 and: [
				index <= end
					and: [self isSchemeNotUsingDoubleSlash: (string copyFrom: 1 to: index - 1)]])
						ifTrue: [
							self scheme: (string copyFrom: 1 to: index - 1).
							start := index + 1]
						ifFalse: [defaultScheme ifNotNil: [self scheme: defaultScheme]]].
	self hasScheme
		ifTrue: [
			(index := string indexOf: $/ startingAt: start) > 0
				ifTrue: [
					self parseAuthority: string from: start to: index - 1.
					start := index]
				ifFalse: [^self parseAuthority: string from: start to: end]].
	self parsePath: (ReadStream on: string from: start to: end)
]

{ #category : 'parsing' }
ZnUrl >> parseHostPort: stream [

	| hostString portNumber |

	self isFile
		ifTrue: [
			(hostString := stream upTo: $/) isEmpty
				ifFalse: [self host: (self decodePercent: hostString asLowercase)]]
		ifFalse: [
			(hostString := stream upTo: $:) isEmpty
				ifFalse: [self host: (self decodePercent: hostString asLowercase)].
			stream atEnd
				ifFalse: [
					portNumber :=
						Integer
							readFrom: stream
							ifFail: [ "ZnPortNotANumber" ExSstNonFatalError signal].
					(portNumber between: 1 and: 65535)
						ifFalse: [ "DomainError signalFrom: 1 to: 65535" ExSstNonFatalError signal].
					self port: portNumber]]
]

{ #category : 'parsing' }
ZnUrl >> parsePath: stream [

	stream peekFor: $/.
	[stream atEnd] whileFalse: [| segment |
		segment :=
			String streamContents: [:stringStream |
				[stream atEnd not and: [stream peek ~= $/]]
					whileTrue: [stringStream nextPut: stream next]].
		segment = '.'
			ifFalse: [
				segment = '..'
					ifTrue: [self removeLastPathSegment]
					ifFalse: [self addPathSegment: (self decodePercent: segment)]].
		((stream peekFor: $/) and: [stream atEnd]) ifTrue: [self closePath]]
]

{ #category : 'not implemented' }
ZnUrl >> parseUserInfo: stream [
	"Not implemented yet"


]

{ #category : 'accessing' }
ZnUrl >> password [

	^password
]

{ #category : 'accessing' }
ZnUrl >> password: anObject [

	password := anObject
]

{ #category : 'printing' }
ZnUrl >> pathPrintString [

	^String streamContents: [:stream | self printPathOn: stream]
]

{ #category : 'accessing' }
ZnUrl >> pathSegments [

	^segments ifNil: [#()]
]

{ #category : 'accessing' }
ZnUrl >> port [

	^port
]

{ #category : 'accessing' }
ZnUrl >> port: anInteger [

	port := anInteger
]

{ #category : 'accessing' }
ZnUrl >> portIfAbsent: aBlock [

	^self hasPort ifTrue: [self port] ifFalse: aBlock
]

{ #category : 'accessing' }
ZnUrl >> portOrDefault [

	^self portIfAbsent: [self class defaultPortForScheme: self schemeOrDefault]
]

{ #category : 'printing' }
ZnUrl >> printAuthorityOn: stream [

	self hasUsername
		ifTrue: [
			self encode: self username on: stream.
			self hasPassword
				ifTrue: [
					stream nextPut: $:.
					self encode: self password on: stream].
			stream nextPut: $@].
	self hasHost ifTrue: [self encode: self host on: stream].
	self hasPort
		ifTrue: [
			stream
				nextPut: $:;
				print: self port]
]

{ #category : 'printing' }
ZnUrl >> printOn: stream [

	self hasScheme
		ifTrue: [
			stream
				nextPutAll: self scheme;
				nextPut: $:.
			self isSchemeUsingDoubleSlash
				ifTrue: [
					stream
						nextPut: $/;
						nextPut: $/]].
	self printAuthorityOn: stream.
	self printPathQueryFragmentOn: stream
]

{ #category : 'printing' }
ZnUrl >> printPathOn: stream [

	self hasPath ifFalse: [^stream nextPut: $/].
	segments do: [:each |
		stream nextPut: $/.
		each == #/ ifFalse: [self encodePath: each on: stream]]
]

{ #category : 'printing' }
ZnUrl >> printPathQueryFragmentOn: stream [

	self isSchemeUsingPath ifTrue: [self printPathOn: stream].
	self hasQuery ifTrue: [self printQueryOn: stream].
	self hasFragment ifFalse: [^self].
	stream nextPut: $#.
	self encodeQuery: self fragment on: stream
]

{ #category : 'printing' }
ZnUrl >> printQueryOn: stream [

	stream nextPut: $?.
	ZnResourceMetaUtils writeQueryFields: self query on: stream
]

{ #category : 'accessing' }
ZnUrl >> query [

	^query
]

{ #category : 'accessing' }
ZnUrl >> query: aString [

	query := aString
]

{ #category : 'accessing' }
ZnUrl >> queryAt: key [
	"Return the value of the query parameter key in the receiver.
	Signal a KeyNotFound exception if there is no such parameter"

	^self queryAt: key ifAbsent: [ExCLDTKeyNotFound signalFor: key printString]
]

{ #category : 'accessing' }
ZnUrl >> queryAt: aKey ifAbsent: aBlock [
	"Return the value of the query parameter key in the receiver.
	Execute block if there is no such parameter"

	^self hasQuery ifTrue: [self query at: aKey asString ifAbsent: aBlock] ifFalse: aBlock
]

{ #category : 'accessing' }
ZnUrl >> queryAt: key put: value [
	"Modify the receiver by setting a query variable key=value.
	If key is already exists, it is overwritten."

	query isNil ifTrue: [query := ZnMultiValueDictionary new].
	query at: key asString put: (value ifNotNil: [value asString])
]

{ #category : 'accessing' }
ZnUrl >> queryKeys [
	"Return the collection of all query keys in the receiver"

	^self hasQuery ifTrue: [self query keys] ifFalse: [#()]
]

{ #category : 'actions' }
ZnUrl >> removeLastPathSegment [

	self hasPath ifTrue: [segments removeLast]
]

{ #category : 'accessing' }
ZnUrl >> scheme [

	^scheme
]

{ #category : 'accessing' }
ZnUrl >> scheme: aString [

	scheme := aString
]

{ #category : 'accessing' }
ZnUrl >> schemeOrDefault [

	^self hasScheme ifTrue: [self scheme asSymbol] ifFalse: [#http]
]

{ #category : 'accessing' }
ZnUrl >> setDefaults [

	self hasScheme ifFalse: [self scheme: self schemeOrDefault].
	self hasPort ifFalse: [self port: self portOrDefault]
]

{ #category : 'accessing' }
ZnUrl >> sortedQueryKeys [

	^self queryKeys sorted: [:a :b | a caseSensitiveSortsBefore: b]
]

{ #category : 'accessing' }
ZnUrl >> username [

	^username
]

{ #category : 'accessing' }
ZnUrl >> username: anObject [

	username := anObject
]

{ #category : 'copying' }
ZnUrl >> withPathSegments: pathSegments [
	"Return a new URL equal to the receiver with its path extended with pathSegments"

	^self copy
		addPathSegments: pathSegments;
		yourself
]
