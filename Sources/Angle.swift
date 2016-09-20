//
//  Angle.swift
//  Scale
//
//  Created by Khoa Pham
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public enum AngleUnit: Double {
    case degree = 1
    case radian = 57.295_8
    case pi = 180

    static var defaultScale: Double {
        return AngleUnit.degree.rawValue
    }
}

public struct Angle {
    public let value: Double
    public let unit: AngleUnit

    public init(value: Double, unit: AngleUnit) {
        self.value = value
        self.unit = unit
    }

    public func to(unit: AngleUnit) -> Angle {
        return Angle(value: self.value * self.unit.rawValue * AngleUnit.degree.rawValue / unit.rawValue, unit: unit)
    }
}

public extension Double {
    public var degree: Angle {
        return Angle(value: self, unit: .degree)
    }

    public var radian: Angle {
        return Angle(value: self, unit: .radian)
    }

    public var pi: Angle {
        return Angle(value: self, unit: .pi)
    }
}

public func compute(_ left: Angle, right: Angle, operation: (Double, Double) -> Double) -> Angle {
    let (min, max) = left.unit.rawValue < right.unit.rawValue ? (left, right) : (right, left)
    let result = operation(min.value, max.to(unit: min.unit).value)

    return Angle(value: result, unit: min.unit)
}

public func +(left: Angle, right: Angle) -> Angle {
    return compute(left, right: right, operation: +)
}

public func -(left: Angle, right: Angle) -> Angle {
    return compute(left, right: right, operation: -)
}

public func *(left: Angle, right: Angle) -> Angle {
    return compute(left, right: right, operation: *)
}

public func /(left: Angle, right: Angle) throws -> Angle {
    guard right.value != 0 else {
        throw ScaleError.dividedByZero
    }

    return compute(left, right: right, operation: /)
}
