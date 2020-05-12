Class {
	#name : 'AWSInvalidSequenceTokenException',
	#superclass : 'AWSError',
	#category : 'AWSCoreExceptions'
}

{ #category : 'acccessing' }
AWSInvalidSequenceTokenException >> expectedSequenceToken [

	^self data at: 'expectedSequenceToken' ifAbsent: [nil]
]
