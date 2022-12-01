Class {
	#name : 'AWSSTSAssumeRoleResult',
	#superclass : 'AWSXmlObject',
	#instVars : [
		'credentials'
	],
	#category : 'AWSSecurityTokenServiceApp'
}

{ #category : 'accessing' }
AWSSTSAssumeRoleResult >> credentials [
	^credentials
]

{ #category : 'initialization' }
AWSSTSAssumeRoleResult >> initFromXmlElement: xmlElement [


	credentials := AWSCredentials fromXmlElement:(xmlElement elementAt: 'Credentials')
]
