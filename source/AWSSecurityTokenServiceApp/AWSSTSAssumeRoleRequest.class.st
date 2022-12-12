Class {
	#name : 'AWSSTSAssumeRoleRequest',
	#superclass : 'AWSSTSRequest',
	#instVars : [
		'roleArn',
		'roleSessionName',
		'webIdentityToken',
		'providerId',
		'policyArns',
		'policy',
		'durationSeconds'
	],
	#category : 'AWSSecurityTokenServiceApp'
}

{ #category : 'converting' }
AWSSTSAssumeRoleRequest >> action [

	^ 'AssumeRoleWithWebIdentity'
]

{ #category : 'converting' }
AWSSTSAssumeRoleRequest >> asHttpRequest: anEndpoint [

	| url |

	url :=  anEndpoint asZnUrl.
	self action isEmptyOrNil ifFalse:[url queryAt: 'Action' put: self action].
	self version isEmptyOrNil ifFalse:[url queryAt: 'Version' put: self version].
	self durationSeconds isEmptyOrNil ifFalse:[url queryAt: 'DurationSeconds' put: self durationSeconds].
	self policy isEmptyOrNil ifFalse:[url queryAt: 'Policy' put: self policy].
	self providerId isEmptyOrNil ifFalse:[url queryAt: 'ProviderId' put: self providerId].
	self roleSessionName isEmptyOrNil ifFalse: [url queryAt: 'RoleSessionName' put: self roleSessionName].
	self roleArn isEmptyOrNil ifFalse:[ url queryAt: 'RoleArn' put: self roleArn].
	self webIdentityToken isEmptyOrNil ifFalse:[url queryAt: 'WebIdentityToken' put: self webIdentityToken ].
	
	self policyArns doWithIndex:[:each :index | url queryAt: 'PolicyArns.member.',index asString,'.arn'  put: each].
	
	^ZnRequest get: url.
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> durationSeconds [

	^ durationSeconds
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> durationSeconds: anObject [

	durationSeconds := anObject
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> policy [

	^policy
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> policy: aPolicy [

	policy := aPolicy
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> policyArns [
	^policyArns ifNil: [ policyArns := OrderedCollection new ]
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> policyArns: policyArnsColl [
	policyArns := policyArnsColl
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> providerId [

	^ providerId
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> providerId: anObject [

	providerId := anObject
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> roleArn [

	^ roleArn
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> roleArn: anObject [

	roleArn := anObject
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> roleSessionName [

	^ roleSessionName
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> roleSessionName: anObject [

	roleSessionName := anObject
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> webIdentityToken [

	^ webIdentityToken
]

{ #category : 'accessing' }
AWSSTSAssumeRoleRequest >> webIdentityToken: anObject [

	webIdentityToken := anObject
]
