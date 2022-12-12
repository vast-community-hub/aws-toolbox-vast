Extension {
	#name : 'AbtDOMElement'
}

{ #category : 'Simple-API' }
AbtDOMElement >> contentString [

	^self contents abrFirst ifNotNil: [:el | el data]
]

{ #category : 'Simple-API' }
AbtDOMElement >> contentStringAt: aString [

	^(self getElementByTagName: aString) contentString
]

{ #category : 'Simple-API' }
AbtDOMElement >> elementAt: aString [

	^self getElementByTagName: aString
]

{ #category : 'accessing' }
AbtDOMElement >> elements [

	^self contents
]

{ #category : 'Simple-API' }
AbtDOMElement >> elementsAt: aString [

	^self getElementsByTagName: aString
]

{ #category : 'actions' }
AbtDOMElement >> elementsDo: aBlock [

	self contents isCollection
		ifTrue: [self contents do: aBlock]
		ifFalse: [self error: 'Contents is no collection']
]
