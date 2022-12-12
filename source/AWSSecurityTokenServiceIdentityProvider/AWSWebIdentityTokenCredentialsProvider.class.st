Class {
	#name : 'AWSWebIdentityTokenCredentialsProvider',
	#superclass : 'AWSCredentialsProvider',
	#category : 'AWSSecurityTokenServiceIdentityProvider'
}

{ #category : 'api' }
AWSWebIdentityTokenCredentialsProvider class >> getCredentials [

	| env role session webIdentity |
	env := OSEnvironment current.

	role := env at: self roleArnEnv ifAbsent: [nil].
	session := env at: self roleSessionNameEnv ifAbsent: ['aws-sdk-smalltalk-',AWSUtils awsTimestamp asString].
	webIdentity := env at: self webIdentityEnv ifAbsent: [nil].

	^ self
		  getCredentialsWithRole: role
		  sessionName: session
		  webIdentity: webIdentity
]

{ #category : 'api' }
AWSWebIdentityTokenCredentialsProvider class >> getCredentialsWithRole: role sessionName: session webIdentity: webIdentity [

	| roleInfo provider |
	
	(role isEmptyOrNil or: [ 
		 session isEmptyOrNil or: [ webIdentity isEmptyOrNil ] ]) ifTrue: [ 
		^ nil ].

	roleInfo := AWSRoleInfo new
		            roleArn: role;
		            roleSessionName: session;
		            webIdentityTokenFilePath: webIdentity;
		            yourself.

	provider := AWSSTSProfileCredentialsServiceLoader instance
		            roleInfo: roleInfo;
		            yourself.

	^ provider getCredentials
]

{ #category : 'resources' }
AWSWebIdentityTokenCredentialsProvider class >> roleArnEnv [

	^ 'AWS_ROLE_ARN'
]

{ #category : 'resources' }
AWSWebIdentityTokenCredentialsProvider class >> roleSessionNameEnv [

	^ 'AWS_ROLE_SESSION_NAME'
]

{ #category : 'resources' }
AWSWebIdentityTokenCredentialsProvider class >> webIdentityEnv [

	^ 'AWS_WEB_IDENTITY_TOKEN_FILE'
]
