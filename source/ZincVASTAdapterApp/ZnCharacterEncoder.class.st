Class {
	#name : 'ZnCharacterEncoder',
	#superclass : 'Object',
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'api' }
ZnCharacterEncoder class >> utf8 [

	^GRCodec forEncoding: 'utf-8'
]
