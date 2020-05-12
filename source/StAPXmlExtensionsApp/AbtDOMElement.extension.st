Extension {
	#name : 'AbtDOMElement'
}

{ #category : '*StAPXmlExtensionsApp',
 #vaCategories : ['Simple-API'] }
AbtDOMElement >> contentString [

	^self contents abrFirst ifNotNil: [:el | el data]
]

{ #category : '*StAPXmlExtensionsApp',
 #vaCategories : ['Simple-API'] }
AbtDOMElement >> contentStringAt: aString [

	^(self getElementByTagName: aString) contentString
]

{ #category : '*StAPXmlExtensionsApp',
 #vaCategories : ['Simple-API'] }
AbtDOMElement >> elementAt: aString [

	^self getElementByTagName: aString
]

{ #category : '*StAPXmlExtensionsApp',
 #vaCategories : ['accessing'] }
AbtDOMElement >> elements [

	^self contents
]

{ #category : '*StAPXmlExtensionsApp',
 #vaCategories : ['Simple-API'] }
AbtDOMElement >> elementsAt: aString [

	^self getElementsByTagName: aString
]

{ #category : '*StAPXmlExtensionsApp',
 #vaCategories : ['actions'] }
AbtDOMElement >> elementsDo: aBlock [

	self contents isCollection
		ifTrue: [self contents do: aBlock]
		ifFalse: [self error: 'Contents is no collection']
]
