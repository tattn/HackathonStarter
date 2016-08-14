# HackathonStarter
Hackathon starter kit for iOS

## Installation

```bash
git clone https://github.com/tattn/HackathonStarter hack
cd hack
./tool/setup.sh
```

Edit Cartfile, and run the following:

```bash
carthage bootstrap --platform iOS
```

if you use CocoaPods, run the following:
```bash
bundle exec pod init
vi Podfile
bundle exec pod install
```
