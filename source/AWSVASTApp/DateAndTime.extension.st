Extension {
	#name : 'DateAndTime'
}

{ #category : '*AWSVASTApp',
 #vaCategories : ['instance creation'] }
DateAndTime class >> fromString: aString [

	^self abtXmlFromString: aString
]

{ #category : '*AWSVASTApp',
 #vaCategories : ['accessing'] }
DateAndTime >> hours [

	^self time hours
]

{ #category : '*AWSVASTApp',
 #vaCategories : ['accessing'] }
DateAndTime >> minutes [

	^self time minutes
]

{ #category : '*AWSVASTApp',
 #vaCategories : ['accessing'] }
DateAndTime >> seconds [

	^self time seconds
]
