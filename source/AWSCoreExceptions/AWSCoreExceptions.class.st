Class {
	#name : 'AWSCoreExceptions',
	#superclass : 'SubApplication',
	#category : 'AWSCoreExceptions'
}

{ #category : 'loading/removing' }
AWSCoreExceptions class >> failedRemove [

	self loaded
]

{ #category : 'loading/removing' }
AWSCoreExceptions class >> loaded [
	"Send #initializeOnLoad to every class defined in this subapplication that implements it."

	defined do: [:aClass |
		(aClass class includesSelector: #initializeOnLoad) ifTrue: [aClass initializeOnLoad]]
]

{ #category : 'instance creation' }
AWSCoreExceptions class >> new [

	^super new initialize
]

{ #category : 'loading/removing' }
AWSCoreExceptions class >> removing [
	"Send #unload to every class defined in this subapplication that implements it."

	defined do: [:aClass | (aClass class includesSelector: #unload) ifTrue: [aClass unload]]
]
