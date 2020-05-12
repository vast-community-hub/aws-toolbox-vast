Class {
	#name : 'ZnResourceMetaUtils',
	#superclass : 'Object',
	#category : 'ZincVASTAdapterApp'
}

{ #category : 'encoding-decoding' }
ZnResourceMetaUtils class >> decodePercent: aString [

	^aString sstUrlDecode: false
]

{ #category : 'encoding-decoding' }
ZnResourceMetaUtils class >> decodePercentForQuery: aString [

	^aString sstUrlDecode: true
]

{ #category : 'encoding-decoding' }
ZnResourceMetaUtils class >> encodePercent: aString [


	^((GRCodec forEncoding: 'utf-8') encode: aString) sstUrlEncode


]

{ #category : 'streaming' }
ZnResourceMetaUtils class >> parseQueryFrom: stream [

	| string index fields |

	fields := ZnMultiValueDictionary new.
	[stream atEnd] whileFalse: [
		string := stream upTo: $&.
		index := string indexOf: $=.
		index > 0
			ifFalse: [fields at: (self decodePercentForQuery: string) put: nil]
			ifTrue: [
				fields
					at: (self decodePercentForQuery: (string copyFrom: 1 to: index - 1))
					add: (self decodePercentForQuery: (string copyFrom: index + 1 to: string size))]].
	^fields
]

{ #category : 'streaming' }
ZnResourceMetaUtils class >> writeQueryFields: aDictionary on: aStream [

	| first |

	first := true.
	aDictionary keysAndValuesDo: [:key :value |
		first ifFalse: [aStream nextPut: $&].
		first := false.
		aStream nextPutAll: (self encodePercent: key).
		value ifNotNil: [
			aStream
				nextPut: $=;
				nextPutAll: (self encodePercent: value)]]
]
