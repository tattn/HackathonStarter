HackathonStarter
===

![Platform](https://img.shields.io/badge/platform-iOS-yellow.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)
[![Swift Version](https://img.shields.io/badge/Swift-3-F16D39.svg)](https://developer.apple.com/swift)

Hackathon starter kit for iOS.

## Installation

```bash
git clone https://github.com/tattn/HackathonStarter hack
cd hack
./tool/setup.sh
```

Edit Cartfile, and run the following:

```bash
carthage bootstrap --platform iOS --cache-builds
```

if you use CocoaPods, run the following:
```bash
bundle exec pod init
vi Podfile
bundle exec pod install
```


# License

HackathonStarter is released under the MIT license. See LICENSE for details.
