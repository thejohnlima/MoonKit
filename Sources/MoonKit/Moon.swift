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

import Foundation

public class Moon {

  private typealias ShortDate = (year: Double, month: Double, day: Double)

  // MARK: - Properties
  private var age: Double?
  private var distance: Double = 0
  private var eclipticLatitude: Double = 0
  private var eclipticLongitude: Double = 0
  private var year: Int
  private var month: Int
  private var day: Int
  private var phase: Phase?

  // Related to month length and age calculations
  private let n28 = 28
  private let n30 = 30
  private let n31 = 31

  private var dim: [Int] {
    return [n31, n28, n31, n30, n31, n30, n31, n31, n30, n31, n30, n31]
  }

  public var info = Info()

  // MARK: - Enums
  public enum Phase: String {
    case new = "New Moon"
    case waxingCrescent = "Waxing Crescent"
    case firstQuarter = "First Quarter"
    case waxingGibbous = "Waxing Gibbous"
    case full = "Full Moon"
    case waningGibbous = "Waning Gibbous"
    case lastQuarter = "Last Quarter"
    case waningCrescent = "Waning Crescent"
    case dark = "Dark Moon"
  }

  // MARK: - Structs
  public struct Info {
    public var age: Double?
    public var distance: Double?
    public var phase: Moon.Phase?
    public var latitude: Double?
    public var longitude: Double?

    public init() {}
  }

  // MARK: - Initializers
  public init(_ date: Date) {
    year = Calendar.current.component(.year, from: date)
    month = Calendar.current.component(.month, from: date)
    day = Calendar.current.component(.day, from: date)

    preparePosition(year, month: month, day: day)

    info.age = doRound(age!)
    info.distance = doRound(distance)
    info.phase = phase
    info.latitude = doRound(eclipticLatitude)
    info.longitude = doRound(eclipticLongitude)

    if !isDayOfMonth((Double(year), Double(month), Double(day))) {
      print("⚠️ MoonKit - Invalid Date")
    }
  }

  // MARK: - Private Methods
  /// Round to 2 decimal places
  /// - Parameter value: Value to round
  private func doRound(_ value: Double) -> Double {
    return round(100 * value) / 100
  }

  /// Normalize values to range 0...1
  /// - Parameter value: Value to normalize
  private func normalize(_ value: Double) -> Double {
    var value = value - floor(value)
    if value < 0 {
      value += 1
    }
    return value
  }

  /// Calculate the Julian date at 12h UT
  /// - Parameter date: The current date
  private func getJulianDate(_ date: ShortDate) -> ShortDate {
    let year = date.year - floor((12 - date.month) / 10)
    var month = date.month + 9
    let day = date.day

    if month >= 12 {
      month -= 12
    }

    return (year, month, day)
  }

  /// Get dates in Julian calendar or Gregorian calendar
  /// - Parameters:
  ///   - year: Year
  ///   - month: Month
  ///   - day: Day
  private func getCalendarDates(_ date: ShortDate) -> Double {
    let k1 = floor(365.25 * (date.year + 4712))
    let k2 = floor(30.6 * date.month + 0.5)
    let k3 = floor(floor((date.year / 100) + 49) * 0.75) - 38

    // For dates in Julian calendar
    var dates = k1 + k2 + date.day + 59

    // For Gregorian calendar
    if dates > 2299160 {
      dates -= k3
    }

    return dates
  }

  /// Calculate moon's age in days
  /// - Parameters:
  ///   - dates: Dates in Julian calendar or Gregorian calendar
  ///   - date: The current date components
  private func getAgeInDays(_ dates: Double, date: ShortDate) -> (age: Double, ip: Double) {
    let ip = normalize((dates - 2451550.1) / 29.530588853)
    var age = ip * 29.53
    if isLeap(year: date.year) {
      age -= 1
    }
    return (age, ip)
  }

  /// Preparing the phase using the moon's age
  /// - Parameters:
  ///   - age: The moon's age
  private func preparePhase(_ age: Double) {
    let age = Int(ceil(age))

    if age < 1 {
      phase = .new
    }else if age < 7 {
      phase = .waxingCrescent
    } else if age == 7 {
      phase = .firstQuarter
    } else if age < 15 {
      phase = .waxingGibbous
    } else if age == 15 {
      phase = .full
    } else if age < 22 {
      phase = .waningGibbous
    } else if age == 22 {
      phase = .lastQuarter
    } else if age < 29 {
      phase = .waningCrescent
    } else {
      phase = .dark
    }
  }

  /// Calculate moon's distance
  /// - Parameters:
  ///   - julianDates: Julian dates
  ///   - ip: IP value
  private func getDistance(_ julianDates: Double, ip: Double) -> (distance: Double, dp: Double) {
    let dp = 2 * Double.pi * normalize((julianDates - 2451562.2) / 27.55454988)
    let distance = 60.4 - 3.3 * cos(dp) - 0.6 * cos(2 * ip - dp) - 0.5 * cos(2 * ip)
    return (distance, dp)
  }

  /// Calculate moon's ecliptic latitude
  /// - Parameter julianDates: Julian dates
  private func calculateEclipticLatitude(_ julianDates: Double) {
    let np = 2 * Double.pi * normalize((julianDates - 2451565.2) / 27.212220817)
    eclipticLatitude = 5.1 * sin(np)
  }

  /// Calculate moon's ecliptic longitude
  /// - Parameters:
  ///   - julianDates: Julian dates
  ///   - ip: IP value
  ///   - dp: DP value
  private func calculateEclipticLongitude(_ julianDates: Double, ip: Double, dp: Double) {
    let rp = normalize((julianDates - 2451555.8) / 27.321582241)
    eclipticLongitude = 360 * rp + 6.3 * sin(dp) + 1.3 * sin(2 * ip - dp) + 0.7 * sin(2 * ip)

    // Correcting if longitude is not greater than 360
    if eclipticLongitude > 360 {
      eclipticLongitude -= 360
    }
  }

  /// Compute moon position and phase
  /// - Parameters:
  ///   - year: Year
  ///   - month: Month
  ///   - day: Day
  private func preparePosition(_ year: Int, month: Int, day: Int) {
    let yearValue = Double(year)
    let monthValue = Double(month)
    let dayValue = Double(day)
    let julianDate = getJulianDate((yearValue, monthValue, dayValue))
    let dates = getCalendarDates((julianDate.year, month: julianDate.month, day: julianDate.day))
    let age = getAgeInDays(dates, date: (yearValue, monthValue, dayValue))
    var ip = age.ip

    self.age = age.age

    preparePhase(age.age)

    // Convert phase to radians
    ip = ip * 2 * Double.pi

    let distance = getDistance(dates, ip: ip)
    self.distance = distance.distance

    calculateEclipticLatitude(dates)
    calculateEclipticLongitude(dates, ip: ip, dp: distance.dp)
  }

  /// Checking if is day of month
  /// - Parameter date: The date
  private func isDayOfMonth(_ date: ShortDate) -> Bool {
    if date.month != 2 {
      if 1 <= date.day && Int(date.day) <= dim[Int(date.month) - 1] {
        return true
      } else {
        return false
      }
    }

    var feb = dim[1]

    if isLeap(year: date.year) {
      feb += 1
    }

    if 1 <= date.day && Int(date.day) <= feb {
      return true
    }

    return false
  }

  /// Checking if is leap year
  /// - Parameter year: Year
  private func isLeap(year: Double) -> Bool {
    let x = floor(year - 4 * floor(year / 4))
    let w = floor(year - 100 * floor(year / 100))
    let z = floor(year - 400 * floor(year / 400))

    if x == 0 { // Possible leap year
      if w == 0 && z != 0 { // Not leap year
        return false
      } else { // Is leap year
        return true
      }
    }

    return false
  }
}
