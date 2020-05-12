Extension {
	#name : 'Integer'
}

{ #category : '*AWSVASTApp',
 #vaCategories : ['printing'] }
Integer >> printOn: aStream padTo: anInteger [

	self printOn: aStream base: 10 showRadix: false padTo: anInteger with: $0
]
