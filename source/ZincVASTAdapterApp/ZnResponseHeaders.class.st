Class {
	#name : 'ZnResponseHeaders',
	#superclass : 'Object',
	#instVars : [
		'nativeHeaders'
	],
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'instance creation' }
ZnResponseHeaders class >> wrap: aSstHeaders [

	^self new
		nativeHeaders: aSstHeaders;
		yourself
]

{ #category : 'accessing' }
ZnResponseHeaders >> at: aKey [

	^self nativeHeaders at: aKey
]

{ #category : 'accessing' }
ZnResponseHeaders >> nativeHeaders [

	^nativeHeaders
]

{ #category : 'accessing' }
ZnResponseHeaders >> nativeHeaders: anObject [

	nativeHeaders := anObject
]

{ #category : 'accessing' }
ZnResponseHeaders >> statusCode [

	^(self nativeHeaders status first: 3) asNumber
]
