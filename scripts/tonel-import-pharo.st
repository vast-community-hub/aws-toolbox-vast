"Script to import from the pharo-aws-toolbox (Pharo format)"

path := (CfsPath named: '<insert path to root pharo-aws-toolbox local repo here>').
loader := TonelLoader readFromPath: path.
loader
    beUnattended;
    doNotCreateVersions;
    mapTagsToSubapplications;
    resolveToLatestConfigMaps.
loader namingStrategy appSuffix: 'App'.

loader loadApplicationForPackageNamed: 'AWS-Core'.
loader loadApplicationForPackageNamed: 'AWS-Core-Tests'.
loader loadApplicationForPackageNamed: 'AWS-EC2InstanceMetadata'.
loader loadApplicationForPackageNamed: 'AWS-SecurityTokenService'.
loader loadApplicationForPackageNamed: 'AWS-SecurityTokenService-Tests'.
loader loadApplicationForPackageNamed: 'AWS-SimpleStorageService'.
loader loadApplicationForPackageNamed: 'AWS-SimpleStorageService-Tests'.