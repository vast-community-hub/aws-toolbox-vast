Extension {
	#name : 'OSSslDigest'
}

{ #category : '*AWSVASTApp',
 #vaCategories : ['api'] }
OSSslDigest >> hashMessage: aByteArray [

	^self digest: aByteArray
]
