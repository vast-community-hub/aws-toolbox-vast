Extension {
	#name : 'AbtDOMNodeList'
}

{ #category : 'accessing' }
AbtDOMNodeList >> elementAt: aString [

	^self detect: [:each | each isNamed: aString]
]
