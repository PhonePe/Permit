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
import Photos
import XCTest
@testable import Permit

class PhotosPermissionTests: XCTestCase {
    func test_status_denied_returns_denied() {
        MockPhotoLibrary.status = .denied
        let photosPerm = PhotosPermission(helper: MockPhotoLibrary.self)
        XCTAssert(photosPerm.isDenied == true)
        XCTAssert(photosPerm.isAuthorized == false)
        XCTAssert(photosPerm.isNotDetermined == false)
    }
    
    func test_status_authorized_returns_authorized() {
        MockPhotoLibrary.status = .authorized
        let photosPerm = PhotosPermission(helper: MockPhotoLibrary.self)
        XCTAssert(photosPerm.isAuthorized == true)
        XCTAssert(photosPerm.isDenied == false)
        XCTAssert(photosPerm.isNotDetermined == false)
    }
    
    func test_status_not_determined_returns_not_determined() {
        MockPhotoLibrary.status = .notDetermined
        let photosPerm = PhotosPermission(helper: MockPhotoLibrary.self)
        XCTAssert(photosPerm.isNotDetermined == true)
        XCTAssert(photosPerm.isDenied == false)
        XCTAssert(photosPerm.isAuthorized == false)
    }
}

class MockPhotoLibrary: PHPhotoLibrary {
    
    static var status: PHAuthorizationStatus = .authorized
    
    override static func authorizationStatus() -> PHAuthorizationStatus {
        return status
    }
    
    override static func requestAuthorization(_ handler: @escaping (PHAuthorizationStatus) -> Void) {
        handler(status)
    }
}
