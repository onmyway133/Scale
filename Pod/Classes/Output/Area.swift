//
//  Area.swift
//  Scale
//
//  Created by Khoa Pham
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public enum AreaUnit: Double {
    case squareFoot = 0.092903
    case squareYard = 0.836127
    case squareMeter = 1
    case squareKilometer = 1000000
    case squareMile = 2589988.11
    case acre = 4046.86
    case hectare = 10000

    static var defaultScale: Double {
        return AreaUnit.squareMeter.rawValue
    }
}

public struct Area {
    public let value: Double
    public let unit: AreaUnit

    public init(value: Double, unit: AreaUnit) {
        self.value = value
        self.unit = unit
    }

    public func to(unit unit: AreaUnit) -> Area {
        return Area(value: self.value * self.unit.rawValue * AreaUnit.squareMeter.rawValue / unit.rawValue, unit: unit)
    }
}

public extension Double {
    public var squareFoot: Area {
        return Area(value: self, unit: .squareFoot)
    }

    public var squareYard: Area {
        return Area(value: self, unit: .squareYard)
    }

    public var squareMeter: Area {
        return Area(value: self, unit: .squareMeter)
    }

    public var squareKilometer: Area {
        return Area(value: self, unit: .squareKilometer)
    }

    public var squareMile: Area {
        return Area(value: self, unit: .squareMile)
    }

    public var acre: Area {
        return Area(value: self, unit: .acre)
    }

    public var hectare: Area {
        return Area(value: self, unit: .hectare)
    }
}

public func compute(left: Area, right: Area, operation: (Double, Double) -> Double) -> Area {
    let (min, max) = left.unit.rawValue < right.unit.rawValue ? (left, right) : (right, left)
    let result = operation(min.value, max.to(unit: min.unit).value)

    return Area(value: result, unit: min.unit)
}

public func +(left: Area, right: Area) -> Area {
    return compute(left, right: right, operation: +)
}

public func -(left: Area, right: Area) -> Area {
    return compute(left, right: right, operation: -)
}

public func *(left: Area, right: Area) -> Area {
    return compute(left, right: right, operation: *)
}

public func /(left: Area, right: Area) throws -> Area {
    guard right.value != 0 else {
        throw Error.DividedByZero
    }

    return compute(left, right: right, operation: /)
}
