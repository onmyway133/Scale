//
//  Power.swift
//  Scale
//
//  Created by Khoa Pham
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public enum PowerUnit: Double {
    case milliwatt = 0.001
    case watt = 1
    case kilowatt = 1_000
    case megawatt = 1_000_000
    case gigawatt = 1_000_000_000
    case horsepower = 745.699_871_582_3

    static var defaultScale: Double {
        return PowerUnit.watt.rawValue
    }
}

public struct Power {
    public let value: Double
    public let unit: PowerUnit

    public init(value: Double, unit: PowerUnit) {
        self.value = value
        self.unit = unit
    }

    public func to(unit: PowerUnit) -> Power {
        return Power(value: self.value * self.unit.rawValue * PowerUnit.watt.rawValue / unit.rawValue, unit: unit)
    }
}

public extension Double {
    public var milliwatt: Power {
        return Power(value: self, unit: .milliwatt)
    }

    public var watt: Power {
        return Power(value: self, unit: .watt)
    }

    public var kilowatt: Power {
        return Power(value: self, unit: .kilowatt)
    }

    public var megawatt: Power {
        return Power(value: self, unit: .megawatt)
    }

    public var gigawatt: Power {
        return Power(value: self, unit: .gigawatt)
    }

    public var horsepower: Power {
        return Power(value: self, unit: .horsepower)
    }
}

public func compute(_ left: Power, right: Power, operation: (Double, Double) -> Double) -> Power {
    let (min, max) = left.unit.rawValue < right.unit.rawValue ? (left, right) : (right, left)
    let result = operation(min.value, max.to(unit: min.unit).value)

    return Power(value: result, unit: min.unit)
}

public func +(left: Power, right: Power) -> Power {
    return compute(left, right: right, operation: +)
}

public func -(left: Power, right: Power) -> Power {
    return compute(left, right: right, operation: -)
}

public func *(left: Power, right: Power) -> Power {
    return compute(left, right: right, operation: *)
}

public func /(left: Power, right: Power) throws -> Power {
    guard right.value != 0 else {
        throw ScaleError.dividedByZero
    }

    return compute(left, right: right, operation: /)
}
