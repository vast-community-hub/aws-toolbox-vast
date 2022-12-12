Class {
	#name : 'AWSSTService',
	#superclass : 'AWSService',
	#category : 'AWSSecurityTokenServiceApp'
}

{ #category : 'instance creation' }
AWSSTService class >> newForCredentials [
	^self newWithRegion: AWSEnvironment defaultRegionName
]

{ #category : 'instance creation' }
AWSSTService class >> newWithRegion: aRegion [
	^self basicNew initWithRegion: aRegion
]

{ #category : 'api' }
AWSSTService >> assumeRole: anAWSSTSAssumeRoleRequest [

	|httpRequest httpResponse |
	
	httpRequest := anAWSSTSAssumeRoleRequest asHttpRequest: self endpoint.
	
	httpResponse := self httpClient 
		request: httpRequest;
		execute;
		response.
	
	httpResponse isSuccess ifFalse: [ ^self handleErrorResponse: httpResponse ].
	
	^AWSSTSAssumeRoleResponse fromXmlString: httpResponse contents 
]

{ #category : 'internal' }
AWSSTService >> handleErrorResponse: httpResponse [

	| dom |
	
	((ZnMimeType textXml  matches: httpResponse contentType) and: [ httpResponse hasEntity ])
		ifFalse: [ ^ super handleErrorResponse: httpResponse ].
		
	dom := self xmlParser parse: httpResponse contents.
	(AWSError xmlData: dom root) signal
]

{ #category : 'api' }
AWSSTService >> initWithRegion: aRegion [

	region := aRegion.
	endpoint := 'https://sts.', aRegion asLowercase , '.amazonaws.com'
	
]

{ #category : 'resources' }
AWSSTService >> xmlParser [

	^AbtXmlDOMParser
]
