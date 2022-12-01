Extension {
	#name : 'SstHttpResponseHeader'
}

{ #category : 'Zinc-accessing' }
SstHttpResponseHeader >> znMimeType [

	^self contentType ifNotNil: [:string | ZnMimeType fromString: string]
]
