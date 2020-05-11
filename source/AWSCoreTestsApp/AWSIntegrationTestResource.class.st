Class {
	#name : 'AWSIntegrationTestResource',
	#superclass : 'TestResource',
	#classVars : [
		'RegionName',
		'Credentials'
	],
	#category : 'AWSCoreTestsApp'
}

{ #category : 'accessing' }
AWSIntegrationTestResource class >> credentials [

	^Credentials ifNil: [AWSEnvironment defaultCredentials]
]

{ #category : 'accessing' }
AWSIntegrationTestResource class >> credentials: awsCredentials [

	Credentials := awsCredentials
]

{ #category : 'instance creation' }
AWSIntegrationTestResource class >> new [

	^super new initialize
]

{ #category : 'accessing' }
AWSIntegrationTestResource class >> regionName [

	^RegionName ifNil: [AWSEnvironment defaultRegionName]
]

{ #category : 'accessing' }
AWSIntegrationTestResource class >> regionName: aString [

	RegionName := aString
]

{ #category : 'accessing' }
AWSIntegrationTestResource >> credentials [

	^self class credentials
]

{ #category : 'testing' }
AWSIntegrationTestResource >> isAvailable [

	^self credentials notNil and: [self regionName notNil]
]

{ #category : 'accessing' }
AWSIntegrationTestResource >> regionName [

	^self class regionName
]
