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

{ #category : 'packaging' }
AWSSimpleStorageServiceApp class >> packagerIncludeClasses [

	^self classes
		remove: self ifAbsent: [];
		yourself
]

{ #category : 'packaging' }
AWSSimpleStorageServiceApp class >> packagerIncludeSelectors [

	| selectors |

	selectors := Set new.

	self packagerIncludeClasses do: [:each |
		selectors
			addAll: each class selectors;
			addAll: each selectors].

	^selectors
]

{ #category : 'loading/removing' }
AWSSimpleStorageServiceApp class >> removing [
	"Send #unload to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #unload) ifTrue: [ aClass unload ] ]
]
