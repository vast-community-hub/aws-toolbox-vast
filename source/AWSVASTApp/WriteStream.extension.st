Extension {
	#name : 'WriteStream'
}

{ #category : 'aws' }
WriteStream >> lf [

	self nextPut: Character lf 
]
