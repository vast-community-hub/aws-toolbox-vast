Class {
	#name : 'AWSRequest',
	#superclass : 'AWSJsonObject',
	#category : 'AWSCoreApp'
}

{ #category : 'converting' }
AWSRequest >> asHttpRequest: endpointUrl [
	"Create a POST request to the AWS CloudWatch Logs service with the receiver as the payload."

	| entity request |

	entity :=
		(ZnStringEntity type: self mimeType)
			string: self asJsonString;
			yourself.
	request :=
		(ZnRequest post: endpointUrl)
			setAccept: ZnMimeType applicationJson;
			entity: entity;
			yourself.
	request headers at: AWSHeaders x_amz_target put: self target.
	^request
]

{ #category : 'converting' }
AWSRequest >> mimeType [

	^AWSUtils awsJsonMimeType
]

{ #category : 'accessing' }
AWSRequest >> operationName [

	^self subclassResponsibility
]

{ #category : 'accessing' }
AWSRequest >> resultClass [
	"The following source failed to compile (all double quotes have been doubled):
	"
	"Answer the class that wraps the result of executing this request.
	Request subclasses with operations that return a meaningfull result should override this message."
	"
	^ AWSGenericResult
"

	##MonticelloMethodCompilationFailure.
	^self error: 'The source for this method failed to compile'
]

{ #category : 'accessing' }
AWSRequest >> serviceName [

	self subclassResponsibility
]

{ #category : 'accessing' }
AWSRequest >> serviceVersion [

	^self subclassResponsibility
]

{ #category : 'converting' }
AWSRequest >> target [

	^self serviceName , '_' , self serviceVersion , '.' , self operationName
]
