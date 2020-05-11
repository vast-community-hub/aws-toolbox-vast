Class {
	#name : 'ZnStringEntity',
	#superclass : 'ZnEntity',
	#instVars : [
		'string',
		'encoder'
	],
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'converting' }
ZnStringEntity >> asByteArray [

	^self encodedString asByteArray
]

{ #category : 'accessing' }
ZnStringEntity >> contentLength [

	^contentLength ifNil: [contentLength := self encodedString size asString]
]

{ #category : 'accessing' }
ZnStringEntity >> contents [

	^self string
]

{ #category : 'encoding-decoding' }
ZnStringEntity >> encodedString [

	^self encoder isNil ifTrue: [self string] ifFalse: [self encoder encode: self string]
]

{ #category : 'accessing' }
ZnStringEntity >> encoder [

	^encoder
]

{ #category : 'accessing' }
ZnStringEntity >> encoder: anEncoder [

	encoder := anEncoder
]

{ #category : 'accessing' }
ZnStringEntity >> string [

	^string
]

{ #category : 'accessing' }
ZnStringEntity >> string: aString [

	string := aString
]

{ #category : 'writing' }
ZnStringEntity >> writeOn: stream [

	stream nextPutAll: self contents
]
