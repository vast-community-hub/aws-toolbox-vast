| loader path |
path := (CfsPath named: '<insert path to root aws-toolbox-vast local repo here>').
loader := TonelLoader readFromPath: path.
loader
	beUnattended;
	useGitVersion.
loader loadAllMapsWithRequiredMaps.
