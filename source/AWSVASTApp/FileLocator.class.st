Class {
	#name : 'FileLocator',
	#superclass : 'Object',
	#instVars : [
		'path'
	],
	#category : 'AWSVASTApp'
}

{ #category : 'instance creation' }
FileLocator class >> home [

	| home |

	(home := 'HOME' abtScanEnv) isEmpty ifTrue: [home := 'USERPROFILE' abtScanEnv].

	^self newFrom: home
]

{ #category : 'instance creation' }
FileLocator class >> newFrom: aFileNameOrPath [

	^self new path: aFileNameOrPath
]

{ #category : 'actions' }
FileLocator >> / aString [

	^self class newFrom: ((CfsPath named: self path) append: aString) asString
]

{ #category : 'accessing' }
FileLocator >> contents [

	^GRPlatform current contentsOfFile: self path binary: false
]

{ #category : 'testing' }
FileLocator >> exists [

	^GRPlatform current fileExists: self path
]

{ #category : 'accessing' }
FileLocator >> path [

	^path
]

{ #category : 'accessing' }
FileLocator >> path: aString [

	path := aString
]

{ #category : 'actions' }
FileLocator >> resolve [

	^self
]
