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
import AVFoundation
import XCTest
@testable import Permit

class CameraPermissionTests: XCTestCase {
    func test_status_denied_returns_denied() {
        MockDevice.status = .denied
        let cameraPerm = CameraPermission(helper: MockDevice.self)
        XCTAssert(cameraPerm.isDenied == true)
        XCTAssert(cameraPerm.isAuthorized == false)
        XCTAssert(cameraPerm.isNotDetermined == false)
    }
    
    func test_status_authorized_returns_authorized() {
        MockDevice.status = .authorized
        let cameraPerm = CameraPermission(helper: MockDevice.self)
        XCTAssert(cameraPerm.isAuthorized == true)
        XCTAssert(cameraPerm.isDenied == false)
        XCTAssert(cameraPerm.isNotDetermined == false)
    }
    
    func test_status_not_determined_returns_not_determined() {
        MockDevice.status = .notDetermined
        let cameraPerm = CameraPermission(helper: MockDevice.self)
        XCTAssert(cameraPerm.isNotDetermined == true)
        XCTAssert(cameraPerm.isDenied == false)
        XCTAssert(cameraPerm.isAuthorized == false)
    }
}

class MockDevice: AVCaptureDevice {
    
    static var status: AVAuthorizationStatus = .authorized
    
    override static func authorizationStatus(for mediaType: AVMediaType) -> AVAuthorizationStatus {
        return status
    }
    
    override static func requestAccess(for mediaType: AVMediaType, completionHandler handler: @escaping (Bool) -> Void) {
        handler(status == .authorized)
    }
}
