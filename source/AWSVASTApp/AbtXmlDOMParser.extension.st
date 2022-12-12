Extension {
	#name : 'AbtXmlDOMParser'
}

{ #category : 'actions' }
AbtXmlDOMParser class >> parse: anObject [

	^self newNonValidatingParser parse: anObject
]
