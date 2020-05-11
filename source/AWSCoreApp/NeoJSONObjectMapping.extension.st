Extension {
	#name : 'NeoJSONObjectMapping'
}

{ #category : '*AWSCoreApp',
 #vaCategories : ['AWS-Core'] }
NeoJSONObjectMapping >> mapInstVarCapitalized: instVarName [

	^self mapInstVar: instVarName to: instVarName capitalized
]

{ #category : '*AWSCoreApp',
 #vaCategories : ['AWS-Core'] }
NeoJSONObjectMapping >> mapInstVarsCapitalized: instVarNames [

	^instVarNames collect: [:each | self mapInstVarCapitalized: each]
]
