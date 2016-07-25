//
//  Energy.swift
//  Scale
//
//  Created by Khoa Pham
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public enum EnergyUnit: Double {
    case joule = 1
    case kilojoule = 1_000
    case gramcalorie = 4.184
    case kilocalorie = 4_184
    case watthour = 3_600

    static var defaultScale: Double {
        return EnergyUnit.joule.rawValue
    }
}

public struct Energy {
    public let value: Double
    public let unit: EnergyUnit

    public init(value: Double, unit: EnergyUnit) {
        self.value = value
        self.unit = unit
    }

    public func to(unit: EnergyUnit) -> Energy {
        return Energy(value: self.value * self.unit.rawValue * EnergyUnit.joule.rawValue / unit.rawValue, unit: unit)
    }
}

public extension Double {
    public var joule: Energy {
        return Energy(value: self, unit: .joule)
    }

    public var kilojoule: Energy {
        return Energy(value: self, unit: .kilojoule)
    }

    public var gramcalorie: Energy {
        return Energy(value: self, unit: .gramcalorie)
    }

    public var kilocalorie: Energy {
        return Energy(value: self, unit: .kilocalorie)
    }

    public var watthour: Energy {
        return Energy(value: self, unit: .watthour)
    }
}

public func compute(_ left: Energy, right: Energy, operation: (Double, Double) -> Double) -> Energy {
    let (min, max) = left.unit.rawValue < right.unit.rawValue ? (left, right) : (right, left)
    let result = operation(min.value, max.to(unit: min.unit).value)

    return Energy(value: result, unit: min.unit)
}

public func +(left: Energy, right: Energy) -> Energy {
    return compute(left, right: right, operation: +)
}

public func -(left: Energy, right: Energy) -> Energy {
    return compute(left, right: right, operation: -)
}

public func *(left: Energy, right: Energy) -> Energy {
    return compute(left, right: right, operation: *)
}

public func /(left: Energy, right: Energy) throws -> Energy {
    guard right.value != 0 else {
        throw Error.dividedByZero
    }

    return compute(left, right: right, operation: /)
}
