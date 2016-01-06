//
//  Temperature.swift
//  Scale
//
//  Created by Khoa Pham
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public enum TemperatureUnit: Double {
    case kelvin = 1
    case celsius = 274.15
    case fahrenheit = 255.9277777778

    static var defaultScale: Double {
        return TemperatureUnit.kelvin.rawValue
    }
}

public struct Temperature {
    public let value: Double
    public let unit: TemperatureUnit

    public init(value: Double, unit: TemperatureUnit) {
        self.value = value
        self.unit = unit
    }

    public func to(unit unit: TemperatureUnit) -> Temperature {
        return Temperature(value: self.value * self.unit.rawValue * TemperatureUnit.kelvin.rawValue / unit.rawValue, unit: unit)
    }
}

public extension Double {
    public var kelvin: Temperature {
        return Temperature(value: self, unit: .kelvin)
    }

    public var celsius: Temperature {
        return Temperature(value: self, unit: .celsius)
    }

    public var fahrenheit: Temperature {
        return Temperature(value: self, unit: .fahrenheit)
    }
}

public func compute(left: Temperature, right: Temperature, operation: (Double, Double) -> Double) -> Temperature {
    let (min, max) = left.unit.rawValue < right.unit.rawValue ? (left, right) : (right, left)
    let result = operation(min.value, max.to(unit: min.unit).value)

    return Temperature(value: result, unit: min.unit)
}

public func +(left: Temperature, right: Temperature) -> Temperature {
    return compute(left, right: right, operation: +)
}

public func -(left: Temperature, right: Temperature) -> Temperature {
    return compute(left, right: right, operation: -)
}

public func *(left: Temperature, right: Temperature) -> Temperature {
    return compute(left, right: right, operation: *)
}

public func /(left: Temperature, right: Temperature) throws -> Temperature {
    guard right.value != 0 else {
        throw Error.DividedByZero
    }

    return compute(left, right: right, operation: /)
}
