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
import EventKit
import XCTest
@testable import Permit

class CalendarPermissionTests: XCTestCase {
    func test_status_denied_returns_denied() {
        MockEventStore.mockStatus = .denied
        let calendarPerm = CalendarPermission(eventStore: MockEventStore.self)
        XCTAssert(calendarPerm.isDenied == true)
        XCTAssert(calendarPerm.isAuthorized == false)
        XCTAssert(calendarPerm.isNotDetermined == false)
    }
    
    func test_status_authorized_returns_authorized() {
        MockEventStore.mockStatus = .authorized
        let calendarPerm = CalendarPermission(eventStore: MockEventStore.self)
        XCTAssert(calendarPerm.isAuthorized == true)
        XCTAssert(calendarPerm.isDenied == false)
        XCTAssert(calendarPerm.isNotDetermined == false)
    }
    
    func test_status_not_determined_returns_not_determined() {
        MockEventStore.mockStatus = .notDetermined
        let calendarPerm = CalendarPermission(eventStore: MockEventStore.self)
        XCTAssert(calendarPerm.isNotDetermined == true)
        XCTAssert(calendarPerm.isDenied == false)
        XCTAssert(calendarPerm.isAuthorized == false)
    }
}

private class MockEventStore: EKEventStore {
    
    static var mockStatus: EKAuthorizationStatus = .denied
    
    override class func authorizationStatus(for entityType: EKEntityType) -> EKAuthorizationStatus {
        return mockStatus
    }
}
