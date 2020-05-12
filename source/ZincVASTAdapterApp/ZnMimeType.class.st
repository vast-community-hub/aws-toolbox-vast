Class {
	#name : 'ZnMimeType',
	#superclass : 'Object',
	#instVars : [
		'main',
		'sub',
		'parameters'
	],
	#classVars : [
		'TextSubTypeFragments'
	],
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'instance creation' }
ZnMimeType class >> applicationJson [

	^self main: 'application' sub: 'json'
]

{ #category : 'instance creation' }
ZnMimeType class >> applicationOctetStream [

	^self main: 'application' sub: 'octet-stream'
]

{ #category : 'instance creation' }
ZnMimeType class >> applicationXml [

	^self main: 'application' sub: 'xml'
]

{ #category : 'instance creation' }
ZnMimeType class >> fromString: aString [

	| main endOfSub sub parts parameters |

	main := aString copyUpTo: $/.
	endOfSub := aString indexOf: $;.
	endOfSub := endOfSub = 0 ifTrue: [aString size] ifFalse: [endOfSub - 1].
	sub := aString copyFrom: main size + 2 to: endOfSub.
	endOfSub = aString size ifTrue: [^self main: main sub: sub].
	parts := (aString copyFrom: endOfSub + 1 to: aString size) subStrings: ';'.
	parameters := Dictionary new.
	parts
		do: [:each | parameters at: (each copyUpTo: $=) trimBoth put: (each copyAfter: $=) trimBoth].
	^self main: main sub: sub parameters: parameters
]

{ #category : 'initiliziation' }
ZnMimeType class >> initializeTextSubTypeFragments [

	TextSubTypeFragments := #('javascript' 'json' 'ston' 'html' 'xml' 'sgml' 'yaml' 'csv') asSet
]

{ #category : 'instance creation' }
ZnMimeType class >> main: aMainString sub: aSubString [

	^self new
		main: aMainString;
		sub: aSubString;
		yourself
]

{ #category : 'instance creation' }
ZnMimeType class >> main: aMainString sub: aSubstring parameters: aDictionary [

	^(self main: aMainString sub: aSubstring)
		parameters: aDictionary;
		yourself
]

{ #category : 'initiliziation' }
ZnMimeType class >> textSubTypeFragments [
	"Return a set of fragments of sub types that indicate for any main type
	that the mime type is non-binary (thus textual)"

	TextSubTypeFragments ifNil: [self initializeTextSubTypeFragments].
	^TextSubTypeFragments
]

{ #category : 'accessing' }
ZnMimeType >> isBinary [
	"Answers whether the contents of a resource described by me 
	should be considered as binary instead of textual."

	self main = 'text' ifTrue: [^false].
	^(self sub subStrings: '+-')
		noneSatisfy: [:each | self class textSubTypeFragments includes: each]
]

{ #category : 'accessing' }
ZnMimeType >> main [

	^main
]

{ #category : 'accessing' }
ZnMimeType >> main: aString [

	main := aString asLowercase
]

{ #category : 'testing' }
ZnMimeType >> matches: aMimeType [
	"Compare the receiver to aMimeType, which is the pattern to match, 
	it is a normal instance where main or sub can be wildcards.
	Matches should be used instead of #= to ignore parameters."

	^(aMimeType main = '*' or: [aMimeType main = self main])
		and: [aMimeType sub = '*' or: [aMimeType sub = self sub]]
]

{ #category : 'accessing' }
ZnMimeType >> parameters [

	^parameters
]

{ #category : 'accessing' }
ZnMimeType >> parameters: aDictionary [

	parameters := aDictionary
]

{ #category : 'printing' }
ZnMimeType >> printOn: stream [

	stream
		nextPutAll: self main;
		nextPut: $/;
		nextPutAll: self sub.
	parameters isNil
		ifFalse: [
			parameters keysAndValuesDo: [:key :value |
				stream
					nextPut: $;;
					nextPutAll: key;
					nextPut: $=;
					nextPutAll: value]]
]

{ #category : 'accessing' }
ZnMimeType >> sub [

	^sub
]

{ #category : 'accessing' }
ZnMimeType >> sub: aString [

	sub := aString asLowercase
]
