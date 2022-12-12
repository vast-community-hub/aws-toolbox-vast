"Script to export in the format used at the vast-community-hub"

(writer := TonelWriter new) beVASTOnly.
writer addLatestConfigurationMapNamed: 'AWS'.
writer addLatestConfigurationMapNamed: 'AWS Tests'.
writer addApplicationsFromConfigurationMaps.
writer writeProjectInto: '<insert path to root aws-toolbox-vast local repo here>' asPath