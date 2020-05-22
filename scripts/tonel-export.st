| writer path |
path := (CfsPath named: '<insert path to root aws-toolbox-vast local repo here>').
writer := TonelWriter new.
writer
	addLatestConfigurationMapNamed: 'AWS';
	addLatestConfigurationMapNamed: 'AWS Tests';
	addApplicationsFromConfigurationMaps.
writer writeProjectInto: path.
