# Scale
Unit converter in Swift

[![CI Status](http://img.shields.io/travis/Khoa Pham/Scale.svg?style=flat)](https://travis-ci.org/Khoa Pham/Scale)
[![Version](https://img.shields.io/cocoapods/v/Scale.svg?style=flat)](http://cocoapods.org/pods/Scale)
[![License](https://img.shields.io/cocoapods/l/Scale.svg?style=flat)](http://cocoapods.org/pods/Scale)
[![Platform](https://img.shields.io/cocoapods/p/Scale.svg?style=flat)](http://cocoapods.org/pods/Scale)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

![](Screenshots/Banner.png)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Features

### Unit

- Strongly typed unit
- Division may throw error
- Operation upon same type, the result is the smaller unit of the two

```swift
let length = 5.kilometer + 7.meter  // 5007 meter
let weight = 10.0.kilogram * 5.gram // 50000 gram
```

- Convert to any unit of the same type

```swift
2.week.to(unit: .hour) // 336 hour
```

### Support

- Angle
```swift
let angle = 5.degree + 2.radian
```

- Area
```swift
let area = 5.acre + 2.hectare
```

- Energy
```swift
let energy = 5.joule + 2.watthour
```

- Metric
```swift
let metric = 5.base + 2.kilo
```

- Volume
```swift
let volume = 5.liter + 2.gallon
```

- Temperature
```swift
let temperature = 5.fahrenheit + 2.celsius
```

- Time
```swift
let time = 5.day + 2.hour
```

- Length
```swift
let length = 5.yard + 2.meter
```

- Weight
```swift
let weight = 5.kilogram + 2.pound
```

### Add more

- Add new definition file with extension `.def` inside `Definitions` group
- Run `xcrun swift Script.swift` inside `Script` group
- Add newly generated files into `Output` group, target Scale
- Go into `Example` and `pod install`

## Notes

Some unit types like `Temperature` must be converted manually

## Installation

Scale is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Scale"
```

## Author

Khoa Pham, onmyway133@gmail.com

## License

Scale is available under the MIT license. See the LICENSE file for more info.
