Extension {
	#name : 'Integer'
}

{ #category : 'printing' }
Integer >> printOn: aStream padTo: anInteger [

	self printOn: aStream base: 10 showRadix: false padTo: anInteger with: $0
]
