Class {
	#name : 'AWSSimpleStorageServiceTestsApp',
	#superclass : 'Application',
	#category : 'AWSSimpleStorageServiceTestsApp'
}

{ #category : 'loading/removing' }
AWSSimpleStorageServiceTestsApp class >> failedRemove [

	self loaded
]

{ #category : 'loading/removing' }
AWSSimpleStorageServiceTestsApp class >> loaded [
	"Send #initializeOnLoad to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #initializeOnLoad) ifTrue: [ aClass initializeOnLoad ] ]
]

{ #category : 'loading/removing' }
AWSSimpleStorageServiceTestsApp class >> removing [
	"Send #unload to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #unload) ifTrue: [ aClass unload ] ]
]
