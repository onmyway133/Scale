//
//  <<Name>>.swift
//  Scale
//
//  Created by Khoa Pham
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

<<Def>>

public struct <<Name>> {
    public let value: Double
    public let unit: <<UnitName>>

    public init(value: Double, unit: <<UnitName>>) {
        self.value = value
        self.unit = unit
    }
}

extension Double {
<<Units>>
}

public func compute(left: <<Name>>, right: <<Name>>, operation: (Double, Double) -> Double) -> <<Name>> {
    let (min, max) = left.unit.rawValue < right.unit.rawValue ? (left, right) : (right, left)
    let result = operation(min.value, max.value * <<UnitName>>.<<DefaultScale>>.rawValue * min.unit.rawValue)

    return <<Name>>(value: result, unit: min.unit)
}

public func +(left: <<Name>>, right: <<Name>>) -> <<Name>> {
    return compute(left, right: right, operation: +)
}

public func -(left: <<Name>>, right: <<Name>>) -> <<Name>> {
    return compute(left, right: right, operation: -)
}

public func *(left: <<Name>>, right: <<Name>>) -> <<Name>> {
    return compute(left, right: right, operation: *)
}

public func /(left: <<Name>>, right: <<Name>>) throws -> <<Name>> {
    guard right.value != 0 else {
        throw Error.DividedByZero
    }

    return compute(left, right: right, operation: /)
}
