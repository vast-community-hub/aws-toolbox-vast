Extension {
	#name : 'Collection'
}

{ #category : 'Zinc-accessing' }
Collection >> addedToZnUrl: url [

	^url withPathSegments: self
]
