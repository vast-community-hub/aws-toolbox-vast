Extension {
	#name : 'WriteStream'
}

{ #category : '*AWSCoreApp',
 #vaCategories : ['aws'] }
WriteStream >> lf [

	self nextPut: Character lf
]
