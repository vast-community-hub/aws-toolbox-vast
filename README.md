<p align="center">
<!---<img src="assets/logos/128x128.png">-->
 <h1 align="center">AWS Support for VASmalltalk</h1>
  <p align="center">
    AWS Support for VASmalltalk
    <!---
    <br>
    <a href="docs/"><strong>Explore the docs »</strong></a>
    <br>
    -->
    <br>
    <a href="https://github.com/vast-community-hub/aws-toolbox-vast/issues/new?labels=Type%3A+Defect">Report a defect</a>
    |
    <a href="https://github.com/vast-community-hub/aws-toolbox-vast/issues/new?labels=Type%3A+Feature">Request feature</a>
  </p>
</p>

Support library for using AWS from VA Smalltalk and for creating Lambda functions written in Smalltalk

## License
- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).


## Installation

1. Install [VA Smalltalk 9.2.1 or newer](https://www.instantiations.com/products/vasmalltalk/download.html).
2. Install Tonel support in your development image following [this guide](https://github.com/vasmalltalk/tonel-vast#installation).
3. Clone this repository.
4. Load the Configuration Map `AWS` (and optionally `AWS Tests` if you want to run the unit tests) either from the context menu of the Configuration Maps Browser ("*Import*" -> "*Load Configuration Maps from Tonel repository...*" -> select path to root `aws-toolbox-vast` local repo) or via a script:
```smalltalk
| loader path |
path := (CfsPath named: '<insert path to root aws-toolbox-vast local repo here>').
loader := TonelLoader readFromPath: path.
loader
	beUnattended.
	useGitVersion.
loader loadAllMapsWithRequiredMaps.
```
5. (optional) Run SUnit for all `AWS Tests` map to ensure correct installation.


## Contributing

Check the [Contribution Guidelines](CONTRIBUTING.md)
