Extension {
	#name : 'Date'
}

{ #category : 'printing' }
Date >> compactPrintOn: aStream [

	self year printOn: aStream.

	self monthIndex printOn: aStream padTo: 2.

	self dayOfMonth printOn: aStream padTo: 2
]

{ #category : 'printing' }
Date >> compactString [

	| writeStream |

	writeStream := WriteStream on: (Locale current preferredStringClass new: 10).

	self compactPrintOn: writeStream.

	^writeStream contents asReducedString
]

{ #category : 'printing' }
Date >> printFormat: anArray [

	(anArray = #(3 2 1 0 1 1 2)) ifTrue: [^self compactString].

	^self error: 'Shortcut implementation failed'
]
