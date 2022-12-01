Package {
	#name : 'AWSSecurityTokenServiceApp',
	#vaPrerequisites : ['AWSCoreApp'],
	#vaSubApplications : [
	{
		#condition : 'true',
		#subapps : [
			'AWSSecurityTokenServiceIdentityProvider'
		]
	}
]
}
