# MoonKit

[![GitHub release](https://img.shields.io/github/v/release/thejohnlima/MoonKit?style=for-the-badge)](https://github.com/thejohnlima/MoonKit/releases)
[![CI](https://img.shields.io/github/workflow/status/thejohnlima/MoonKit/CI/master?style=for-the-badge)](https://github.com/thejohnlima/MoonKit/actions)
[![CocoaPods](https://img.shields.io/badge/Cocoa%20Pods-✓-4BC51D.svg?style=for-the-badge)](https://cocoapods.org/pods/MoonKit)
[![GitHub repo size](https://img.shields.io/github/repo-size/thejohnlima/MoonKit.svg?style=for-the-badge)](https://github.com/thejohnlima/MoonKit)
[![License](https://img.shields.io/github/license/thejohnlima/MoonKit.svg?style=for-the-badge)](https://raw.githubusercontent.com/thejohnlima/MoonKit/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/MoonKit?style=for-the-badge)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5-blue.svg?style=for-the-badge)](https://developer.apple.com/swift/)

🌗 **MoonKit** Is a short framework to get information about the moon

## ❗️Requirements

- iOS 9.0+
- Swift 5.0+

## ⚒ Installation

### Swift Package Manager

**MoonKit** is available through [SPM](https://developer.apple.com/videos/play/wwdc2019/408/). To install
it, follow the steps:

```script
Open Xcode project > File > Swift Packages > Add Package Dependecy
```

After that, put the url in the field: `https://github.com/thejohnlima/MoonKit.git`

### CocoaPods

**MoonKit** is available through [CocoaPods](https://cocoapods.org/pods/MoonKit). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MoonKit'
```

and run `pod install`

## 🎓 How to use

Import library in your file:

```Swift
import MoonKit
```

```swift
let date = Date()
let moon = Moon(date)
let info = moon.info

print(info.phase) // Example: Full Moon
print(info.age) // Example: 15
```

## 🙋🏻‍ Communication

- If you found a bug, open an issue.
- If you have a feature request, open an issue.
- If you want to contribute, submit a pull request. 👨🏻‍💻

## 📜 License

**MoonKit** is under MIT license. See the [LICENSE](https://raw.githubusercontent.com/thejohnlima/MoonKit/master/LICENSE?token=ALdmBr7BYPLFm0JcKkmChbVeGU10EblTks5cgHzcwA%3D%3D) file for more info.
