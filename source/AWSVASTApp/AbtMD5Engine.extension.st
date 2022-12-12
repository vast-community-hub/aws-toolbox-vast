Extension {
	#name : 'AbtMD5Engine'
}

{ #category : 'actions' }
AbtMD5Engine >> hashMessage: aByteArray [

	^self digest: aByteArray
]
