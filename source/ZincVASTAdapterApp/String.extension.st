Extension {
	#name : 'String'
}

{ #category : 'Zinc-adding' }
String >> addedToZnUrl: url [

	| segments |

	segments := self subStrings: $/.
	^url withPathSegments: segments
]

{ #category : 'Zinc-converting' }
String >> asUrl [

	^self asZnUrl
]

{ #category : 'Zinc-converting' }
String >> asZnMimeType [

	^ZnMimeType fromString: self
]

{ #category : 'Zinc-converting' }
String >> asZnUrl [

	^ZnUrl fromString: self
]

{ #category : 'Zinc-encoding-decoding' }
String >> urlEncoded [
	"URL Encode the receiver and return the resulting String.
	This is an encoding where characters that are illegal in a URL are escaped."

	^self sstUrlEncode
]
