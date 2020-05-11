Class {
	#name : 'AWSIntegrationTest',
	#superclass : 'TestCase',
	#category : 'AWSCoreTestsApp'
}

{ #category : 'testing' }
AWSIntegrationTest class >> isAbstract [

	^self name = #AWSIntegrationTest
]

{ #category : 'testing' }
AWSIntegrationTest class >> isIntegrationTest [

	^true
]

{ #category : 'instance creation' }
AWSIntegrationTest class >> new [

	^super new initialize
]

{ #category : 'accessing' }
AWSIntegrationTest class >> resources [

	^Array with: AWSIntegrationTestResource
]

{ #category : 'resources' }
AWSIntegrationTest >> credentials [

	^AWSIntegrationTestResource current credentials
]

{ #category : 'resources' }
AWSIntegrationTest >> regionName [

	^AWSIntegrationTestResource current regionName
]
