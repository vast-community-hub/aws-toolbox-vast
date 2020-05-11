Class {
	#name : 'AWSCoreTestsApp',
	#superclass : 'Application',
	#category : 'AWSCoreTestsApp'
}

{ #category : 'loading/removing' }
AWSCoreTestsApp class >> failedRemove [

	self loaded
]

{ #category : 'loading/removing' }
AWSCoreTestsApp class >> loaded [
	"Send #initializeOnLoad to every class defined in this subapplication that implements it."

	defined do: [:aClass |
		(aClass class includesSelector: #initializeOnLoad) ifTrue: [aClass initializeOnLoad]]
]

{ #category : 'instance creation' }
AWSCoreTestsApp class >> new [

	^super new initialize
]

{ #category : 'loading/removing' }
AWSCoreTestsApp class >> removing [
	"Send #unload to every class defined in this subapplication that implements it."

	defined do: [:aClass | (aClass class includesSelector: #unload) ifTrue: [aClass unload]]
]
