Class {
	#name : 'ZnRequest',
	#superclass : 'Object',
	#instVars : [
		'headers',
		'entity',
		'method',
		'url'
	],
	#pools : [
		'SstHttpConstants'
	],
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'instance creation' }
ZnRequest class >> delete: aString [

	^self new
		beDelete;
		setUrl: aString;
		yourself
]

{ #category : 'instance creation' }
ZnRequest class >> get: aString [

	^self new
		beGet;
		setUrl: aString;
		yourself
]

{ #category : 'instance creation' }
ZnRequest class >> head: aString [

	^self new
		beHead;
		setUrl: aString;
		yourself
]

{ #category : 'instance creation' }
ZnRequest class >> new [

	^super new initialize
]

{ #category : 'instance creation' }
ZnRequest class >> post: aString [

	^self new
		bePost;
		setUrl: aString;
		yourself
]

{ #category : 'instance creation' }
ZnRequest class >> put: aString [

	^self new
		bePut;
		setUrl: aString;
		yourself
]

{ #category : 'accessing - headers' }
ZnRequest >> authorization [

	^self headers at: 'Authorization'
]

{ #category : 'api' }
ZnRequest >> beDelete [

	method := HttpDeleteMethod
]

{ #category : 'api' }
ZnRequest >> beGet [

	method := HttpGetMethod
]

{ #category : 'api' }
ZnRequest >> beHead [

	method := HttpHeadMethod
]

{ #category : 'api' }
ZnRequest >> bePost [

	method := HttpPostMethod
]

{ #category : 'api' }
ZnRequest >> bePut [

	method := HttpPutMethod
]

{ #category : 'accessing' }
ZnRequest >> entity [

	^entity
]

{ #category : 'accessing' }
ZnRequest >> entity: aZnEntity [

	entity := aZnEntity.
	self headersAt: HttpContentLengthKey put: aZnEntity contentLength asString.
	self headersAt: HttpContentTypeKey put: aZnEntity contentType asString
]

{ #category : 'accessing' }
ZnRequest >> entityContents [

	^self entity ifNotNil: [:ent | ent contents]
]

{ #category : 'testing' }
ZnRequest >> hasEntity [

	^self entity notNil
]

{ #category : 'accessing' }
ZnRequest >> headers [

	^headers
]

{ #category : 'api' }
ZnRequest >> headersAt: aKey put: aValue [

	self headers at: aKey put: aValue
]

{ #category : 'accessing - headers' }
ZnRequest >> headersDict [

	^self headers headers
]

{ #category : 'initialize' }
ZnRequest >> initialize [

	super initialize.

	(headers := ZnHeaders new)
		at: HttpAcceptKey put: '*/*';
		at: HttpUserAgentKey put: ('%1 %2 Zinc Adapter' bindWith: System productName with: System productVersion)
]

{ #category : 'testing' }
ZnRequest >> isDelete [

	^self method = HttpDeleteMethod
]

{ #category : 'testing' }
ZnRequest >> isGet [

	^self method = HttpGetMethod
]

{ #category : 'testing' }
ZnRequest >> isHead [

	^self method = HttpHeadMethod
]

{ #category : 'testing' }
ZnRequest >> isPost [

	^self method = HttpPostMethod
]

{ #category : 'testing' }
ZnRequest >> isPut [

	^self method = HttpPutMethod
]

{ #category : 'accessing' }
ZnRequest >> method [

	^method
]

{ #category : 'accessing' }
ZnRequest >> port [

	| parts |

	parts := self url address subStrings: $:.

	(parts size = 1)
		ifTrue: [
			(self url scheme = 'http') ifTrue: [^80].
			(self url scheme = 'https') ifTrue: [^443]].

	(parts size = 2) ifTrue: [^parts second asNumber].

	^self error: 'No Port found for this scheme'
]

{ #category : 'api' }
ZnRequest >> resetEntity: object [
	"Set my entity to object. Always set my content type and length as defined by object,
	even if I am already describing an entity using my content type and length.
	See also: #clearEntity"

	(entity ~= object and: [entity notNil]) ifTrue: [entity close].
	entity := object.
	self headers acceptEntityDescription: object
]

{ #category : 'accessing - headers' }
ZnRequest >> setAccept: object [

	self headersAt: 'Accept' put: object asString
]

{ #category : 'api' }
ZnRequest >> setAuthorization: aString [

	self headersAt: 'Authorization' put: aString
]

{ #category : 'api' }
ZnRequest >> setUrl: aStringOrUrl [

	self url: aStringOrUrl asZnUrl.

	self headersAt: 'Host' put: self url authority
]

{ #category : 'accessing' }
ZnRequest >> url [

	^url
]

{ #category : 'accessing' }
ZnRequest >> url: aZnUrl [

	url := aZnUrl
]
