Class {
	#name : 'AWSJsonObject',
	#superclass : 'Object',
	#category : 'AWSCoreApp'
}

{ #category : 'accessing' }
AWSJsonObject class >> capitalizeInstVars [

	^false
]

{ #category : 'instance creation' }
AWSJsonObject class >> fromJsonStream: aStream [

	^(NeoJSONReader on: aStream) nextAs: self
]

{ #category : 'instance creation' }
AWSJsonObject class >> fromJsonString: aString [

	^self fromJsonStream: aString readStream
]

{ #category : 'accessing' }
AWSJsonObject class >> neoJsonMapping: mapper [
	"By default, just map all of the receivers instance variables."

	mapper
		for: self
		do: [:mapping |
			self capitalizeInstVars
				ifTrue: [mapping mapInstVarsCapitalized]
				ifFalse: [mapping mapInstVars]]
]

{ #category : 'instance creation' }
AWSJsonObject class >> new [

	^super new initialize
]

{ #category : 'converting' }
AWSJsonObject >> asJsonString [

	^NeoJSONWriter toString: self
]
