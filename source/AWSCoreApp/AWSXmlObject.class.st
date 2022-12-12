Class {
	#name : 'AWSXmlObject',
	#superclass : 'Object',
	#category : 'AWSCoreApp'
}

{ #category : 'instance creation' }
AWSXmlObject class >> fromXmlElement: anElement [
	^ self new initFromXmlElement: anElement
]

{ #category : 'instance creation' }
AWSXmlObject class >> fromXmlString: aString [

	| xmlDoc |
	
	xmlDoc := self xmlParser parse: aString.
	^ self fromXmlElement: xmlDoc root
]

{ #category : 'resources' }
AWSXmlObject class >> xmlParser [

	^AbtXmlDOMParser
]
