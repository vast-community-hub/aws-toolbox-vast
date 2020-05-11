Extension {
	#name : 'AbtDOMNodeList'
}

{ #category : '*AWSVASTApp',
 #vaCategories : ['accessing'] }
AbtDOMNodeList >> elementAt: aString [

	^self detect: [:each | each isNamed: aString]
]
