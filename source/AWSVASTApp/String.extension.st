Extension {
	#name : 'String'
}

{ #category : 'converting' }
String >> asInteger [

	^self asNumber
]

{ #category : 'convenient' }
String >> trimmed [

	^self trimBlanks
]
