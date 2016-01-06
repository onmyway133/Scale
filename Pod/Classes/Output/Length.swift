//
//  Length.swift
//  Pods
//
//  Created by Khoa Pham on 1/6/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public enum LengthUnit: Double {
    case millimeter = 0.001
    case centimeter = 0.01
    case decimeter = 0.1
    case meter = 1
    case dekameter = 10
    case hectometer = 100
    case kilometer = 1000

    static var defaultScale: Double {
        return LengthUnit.meter.rawValue
    }
}

public struct Length {
    let value: Double
    let unit: LengthUnit

    public init(value: Double, unit: LengthUnit) {
        self.value = value
        self.unit = unit
    }
}

extension Double {
    public var millimeter: Length {
        return Length(value: self, unit: .millimeter)
    }

    public var centimeter: Length {
        return Length(value: self, unit: .centimeter)
    }

    public var decimeter: Length {
        return Length(value: self, unit: .decimeter)
    }

    public var meter: Length {
        return Length(value: self, unit: .meter)
    }

    public var dekameter: Length {
        return Length(value: self, unit: .dekameter)
    }

    public var hectometer: Length {
        return Length(value: self, unit: .hectometer)
    }

    public var kilometer: Length {
        return Length(value: self, unit: .kilometer)
    }
}

public func compute(left: Length, right: Length, operation: (Double, Double) -> Double) -> Length {
    let (min, max) = left.unit.rawValue < right.unit.rawValue ? (left, right) : (right, left)
    let result = operation(min.value, max.value * LengthUnit.defaultScale * min.unit.rawValue)

    return Length(value: result, unit: min.unit)
}

public func +(left: Length, right: Length) -> Length {
    return compute(left, right: right, operation: +)
}

public func -(left: Length, right: Length) -> Length {
    return compute(left, right: right, operation: -)
}

public func *(left: Length, right: Length) -> Length {
    return compute(left, right: right, operation: *)
}

public func /(left: Length, right: Length) throws -> Length {
    guard right.value != 0 else {
        throw Error.DividedByZero
    }

    return compute(left, right: right, operation: /)
}