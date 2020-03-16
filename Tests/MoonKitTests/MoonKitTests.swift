//  MIT License
//
//  Copyright (c) 2020 John Lima
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import XCTest
@testable import MoonKit

final class MoonKitTests: XCTestCase {

  // MARK: - Properties
  static var allTests = [
    ("testMoonPhaseNew", testMoonPhaseNew),
  ]

  // MARK: - Private Methods
  private func getMoon(_ date: String) -> Moon {
    let date = date.toDate
    let moon = Moon(date)
    return moon
  }

  // MARK: - Tests
  func testMoonPhaseNew() {
    let moon = getMoon("02-25-2020 18:00")
    XCTAssertEqual(moon.info.phase, .newMoon)
  }

  func testMoonPhaseWaxingCrescent() {
    let moon = getMoon("01-31-2020 18:00")
    XCTAssertEqual(moon.info.phase, .waxingCrescent)
  }

  func testMoonPhaseFirstQuarter() {
    let moon = getMoon("02-1-2020 18:00")
    XCTAssertEqual(moon.info.phase, .firstQuarter)
  }

  func testMoonPhaseWaxingGibbous() {
    let moon = getMoon("03-08-2020 18:00")
    XCTAssertEqual(moon.info.phase, .waxingGibbous)
  }

  func testMoonPhaseFull() {
    let moon = getMoon("03-9-2020 18:00")
    XCTAssertEqual(moon.info.phase, .fullMoon)
  }

  func testMoonPhaseWaningGibbous() {
    let moon = getMoon("02-11-2020 18:00")
    XCTAssertEqual(moon.info.phase, .waningGibbous)
  }

  func testMoonPhaseLastQuarter() {
    let moon = getMoon("02-16-2020 18:00")
    XCTAssertEqual(moon.info.phase, .lastQuarter)
  }

  func testMoonPhaseWaningCrescent() {
    let moon = getMoon("02-17-2020 18:00")
    XCTAssertEqual(moon.info.phase, .waningCrescent)
  }

  func testMoonPhaseDark() {
    let moon = getMoon("02-23-2020 18:00")
    XCTAssertEqual(moon.info.phase, .newMoon)
  }

  func testIfIsLeapYear() {
    let result = getMoon("02-01-2020 18:00")
    XCTAssertTrue(result.info.isLeapYear)
  }

  func testIfIsNotLeapYear() {
    let result = getMoon("02-01-2021 18:00")
    XCTAssertFalse(result.info.isLeapYear)
  }
}

// MARK: - Extensions
fileprivate extension String {
  var toDate: Date {
    let formatter = DateFormatter()
    formatter.calendar = .current
    formatter.dateFormat = "MM-dd-yyyy HH:mm"
    return formatter.date(from: self)!
  }
}
