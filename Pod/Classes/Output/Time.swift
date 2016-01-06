//
//  Time.swift
//  Scale
//
//  Created by Khoa Pham
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public enum TimeUnit: Double {
    case nanosecond = 0.000000001
    case microsecond = 0.000001
    case millisecond = 0.001
    case centisecond = 0.01
    case second = 1
    case minute = 60
    case hour = 3600
    case day = 86400
    case week = 604800
    case fortnight = 1209600
    case month = 2629822.96584
    case year = 31536000
    case decade = 315360000
    case century = 3153600000
    case millennium = 31536000000

    static var defaultScale: Double {
        return TimeUnit.second.rawValue
    }
}

public struct Time {
    public let value: Double
    public let unit: TimeUnit

    public init(value: Double, unit: TimeUnit) {
        self.value = value
        self.unit = unit
    }

    public func to(unit unit: TimeUnit) -> Time {
        return Time(value: self.value * self.unit.rawValue * TimeUnit.second.rawValue / unit.rawValue, unit: unit)
    }
}

public extension Double {
    public var nanosecond: Time {
        return Time(value: self, unit: .nanosecond)
    }

    public var microsecond: Time {
        return Time(value: self, unit: .microsecond)
    }

    public var millisecond: Time {
        return Time(value: self, unit: .millisecond)
    }

    public var centisecond: Time {
        return Time(value: self, unit: .centisecond)
    }

    public var second: Time {
        return Time(value: self, unit: .second)
    }

    public var minute: Time {
        return Time(value: self, unit: .minute)
    }

    public var hour: Time {
        return Time(value: self, unit: .hour)
    }

    public var day: Time {
        return Time(value: self, unit: .day)
    }

    public var week: Time {
        return Time(value: self, unit: .week)
    }

    public var fortnight: Time {
        return Time(value: self, unit: .fortnight)
    }

    public var month: Time {
        return Time(value: self, unit: .month)
    }

    public var year: Time {
        return Time(value: self, unit: .year)
    }

    public var decade: Time {
        return Time(value: self, unit: .decade)
    }

    public var century: Time {
        return Time(value: self, unit: .century)
    }

    public var millennium: Time {
        return Time(value: self, unit: .millennium)
    }
}

public func compute(left: Time, right: Time, operation: (Double, Double) -> Double) -> Time {
    let (min, max) = left.unit.rawValue < right.unit.rawValue ? (left, right) : (right, left)
    let result = operation(min.value, max.to(unit: min.unit).value)

    return Time(value: result, unit: min.unit)
}

public func +(left: Time, right: Time) -> Time {
    return compute(left, right: right, operation: +)
}

public func -(left: Time, right: Time) -> Time {
    return compute(left, right: right, operation: -)
}

public func *(left: Time, right: Time) -> Time {
    return compute(left, right: right, operation: *)
}

public func /(left: Time, right: Time) throws -> Time {
    guard right.value != 0 else {
        throw Error.DividedByZero
    }

    return compute(left, right: right, operation: /)
}
