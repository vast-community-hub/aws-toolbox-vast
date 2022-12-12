Extension {
	#name : 'OSSslDigest'
}

{ #category : 'api' }
OSSslDigest >> hashMessage: aByteArray [

	^self digest: aByteArray
]

{ #category : 'api' }
OSSslDigest >> hmac [

	^HmacHelper new
		function: self;
		yourself
]
