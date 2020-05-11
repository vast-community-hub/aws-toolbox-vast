Package {
	#name : 'AWSCoreApp',
	#vaPrerequisites : ['AWSVASTApp','NeoJSONCoreApp'],
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
