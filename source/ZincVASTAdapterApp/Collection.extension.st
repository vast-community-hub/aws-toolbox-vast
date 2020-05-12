Extension {
	#name : 'Collection'
}

{ #category : '*ZincVASTAdapterApp',
 #vaCategories : ['Zinc-accessing'] }
Collection >> addedToZnUrl: url [

	^url withPathSegments: self
]
