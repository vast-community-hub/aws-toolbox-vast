Extension {
	#name : 'AbtMD5Engine'
}

{ #category : '*AWSVASTApp',
 #vaCategories : ['actions'] }
AbtMD5Engine >> hashMessage: aByteArray [

	^self digest: aByteArray
]
