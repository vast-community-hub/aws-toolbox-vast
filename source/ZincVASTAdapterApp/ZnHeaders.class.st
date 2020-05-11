Class {
	#name : 'ZnHeaders',
	#superclass : 'Object',
	#instVars : [
		'headers'
	],
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'instance creation' }
ZnHeaders class >> new [

	^super new
		initialize;
		yourself
]

{ #category : 'instance creation' }
ZnHeaders class >> wrap: aSstHttpHeader [

	^self new
		headers: aSstHttpHeader fields;
		yourself
]

{ #category : 'actions' }
ZnHeaders >> acceptEntityDescription: entity [
	"Take over the content type and length from entity"

	entity
		ifNotNil: [
			self
				contentType: entity contentType;
				contentLength: entity contentLength]
		ifNil: [
			self
				clearContentType;
				clearContentLength]
]

{ #category : 'adding' }
ZnHeaders >> addAll: keyedCollection [
	"Note that we use #addAllMulti:"

	keyedCollection isEmpty ifFalse: [self headers addAll: keyedCollection].
	^keyedCollection
]

{ #category : 'accessing' }
ZnHeaders >> at: aKey [

	^self headers at: aKey
]

{ #category : 'adding' }
ZnHeaders >> at: aKey ifAbsent: aBlock [

	^self headers at: aKey ifAbsent: aBlock
]

{ #category : 'adding' }
ZnHeaders >> at: aKey put: aValue [

	self headers at: aKey put: aValue
]

{ #category : 'actions' }
ZnHeaders >> clearContentLength [

	self contentLength: nil
]

{ #category : 'actions' }
ZnHeaders >> clearContentType [

	self contentType: nil
]

{ #category : 'accessing' }
ZnHeaders >> contentLength: anInteger [

	self at: 'Content-Length' put: anInteger asString
]

{ #category : 'accessing' }
ZnHeaders >> contentType: aZnMimeType [

	self at: 'Content-Type' put: aZnMimeType asString
]

{ #category : 'accessing' }
ZnHeaders >> headers [

	^headers
]

{ #category : 'accessing' }
ZnHeaders >> headers: aDictionary [

	headers := aDictionary
]

{ #category : 'actions' }
ZnHeaders >> headersDo: aBlock [
	"Execute a two argument (key, value) block for each header.
	Multi-valued headers are handled transparently."

	self headers isEmpty ifTrue: [^self].
	self headers keysAndValuesDo: [:headerKey :headerValue |
		headerValue isArray
			ifTrue: [headerValue do: [:each | aBlock value: headerKey value: each]]
			ifFalse: [aBlock value: headerKey value: headerValue]]
]

{ #category : 'initialize' }
ZnHeaders >> initialize [

	super initialize.
	headers := Dictionary new
]

{ #category : 'removing' }
ZnHeaders >> removeKey: aString [

	self headers removeKey: aString
]
