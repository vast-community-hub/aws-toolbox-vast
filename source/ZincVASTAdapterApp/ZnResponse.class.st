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
ZnResponse >> isBadRequest [

	^self code = 400
]

{ #category : 'testing' }
ZnResponse >> isError [

	^self code > 399
]

{ #category : 'testing' }
ZnResponse >> isNotFound [

	^self code = 404
]

{ #category : 'testing' }
ZnResponse >> isRedirect [

	^#(301 302 303 307) includes: self code
]

{ #category : 'testing' }
ZnResponse >> isSuccess [

	^#(200 201 202 204) includes: self code
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
