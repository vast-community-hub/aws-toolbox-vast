| loader path |
path := ((CfsPath named: CfsDirectoryDescriptor getcwd) append: '..\tonel-repos\aws-toolbox-vast').
loader := TonelLoader readFromPath: path.
loader
	beUnattended;
	useGitVersion.
loader loadAllMapsWithRequiredMaps.
