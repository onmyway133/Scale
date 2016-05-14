//
//  Volume.swift
//  Scale
//
//  Created by Khoa Pham
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public enum VolumeUnit: Double {
    case microliter = 0.000_001
    case milliliter = 0.001
    case centiliter = 0.01
    case liter = 1
    case dekaliter = 10
    case hectoliter = 100
    case kiloliter = 1_000
    case gill = 0.118_294_118_25
    case gallon = 3.785_41
    case pint = 0.473_176_473
    case quart = 1.136_522_5

    static var defaultScale: Double {
        return VolumeUnit.liter.rawValue
    }
}

public struct Volume {
    public let value: Double
    public let unit: VolumeUnit

    public init(value: Double, unit: VolumeUnit) {
        self.value = value
        self.unit = unit
    }

    public func to(unit unit: VolumeUnit) -> Volume {
        return Volume(value: self.value * self.unit.rawValue * VolumeUnit.liter.rawValue / unit.rawValue, unit: unit)
    }
}

public extension Double {
    public var microliter: Volume {
        return Volume(value: self, unit: .microliter)
    }

    public var milliliter: Volume {
        return Volume(value: self, unit: .milliliter)
    }

    public var centiliter: Volume {
        return Volume(value: self, unit: .centiliter)
    }

    public var liter: Volume {
        return Volume(value: self, unit: .liter)
    }

    public var dekaliter: Volume {
        return Volume(value: self, unit: .dekaliter)
    }

    public var hectoliter: Volume {
        return Volume(value: self, unit: .hectoliter)
    }

    public var kiloliter: Volume {
        return Volume(value: self, unit: .kiloliter)
    }

    public var gill: Volume {
        return Volume(value: self, unit: .gill)
    }

    public var gallon: Volume {
        return Volume(value: self, unit: .gallon)
    }

    public var pint: Volume {
        return Volume(value: self, unit: .pint)
    }

    public var quart: Volume {
        return Volume(value: self, unit: .quart)
    }
}

public func compute(left: Volume, right: Volume, operation: (Double, Double) -> Double) -> Volume {
    let (min, max) = left.unit.rawValue < right.unit.rawValue ? (left, right) : (right, left)
    let result = operation(min.value, max.to(unit: min.unit).value)

    return Volume(value: result, unit: min.unit)
}

public func +(left: Volume, right: Volume) -> Volume {
    return compute(left, right: right, operation: +)
}

public func -(left: Volume, right: Volume) -> Volume {
    return compute(left, right: right, operation: -)
}

public func *(left: Volume, right: Volume) -> Volume {
    return compute(left, right: right, operation: *)
}

public func /(left: Volume, right: Volume) throws -> Volume {
    guard right.value != 0 else {
        throw Error.DividedByZero
    }

    return compute(left, right: right, operation: /)
}
