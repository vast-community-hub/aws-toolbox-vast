Class {
	#name : 'AWSSTSAssumeRoleResponse',
	#superclass : 'AWSXmlObject',
	#instVars : [
		'result'
	],
	#category : 'AWSSecurityTokenServiceApp'
}

{ #category : 'initialization' }
AWSSTSAssumeRoleResponse >> initFromXmlElement: xmlElement [


	result := AWSSTSAssumeRoleResult fromXmlElement:(xmlElement elementAt: 'AssumeRoleWithWebIdentityResult')
]

{ #category : 'accessing' }
AWSSTSAssumeRoleResponse >> result [

	^result
]
