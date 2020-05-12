Class {
	#name : 'AWSXmlObject',
	#superclass : 'Object',
	#category : 'AWSCoreApp'
}

{ #category : 'instance creation' }
AWSXmlObject class >> fromXmlElement: anElement [

	^self new initFromXmlElement: anElement
]

{ #category : 'instance creation' }
AWSXmlObject class >> fromXmlString: aString [

	| xmlDoc |

	xmlDoc := AbtXmlDOMParser parse: aString.
	^self fromXmlElement: xmlDoc root
]

{ #category : 'instance creation' }
AWSXmlObject class >> new [

	^super new initialize
]
