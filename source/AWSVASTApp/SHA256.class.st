Class {
	#name : 'SHA256',
	#superclass : 'Object',
	#category : 'AWSVASTApp'
}

{ #category : 'instance creation' }
SHA256 class >> new [

	^OSSslDigest sha256
]
