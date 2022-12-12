Class {
	#name : 'AWSS3CopyObjectResult',
	#superclass : 'AWSXmlObject',
	#instVars : [
		'lastModified',
		'eTag'
	],
	#category : 'AWSSimpleStorageServiceApp'
}

{ #category : 'accessing' }
AWSS3CopyObjectResult >> eTag [

	^ eTag
]

{ #category : 'initialization' }
AWSS3CopyObjectResult >> initFromXmlElement: aXmlElement [

	eTag := aXmlElement contentStringAt: 'ETag'.
	lastModified := aXmlElement contentStringAt: 'LastModified'
]

{ #category : 'accessing' }
AWSS3CopyObjectResult >> lastModified [

	^ lastModified
]
