Class {
	#name : 'AWSCredentialsProvider',
	#superclass : 'Object',
	#category : 'AWSCoreAuth'
}

{ #category : 'api' }
AWSCredentialsProvider class >> getCredentials [

	^self subclassResponsibility 
]

{ #category : 'accessing' }
AWSCredentialsProvider class >> getCredentialsIfAbsent: aBlock [

	^self getCredentials ifNil: [ aBlock value ]
]
