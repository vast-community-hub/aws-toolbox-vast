Extension {
	#name : 'String'
}

{ #category : '*AWSVASTApp',
 #vaCategories : ['converting'] }
String >> asInteger [

	^self asNumber
]

{ #category : '*AWSVASTApp',
 #vaCategories : ['convenient'] }
String >> trimmed [

	^self trimBlanks
]
