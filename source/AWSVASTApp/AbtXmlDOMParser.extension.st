Extension {
	#name : 'AbtXmlDOMParser'
}

{ #category : '*AWSVASTApp',
 #vaCategories : ['actions'] }
AbtXmlDOMParser class >> parse: anObject [

	^self newNonValidatingParser parse: anObject
]
