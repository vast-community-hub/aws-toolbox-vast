Extension {
	#name : 'SstHttpResponseHeader'
}

{ #category : '*ZincVASTAdapterApp',
 #vaCategories : ['Zinc-accessing'] }
SstHttpResponseHeader >> znMimeType [

	^self contentType ifNotNil: [:string | ZnMimeType fromString: string]
]
