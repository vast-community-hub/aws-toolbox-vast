Class {
	#name : 'AWSSimpleStorageServiceApp',
	#superclass : 'Application',
	#category : 'AWSSimpleStorageServiceApp'
}

{ #category : 'loading/removing' }
AWSSimpleStorageServiceApp class >> failedRemove [

	self loaded
]

{ #category : 'loading/removing' }
AWSSimpleStorageServiceApp class >> loaded [
	"Send #initializeOnLoad to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #initializeOnLoad) ifTrue: [ aClass initializeOnLoad ] ]
]

{ #category : 'instance creation' }
AWSSimpleStorageServiceApp class >> new [

	^super new initialize
]

{ #category : 'loading/removing' }
AWSSimpleStorageServiceApp class >> removing [
	"Send #unload to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #unload) ifTrue: [ aClass unload ] ]
]
