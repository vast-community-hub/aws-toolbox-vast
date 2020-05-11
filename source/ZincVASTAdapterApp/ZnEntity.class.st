Class {
	#name : 'ZnEntity',
	#superclass : 'Object',
	#instVars : [
		'contentType',
		'contentLength'
	],
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'instance creation' }
ZnEntity class >> type: aZnMimeType [

	^self new
		contentType: aZnMimeType;
		yourself
]

{ #category : 'converting' }
ZnEntity >> asByteArray [
	"Return the ByteArray that is the binary, encoded representation of the receiver"

	^ByteArray streamContents: [:stream | self writeOn: stream]
]

{ #category : 'accessing' }
ZnEntity >> contentLength [

	^contentLength
]

{ #category : 'accessing' }
ZnEntity >> contentLength: anInteger [

	contentLength := anInteger
]

{ #category : 'accessing' }
ZnEntity >> contents [

	^self subclassResponsibility
]

{ #category : 'accessing' }
ZnEntity >> contentType [

	^contentType
]

{ #category : 'accessing' }
ZnEntity >> contentType: aType [

	contentType := aType
]

{ #category : 'writing' }
ZnEntity >> writeOn: stream [

	self subclassResponsibility
]
