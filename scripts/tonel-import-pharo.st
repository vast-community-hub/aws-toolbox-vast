"Script to import from the pharo-aws-toolbox (Pharo format)"

"While you do the unavoidable trial and error to get all
of the packages ported, it is recommended to not create
versions of the new apps (#doNotCreateVersions).
Once you have the 'recipe' working, you can remove that."

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

"After applying updates from Pharo you may want to delete
methods and classes from AWSVASTApp and ZincVASTAdapterApp
that are no longer used to keep things tidy."