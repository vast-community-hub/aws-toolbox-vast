Class {
	#name : 'AWSS3IntegrationTest',
	#superclass : 'AWSIntegrationTest',
	#classVars : [
		'TestBucketName'
	],
	#category : 'AWSSimpleStorageServiceTestsApp'
}

{ #category : 'instance creation' }
AWSS3IntegrationTest class >> new [

	^super new initialize
]

{ #category : 'accessing' }
AWSS3IntegrationTest class >> testBucketName [

	^TestBucketName ifNil: [TestBucketName := 'smalltalk-test-bucket-mmp']
]

{ #category : 'accessing' }
AWSS3IntegrationTest class >> testBucketName: aString [

	TestBucketName := aString
]

{ #category : 'accessing' }
AWSS3IntegrationTest >> s3service [

	^AWSSimpleStorageService newWithCredentials: self credentials region: self regionName
]

{ #category : 'accessing' }
AWSS3IntegrationTest >> s3testBucket [

	| s3s |

	s3s := self s3service.
	(s3s hasBucket: self class testBucketName) ifFalse: [s3s put: self class testBucketName].

	^AWSS3Bucket
		newWithCredentials: self credentials
		region: self regionName
		bucket: self class testBucketName
]

{ #category : 'tests' }
AWSS3IntegrationTest >> testBucketSetup [

	| s3b result |

	s3b := self s3testBucket.
	result := s3b listObjects.
	self assert: result class name equals: #AWSS3ListBucketsResult
]

{ #category : 'tests' }
AWSS3IntegrationTest >> testGetBuckets [

	| result |

	result := self s3service getBuckets.
	self assert: result class name equals: #AWSS3ListAllMyBucketsResult
]

{ #category : 'tests' }
AWSS3IntegrationTest >> testPutObject [

	| s3b bytes entity result |

	s3b := self s3testBucket.

	bytes := ByteArray streamContents: [:s | 1 to: 10240 do: [:index | s nextPut: index \\ 256]].
	entity := ZnByteArrayEntity bytes: bytes.

	result :=
		s3b
			put: entity
			key: 'testobject.bin'
			headers: (
				Dictionary new
					at: 'X-Pharo-H1' put: 'abc';
					at: 'X-Pharo-H2' put: 'qwerty';
					yourself).

	self assert: result status equals: 200.
	self assert: (result headers at: 'Etag') equals: '"a706f5748be39c7724383a73b0a9ac5c"'.
	self
		assert: (result headers at: 'Etag') allButFirst allButLast
		equals: (MD5 new hashMessage: bytes) hex.

	result := s3b get: 'testobject.bin'.
	self assert: result status equals: 200.
	self assert: (result headers at: 'Etag') equals: '"a706f5748be39c7724383a73b0a9ac5c"'.
	self assert: result contents equals: bytes

	" Delete is not possible with our personal accounts
	result := s3b delete: 'testobject.bin'.
	self assert: result status equals: 204"

]
