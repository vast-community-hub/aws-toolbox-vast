Package {
	#name : 'AWSCoreApp',
	#vaPrerequisites : ['AWSVASTApp','EmImageSupport','NeoJSONCoreApp'],
	#vaSubApplications : [
	{
		#condition : 'true',
		#subapps : [
			'AWSCoreAuth',
			'AWSCoreExceptions'
		]
	}
]
}
