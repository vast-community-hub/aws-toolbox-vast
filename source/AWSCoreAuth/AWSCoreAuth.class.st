Class {
	#name : 'AWSCoreAuth',
	#superclass : 'SubApplication',
	#category : 'AWSCoreAuth'
}

{ #category : 'loading/removing' }
AWSCoreAuth class >> failedRemove [

	self loaded
]

{ #category : 'loading/removing' }
AWSCoreAuth class >> loaded [
	"Send #initializeOnLoad to every class defined in this subapplication that implements it."

	defined do: [:aClass |
		(aClass class includesSelector: #initializeOnLoad) ifTrue: [aClass initializeOnLoad]]
]

{ #category : 'instance creation' }
AWSCoreAuth class >> new [

	^super new initialize
]

{ #category : 'loading/removing' }
AWSCoreAuth class >> removing [
	"Send #unload to every class defined in this subapplication that implements it."

	defined do: [:aClass | (aClass class includesSelector: #unload) ifTrue: [aClass unload]]
]
