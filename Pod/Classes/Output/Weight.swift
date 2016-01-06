//
//  Weight.swift
//  Scale
//
//  Created by Khoa Pham
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public enum WeightUnit: Double {
    case milligram = 0.001
    case centigram = 0.01
    case decigram = 0.1
    case gram = 1
    case dekagram = 10
    case hectogram = 100
    case kilogram = 1000
    case metricTon = 1000000

    static var defaultScale: Double {
        return WeightUnit.gram.rawValue
    }
}

public struct Weight {
    public let value: Double
    public let unit: WeightUnit

    public init(value: Double, unit: WeightUnit) {
        self.value = value
        self.unit = unit
    }
}

extension Double {
    public var milligram: Weight {
        return Weight(value: self, unit: .milligram)
    }

    public var centigram: Weight {
        return Weight(value: self, unit: .centigram)
    }

    public var decigram: Weight {
        return Weight(value: self, unit: .decigram)
    }

    public var gram: Weight {
        return Weight(value: self, unit: .gram)
    }

    public var dekagram: Weight {
        return Weight(value: self, unit: .dekagram)
    }

    public var hectogram: Weight {
        return Weight(value: self, unit: .hectogram)
    }

    public var kilogram: Weight {
        return Weight(value: self, unit: .kilogram)
    }

    public var metricTon: Weight {
        return Weight(value: self, unit: .metricTon)
    }
}

public func compute(left: Weight, right: Weight, operation: (Double, Double) -> Double) -> Weight {
    let (min, max) = left.unit.rawValue < right.unit.rawValue ? (left, right) : (right, left)
    let result = operation(min.value, max.value * WeightUnit.gram.rawValue * min.unit.rawValue)

    return Weight(value: result, unit: min.unit)
}

public func +(left: Weight, right: Weight) -> Weight {
    return compute(left, right: right, operation: +)
}

public func -(left: Weight, right: Weight) -> Weight {
    return compute(left, right: right, operation: -)
}

public func *(left: Weight, right: Weight) -> Weight {
    return compute(left, right: right, operation: *)
}

public func /(left: Weight, right: Weight) throws -> Weight {
    guard right.value != 0 else {
        throw Error.DividedByZero
    }

    return compute(left, right: right, operation: /)
}
