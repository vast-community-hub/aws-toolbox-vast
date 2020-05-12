Extension {
	#name : 'SequenceableCollection'
}

{ #category : '*AWSVASTApp',
 #vaCategories : ['testing'] }
SequenceableCollection >> beginsWith: aCollection [

	^self beginsWithSubCollection: aCollection
]

{ #category : '*AWSVASTApp',
 #vaCategories : ['testing'] }
SequenceableCollection >> endsWith: aCollection [

	^self endsWithSubCollection: aCollection
]
