Extension {
	#name : 'Collection'
}

{ #category : 'converting' }
Collection >> asDictionary [

	"Assumes the receiver is a collection of associations."

	| result |

	result := Dictionary new: self size.

	self do: [:ass | result at: ass key put: ass value].

	^result


]
