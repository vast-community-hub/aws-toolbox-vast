"Script to export to the pharo-aws-toolbox (Pharo format)"

"Not tested"
(writer := TonelWriter new) beCanonical.
writer addLatestConfigurationMapNamed: 'AWS'.
writer addLatestConfigurationMapNamed: 'AWS Tests'.
writer addApplicationsFromConfigurationMaps.
writer writeProjectInto: '<insert path to root pharo-aws-toolbox local repo here>' asPath