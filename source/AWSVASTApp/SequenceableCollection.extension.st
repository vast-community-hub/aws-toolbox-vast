Extension {
	#name : 'SequenceableCollection'
}

{ #category : 'testing' }
SequenceableCollection >> beginsWith: aCollection [

	^self beginsWithSubCollection: aCollection
]

{ #category : 'testing' }
SequenceableCollection >> endsWith: aCollection [

	^self endsWithSubCollection: aCollection
]
