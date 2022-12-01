Class {
	#name : 'AWSCoreApp',
	#superclass : 'Application',
	#category : 'AWSCoreApp'
}

{ #category : 'loading/removing' }
AWSCoreApp class >> failedRemove [

	self loaded
]

{ #category : 'loading/removing' }
AWSCoreApp class >> loaded [
	"Send #initializeOnLoad to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #initializeOnLoad) ifTrue: [ aClass initializeOnLoad ] ]
]

{ #category : 'packaging' }
AWSCoreApp class >> packagerIncludeClasses [

	^self classes
		remove: self ifAbsent: [];
		yourself
]

{ #category : 'packaging' }
AWSCoreApp class >> packagerIncludeSelectors [

	| selectors |

	selectors := Set new.

	self packagerIncludeClasses do: [:each |
		selectors
			addAll: each class selectors;
			addAll: each selectors].

	^selectors
]

{ #category : 'loading/removing' }
AWSCoreApp class >> removing [
	"Send #unload to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #unload) ifTrue: [ aClass unload ] ]
]
