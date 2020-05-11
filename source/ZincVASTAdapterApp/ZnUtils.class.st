Class {
	#name : 'ZnUtils',
	#superclass : 'Object',
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'encoding-decoding' }
ZnUtils class >> encodeBase64: aByteArray [

	^Base64Coder current encode: aByteArray
]

{ #category : 'streaming' }
ZnUtils class >> nextPutAll: collection on: stream [

	^stream nextPutAll: collection
]
