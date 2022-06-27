Class {
	#name : 'ZnResponse',
	#superclass : 'Object',
	#instVars : [
		'nativeResponse'
	],
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'instance creation' }
ZnResponse class >> wrap: nativeResponse [

	^self new
		nativeResponse: nativeResponse;
		yourself
]

{ #category : 'accessing' }
ZnResponse >> actualResponse [

	^self nativeResponse isSstError
		ifTrue: [self nativeResponse errorObject]
		ifFalse: [self nativeResponse]
]

{ #category : 'accessing' }
ZnResponse >> code [

	^self status
]

{ #category : 'accessing' }
ZnResponse >> contents [

	self nativeResponse isSstError
		ifTrue: [
			^self nativeResponse errorObject contentsSize isZero
				ifTrue: [nil]
				ifFalse: [self nativeResponse errorObject contents asString]].

	self nativeResponse contentsSize isZero ifTrue: [^nil].

	^self nativeResponse header znMimeType isBinary
		ifTrue: [self nativeResponse contents asByteArray]
		ifFalse: [self nativeResponse contents asString]
]

{ #category : 'accessing' }
ZnResponse >> contentsStream [
	"Answer an EsStream pointing to the contents of receiver."

	<answers: #EsStream>

	self nativeResponse isSstError
		ifTrue: [
			^self nativeResponse errorObject contentsSize isZero
				ifTrue: [nil]
				ifFalse: [EsStream fromCollection: self nativeResponse errorObject contents]].

	^self nativeResponse inputStream
]

{ #category : 'accessing' }
ZnResponse >> contentType [

	^ZnMimeType fromString: self actualResponse header contentType
]

{ #category : 'testing' }
ZnResponse >> hasEntity [

	^self actualResponse contentsSize isZero not and: [self actualResponse contents notNil]
]

{ #category : 'accessing' }
ZnResponse >> headers [

	^ZnResponseHeaders wrap: self actualResponse header
]

{ #category : 'testing' }
ZnResponse >> isNotFound [

	"Geeft iets meer terug dan alleen not found"

	^self nativeResponse isSstError not and: [self headers isNotFound]
]

{ #category : 'testing' }
ZnResponse >> isRedirect [

	^self actualResponse header isRedirectionResponse
]

{ #category : 'testing' }
ZnResponse >> isSuccess [

	^self nativeResponse isSstError not and: [self nativeResponse header isSuccessfulResponse]
]

{ #category : 'accessing' }
ZnResponse >> location [

	^self headers at: 'Location'
]

{ #category : 'accessing' }
ZnResponse >> nativeResponse [

	^nativeResponse
]

{ #category : 'accessing' }
ZnResponse >> nativeResponse: aSstResponse [

	nativeResponse := aSstResponse
]

{ #category : 'accessing' }
ZnResponse >> status [

	^self headers statusCode
]
