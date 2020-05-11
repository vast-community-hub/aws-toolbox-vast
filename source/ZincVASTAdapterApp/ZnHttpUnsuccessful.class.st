Class {
	#name : 'ZnHttpUnsuccessful',
	#superclass : 'Error',
	#instVars : [
		'response'
	],
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'instance creation' }
ZnHttpUnsuccessful class >> response: aZnResponse [

	^self new
		response: aZnResponse;
		yourself
]

{ #category : 'accessing' }
ZnHttpUnsuccessful >> response [

	^response
]

{ #category : 'accessing' }
ZnHttpUnsuccessful >> response: anObject [

	response := anObject
]
