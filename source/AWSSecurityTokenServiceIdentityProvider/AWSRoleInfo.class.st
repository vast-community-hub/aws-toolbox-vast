Class {
	#name : 'AWSRoleInfo',
	#superclass : 'Object',
	#instVars : [
		'roleArn',
		'roleSessionName',
		'externalId',
		'webIdentityTokenFilePath',
		'longLivedCredentialsProvider'
	],
	#category : 'AWSSecurityTokenServiceIdentityProvider'
}

{ #category : 'accessing' }
AWSRoleInfo >> externalId [

	^ externalId
]

{ #category : 'accessing' }
AWSRoleInfo >> externalId: anObject [

	externalId := anObject
]

{ #category : 'accessing' }
AWSRoleInfo >> longLivedCredentialsProvider [

	^ longLivedCredentialsProvider
]

{ #category : 'accessing' }
AWSRoleInfo >> longLivedCredentialsProvider: anObject [

	longLivedCredentialsProvider := anObject
]

{ #category : 'accessing' }
AWSRoleInfo >> roleArn [

	^ roleArn
]

{ #category : 'accessing' }
AWSRoleInfo >> roleArn: anObject [

	roleArn := anObject
]

{ #category : 'accessing' }
AWSRoleInfo >> roleSessionName [

	^ roleSessionName
]

{ #category : 'accessing' }
AWSRoleInfo >> roleSessionName: anObject [

	roleSessionName := anObject
]

{ #category : 'accessing' }
AWSRoleInfo >> webIdentityToken [
	"The following source failed to compile (all double quotes have been doubled):"

	webIdentityTokenFilePath isEmptyOrNil ifTrue: [^nil].

	"	^ [ 
	  webIdentityTokenFilePath asFileReference
		  readStreamEncoded: 'utf-8'
		  do: [ :stream | stream nextLine ] ]
		  on: FileException
		  do: [ nil ]"

	^webIdentityTokenFilePath asPath readStreamDo: [:stream | stream nextLine]
]

{ #category : 'accessing' }
AWSRoleInfo >> webIdentityTokenFilePath [

	^ webIdentityTokenFilePath
]

{ #category : 'accessing' }
AWSRoleInfo >> webIdentityTokenFilePath: anObject [

	webIdentityTokenFilePath := anObject
]
