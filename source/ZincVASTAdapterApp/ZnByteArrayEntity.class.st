Class {
	#name : 'ZnByteArrayEntity',
	#superclass : 'ZnEntity',
	#instVars : [
		'bytes'
	],
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'instance creation' }
ZnByteArrayEntity class >> bytes: byteArray [

	^(self type: ZnMimeType applicationOctetStream length: byteArray size)
		bytes: byteArray;
		yourself
]

{ #category : 'instance creation' }
ZnByteArrayEntity class >> type: type length: length [
	"Create a new entity with a given mime type and length"

	^self new
		contentType: type;
		contentLength: length;
		yourself
]

{ #category : 'accessing' }
ZnByteArrayEntity >> bytes [

	^bytes
]

{ #category : 'accessing' }
ZnByteArrayEntity >> bytes: anObject [

	bytes := anObject
]

{ #category : 'accessing' }
ZnByteArrayEntity >> contents [

	^self bytes
]

{ #category : 'writing' }
ZnByteArrayEntity >> writeOn: stream [

	ZnUtils nextPutAll: self bytes on: stream
]
