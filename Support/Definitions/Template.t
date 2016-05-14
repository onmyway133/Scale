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

    public func to(unit unit: <<UnitName>>) -> <<Name>> {
        return <<Name>>(value: self.value * self.unit.rawValue * <<UnitName>>.<<DefaultScale>>.rawValue / unit.rawValue, unit: unit)
    }
}

public extension Double {
<<Units>>
}

public func compute(left: <<Name>>, right: <<Name>>, operation: (Double, Double) -> Double) -> <<Name>> {
    let (min, max) = left.unit.rawValue < right.unit.rawValue ? (left, right) : (right, left)
    let result = operation(min.value, max.to(unit: min.unit).value)

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
