Extension {
	#name : 'SstError'
}

{ #category : 'Zn-Accessing' }
SstError >> code [

	(self errorCode = 153) ifFalse: [^self errorCode].

	^self errorObject header responseCode asNumber
]
