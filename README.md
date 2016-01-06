# Scale
Unit converter in Swift

[![CI Status](http://img.shields.io/travis/Khoa Pham/Scale.svg?style=flat)](https://travis-ci.org/Khoa Pham/Scale)
[![Version](https://img.shields.io/cocoapods/v/Scale.svg?style=flat)](http://cocoapods.org/pods/Scale)
[![License](https://img.shields.io/cocoapods/l/Scale.svg?style=flat)](http://cocoapods.org/pods/Scale)
[![Platform](https://img.shields.io/cocoapods/p/Scale.svg?style=flat)](http://cocoapods.org/pods/Scale)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Features

### Unit

- Strongly typed unit
- Operation upon same type, the result is the smaller unit of the two

```
let length = 5.kilometer + 7.meter  // 5007 meter
let weight = 10.0.kilogram * 5.gram // 50000 gram
```

- Convert to any unit of the same type

```
let dekameter = length.to(unit: .dekameter) // 500.7 dekameter
```

### Support

- Length
- Weight

## Add more

- Add `new_definition.def` inside `Definitions` group
- Run `Script.swift` inside `Script` group
- Add newly generated file into `Output` group
- Go into `Example` and `pod install`

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
