Extension {
	#name : 'SstError'
}

{ #category : '*ZincVASTAdapterApp',
 #vaCategories : ['Zn-Accessing'] }
SstError >> code [

	(self errorCode = 153) ifFalse: [^self error: 'No error 153'].

	^self errorObject header responseCode asNumber
]
