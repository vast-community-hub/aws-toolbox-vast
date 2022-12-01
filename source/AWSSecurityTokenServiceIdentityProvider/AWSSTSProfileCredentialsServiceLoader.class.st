Class {
	#name : 'AWSSTSProfileCredentialsServiceLoader',
	#superclass : 'Object',
	#instVars : [
		'roleInfo'
	],
	#classVars : [
		'Instance'
	],
	#category : 'AWSSecurityTokenServiceIdentityProvider'
}

{ #category : 'accessing' }
AWSSTSProfileCredentialsServiceLoader class >> instance [
	^Instance ifNil: [ Instance := self new ]
]

{ #category : 'api' }
AWSSTSProfileCredentialsServiceLoader >> getCredentials [

	| service request response |
	roleInfo ifNil: [ ^ nil ].

	service := AWSSTService newForCredentials.

	request := AWSSTSAssumeRoleRequest new
		           roleSessionName: roleInfo roleSessionName;
		           roleArn: roleInfo roleArn;
		           webIdentityToken: roleInfo webIdentityToken;
		           yourself.
	
	response := service assumeRole: request.
	
	^ response result credentials
	
	
	
	
]

{ #category : 'accessing' }
AWSSTSProfileCredentialsServiceLoader >> roleInfo: aRoleInfo [
	roleInfo := aRoleInfo
	
]
