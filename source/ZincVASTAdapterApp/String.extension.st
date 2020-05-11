Extension {
	#name : 'String'
}

{ #category : '*ZincVASTAdapterApp',
 #vaCategories : ['Zinc-adding'] }
String >> addedToZnUrl: url [

	| segments |

	segments := self subStrings: $/.
	^url withPathSegments: segments
]

{ #category : '*ZincVASTAdapterApp',
 #vaCategories : ['Zinc-converting'] }
String >> asUrl [

	^self asZnUrl
]

{ #category : '*ZincVASTAdapterApp',
 #vaCategories : ['Zinc-converting'] }
String >> asZnMimeType [

	^ZnMimeType fromString: self
]

{ #category : '*ZincVASTAdapterApp',
 #vaCategories : ['Zinc-converting'] }
String >> asZnUrl [

	^ZnUrl fromString: self
]

{ #category : '*ZincVASTAdapterApp',
 #vaCategories : ['Zinc-sorting'] }
String >> caseSensitiveSortsBefore: aString [

	| min |

	min := self size min: aString size.

	1 to: min do: [:i | ((self at: i) value > (aString at: i) value) ifTrue: [^false]].

	^self size <= aString size
]

{ #category : '*ZincVASTAdapterApp',
 #vaCategories : ['Zinc-encoding-decoding'] }
String >> urlEncoded [
	"URL Encode the receiver and return the resulting String.
	This is an encoding where characters that are illegal in a URL are escaped."

	^self sstUrlEncode
]

{ #category : '*ZincVASTAdapterApp',
 #vaCategories : ['Zinc-converting'] }
String >> withoutQuoting [
	"remove the initial and final quote marks (single quote for string, or double quotes for comments), if present (and if matches nesting quotes). Have a look at testWithoutQuoting. If you want to remove single/double quotes not in first and last positions of the strings, have a look at copyWithout: $' "
	"'''h''' withoutQuoting >>> 'h'"
	"' ''h'' ' withoutQuoting >>>  ' ''h'' '"

	| quote |

	self size < 2 ifTrue: [^self].
	quote := self first.
	(quote = self last and: [quote = $' or: [quote = $"]])
		ifTrue: [^self copyFrom: 2 to: self size - 1]
		ifFalse: [^self]
]
