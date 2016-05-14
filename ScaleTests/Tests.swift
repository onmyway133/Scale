import UIKit
import XCTest
import Scale

class Tests: XCTestCase {
    func testOperation() {
        let angle = 5.degree + 2.radian
        XCTAssert(angle.unit == AngleUnit.degree)
        XCTAssertEqualWithAccuracy(angle.value, 119.591559, accuracy: 1)

        let area = 5.acre + 2.hectare
        XCTAssert(area.unit == AreaUnit.acre)
        XCTAssertEqualWithAccuracy(area.value, 9.94210763, accuracy: 1)

        let energy = 5.joule + 2.watthour
        XCTAssert(energy.unit == EnergyUnit.joule)
        XCTAssertEqualWithAccuracy(energy.value, 7205, accuracy: 0)

        let metric = 5.base + 2.kilo
        XCTAssert(metric.unit == MetricUnit.base)
        XCTAssertEqualWithAccuracy(metric.value, 2005, accuracy: 0)

        let volume = 5.liter + 2.gallon
        XCTAssert(volume.unit == VolumeUnit.liter)
        XCTAssertEqualWithAccuracy(volume.value, 12.5708236, accuracy: 1)

        let temperature = 5.fahrenheit + 2.celsius
        XCTAssert(temperature.unit == TemperatureUnit.fahrenheit)
        XCTAssertEqualWithAccuracy(temperature.value, 40.6, accuracy: 0.001)

        let time = 5.day + 2.hour
        XCTAssert(time.unit == TimeUnit.hour)
        XCTAssertEqualWithAccuracy(time.value, 122, accuracy: 0)

        let length = 5.yard + 2.meter
        XCTAssert(length.unit == LengthUnit.yard)
        XCTAssertEqualWithAccuracy(length.value, 7.1872266, accuracy: 1)

        let weight = 5.kilogram + 2.pound
        XCTAssert(weight.unit == WeightUnit.pound)
        XCTAssertEqualWithAccuracy(weight.value, 13.0231131, accuracy: 1)
    }

    func testConverting() {
        XCTAssertEqualWithAccuracy(2.hour.to(unit: .week).value, 0.0119048, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(2.week.to(unit: .hour).value, 336, accuracy: 0)
    }

    func testTemperature() {
        XCTAssertEqualWithAccuracy(20.celsius.to(unit: .fahrenheit).value, 68, accuracy: 0)
        XCTAssertEqualWithAccuracy(10.celsius.to(unit: .kelvin).value, 283.15, accuracy: 0)
        XCTAssertEqualWithAccuracy(68.fahrenheit.to(unit: .celsius).value, 20, accuracy: 0)
        XCTAssertEqualWithAccuracy(60.fahrenheit.to(unit: .kelvin).value, 288.71, accuracy: 0.1)
        XCTAssertEqualWithAccuracy(300.kelvin.to(unit: .celsius).value, 26.85, accuracy: 0.1)
        XCTAssertEqualWithAccuracy(300.kelvin.to(unit: .fahrenheit).value, 80.33, accuracy: 0.1)
        XCTAssertEqualWithAccuracy(20.celsius.to(unit: .celsius).value, 20, accuracy: 0)
    }
}
