| writer path |
path := ((CfsPath named: CfsDirectoryDescriptor getcwd) append: '..\tonel-repos\aws-toolbox-vast').
writer := TonelWriter new.
writer
	addLatestConfigurationMapNamed: 'AWS';
	addLatestConfigurationMapNamed: 'AWS Tests';
	addApplicationsFromConfigurationMaps.
writer writeProjectInto: path.
