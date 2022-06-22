// The MIT License (MIT)
// Copyright © 2022 PhonePe. (https://phonepe.com, ios-support@phonepe.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


import Foundation
import CoreLocation
import XCTest
@testable import Permit

class LocationPermissionTests: XCTestCase {
    
    func test_location_always_status_denied_returns_denied() {
        let locationPermission = getLocationPermission(type: .locationAlways, mockStatus: .denied)
        XCTAssert(locationPermission.isDenied == true)
        XCTAssert(locationPermission.isAuthorized == false)
    }
    
    func test_location_always_status_authorized_always_returns_authorized() {
        let locationPermission = getLocationPermission(type: .locationAlways, mockStatus: .authorizedAlways)
        XCTAssert(locationPermission.isAuthorized == true)
        XCTAssert(locationPermission.isDenied == false)
        XCTAssert(locationPermission.isNotDetermined == false)
    }
    
    func test_location_always_status_not_determined_returns_not_determined() {
        let locationPermission = getLocationPermission(type: .locationAlways, mockStatus: .notDetermined)
        XCTAssert(locationPermission.isAuthorized == false)
        XCTAssert(locationPermission.isDenied == false)
        XCTAssert(locationPermission.isNotDetermined == true)
    }
    
    func test_location_always_status_authorized_whenInUse_returns_not_determined() {
        let locationPermission = getLocationPermission(type: .locationAlways, mockStatus: .authorizedWhenInUse)
        XCTAssert(locationPermission.isAuthorized == false)
        XCTAssert(locationPermission.isDenied == false)
        XCTAssert(locationPermission.isNotDetermined == true)
    }
    
    func test_location_whenInUse_status_denied_returns_denied() {
        let locationPermission = getLocationPermission(type: .locationWhenInUse, mockStatus: .denied)
        XCTAssert(locationPermission.isDenied == true)
        XCTAssert(locationPermission.isAuthorized == false)
    }

    func test_location_whenInUse_status_authorized_whenInUse_returns_authorized() {
        let locationPermission = getLocationPermission(type: .locationWhenInUse, mockStatus: .authorizedWhenInUse)
        XCTAssert(locationPermission.isAuthorized == true)
        XCTAssert(locationPermission.isDenied == false)
        XCTAssert(locationPermission.isNotDetermined == false)
    }
    
    func test_location_whenInUse_status_not_determined_returns_not_determined() {
        let locationPermission = getLocationPermission(type: .locationWhenInUse, mockStatus: .notDetermined)
        XCTAssert(locationPermission.isAuthorized == false)
        XCTAssert(locationPermission.isDenied == false)
        XCTAssert(locationPermission.isNotDetermined == true)
    }

    func test_location_whenInUse_status_authorized_always_returns_not_determined() {
        let locationPermission = getLocationPermission(type: .locationWhenInUse, mockStatus: .authorizedAlways)
        XCTAssert(locationPermission.isAuthorized == false)
        XCTAssert(locationPermission.isDenied == false)
        XCTAssert(locationPermission.isNotDetermined == true)
    }
    
    func test_location_serviceDisabled_returns_not_determined() {
        let locationPermission = getLocationPermission(type: .locationWhenInUse, mockStatus: .authorizedAlways)
        XCTAssert(locationPermission.isAuthorized == false)
        XCTAssert(locationPermission.isDenied == false)
        XCTAssert(locationPermission.isNotDetermined == true)
    }
    
    private func getLocationPermission(type: PermissionType, mockStatus: CLAuthorizationStatus, locationServicesEnabled: Bool = true) -> LocationPermission {
        MockLocationManagerType.mockStatus = mockStatus
        MockLocationManagerType.mockLocationServicesEnabled = locationServicesEnabled
        return LocationPermission(type: type, locationManager: MockLocationManager(mockStatus: mockStatus), locationManagerType: MockLocationManagerType.self)
    }
}

class MockLocationManager: CLLocationManager {
    var mockStatus: CLAuthorizationStatus
    
    init(mockStatus: CLAuthorizationStatus) {
        self.mockStatus = mockStatus
    }
    
    override var authorizationStatus: CLAuthorizationStatus {
        return mockStatus
    }
}

class MockLocationManagerType: CLLocationManager {
    static var mockStatus: CLAuthorizationStatus = .denied
    static var mockLocationServicesEnabled: Bool = false
    
    override static func locationServicesEnabled() -> Bool {
        return mockLocationServicesEnabled
    }
    
    override static func authorizationStatus() -> CLAuthorizationStatus {
        return mockStatus
    }
}
