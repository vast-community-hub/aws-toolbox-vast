Extension {
	#name : 'DateAndTime'
}

{ #category : 'instance creation' }
DateAndTime class >> fromString: aString [

	^self abtXmlFromString: aString
]

{ #category : 'instance creation' }
DateAndTime class >> unixEpoch [

	^self year: 1970 month: 1 day: 1 hour: 0 minute: 0 second: 0 timeZone: 'UTC'
]

{ #category : 'accessing' }
DateAndTime >> hours [

	^self time hours
]

{ #category : 'accessing' }
DateAndTime >> minutes [

	^self time minutes
]

{ #category : 'accessing' }
DateAndTime >> seconds [

	^self time seconds
]
