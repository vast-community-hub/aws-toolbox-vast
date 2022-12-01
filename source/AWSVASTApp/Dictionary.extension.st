Extension {
	#name : 'Dictionary'
}

{ #category : 'actions' }
Dictionary >> headersDo: aBlock [
	"Execute a two argument (key, value) block for each header.
	Multi-valued headers are handled transparently."

	self isEmpty ifTrue: [^self].
	self keysAndValuesDo: [:headerKey :headerValue |
		headerValue isArray
			ifTrue: [headerValue do: [:each | aBlock value: headerKey value: each]]
			ifFalse: [aBlock value: headerKey value: headerValue]]
]
