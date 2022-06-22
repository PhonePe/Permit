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
import Contacts
import XCTest
@testable import Permit

class ContactsPermissionTests: XCTestCase {
    func test_status_denied_returns_denied() {
        MockContactStore.mockStatus = .denied
        let contactsPerm = ContactsPermission(contactStore: MockContactStore.self)
        XCTAssert(contactsPerm.isDenied == true)
        XCTAssert(contactsPerm.isAuthorized == false)
        XCTAssert(contactsPerm.isNotDetermined == false)
    }
    
    func test_status_authorized_returns_authorized() {
        MockContactStore.mockStatus = .authorized
        let contactsPerm = ContactsPermission(contactStore: MockContactStore.self)
        XCTAssert(contactsPerm.isAuthorized == true)
        XCTAssert(contactsPerm.isDenied == false)
        XCTAssert(contactsPerm.isNotDetermined == false)
    }
    
    func test_status_not_determined_returns_not_determined() {
        MockContactStore.mockStatus = .notDetermined
        let contactsPerm = ContactsPermission(contactStore: MockContactStore.self)
        XCTAssert(contactsPerm.isNotDetermined == true)
        XCTAssert(contactsPerm.isDenied == false)
        XCTAssert(contactsPerm.isAuthorized == false)
    }
}

private class MockContactStore: CNContactStore {
    
    static var mockStatus: CNAuthorizationStatus = .denied
    
    override class func authorizationStatus(for entityType: CNEntityType) -> CNAuthorizationStatus {
        return mockStatus
    }
}
