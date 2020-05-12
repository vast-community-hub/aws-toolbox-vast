Class {
	#name : 'OSEnvironment',
	#superclass : 'Object',
	#category : 'AWSVASTApp'
}

{ #category : 'instance creation' }
OSEnvironment class >> current [
	"Should return OS Specific class, but this is delegated in the instance methods for now"

	^self new
]

{ #category : 'accessing' }
OSEnvironment >> at: aString [

	^self at: aString ifAbsent: [nil]
]

{ #category : 'accessing' }
OSEnvironment >> at: aString ifAbsent: aBlock [
	"Needs to return the environment variable"

	^aString abtScanEnv ifEmpty: [aBlock value]
]
