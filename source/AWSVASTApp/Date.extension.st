Extension {
	#name : 'Date'
}

{ #category : '*AWSVASTApp',
 #vaCategories : ['printing'] }
Date >> compactPrintOn: aStream [

	self year printOn: aStream.

	self monthIndex printOn: aStream padTo: 2.

	self dayOfMonth printOn: aStream padTo: 2
]

{ #category : '*AWSVASTApp',
 #vaCategories : ['printing'] }
Date >> compactString [

	| writeStream |

	self compactPrintOn: (writeStream := WriteStream on: (self stringClass new: 10)).

	^writeStream contents asReducedString
]

{ #category : '*AWSVASTApp',
 #vaCategories : ['printing'] }
Date >> printFormat: anArray [

	(anArray = #(3 2 1 0 1 1 2)) ifTrue: [^self compactString].
	^self error: 'Shortcut implementation failed'
]
