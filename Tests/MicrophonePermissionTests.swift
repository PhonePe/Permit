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
import AVFAudio
import XCTest
@testable import Permit

class MicrophonePermissionTests: XCTestCase {
    
    func test_status_denied_returns_denied() {
        let mockAudio = MockAudioInterface(mockStatus: .denied)
        let micPerm = MicrophonePermission(session: mockAudio)
        XCTAssert(micPerm.isDenied == true)
        XCTAssert(micPerm.isAuthorized == false)
        XCTAssert(micPerm.isNotDetermined == false)
    }

    func test_status_authorized_returns_authorized() {
        let mockAudio = MockAudioInterface(mockStatus: .granted)
        let micPerm = MicrophonePermission(session: mockAudio)
        
        XCTAssert(micPerm.isAuthorized == true)
        XCTAssert(micPerm.isDenied == false)
        XCTAssert(micPerm.isNotDetermined == false)
    }

    func test_status_not_determined_returns_not_determined() {
        let mockAudio = MockAudioInterface(mockStatus: .undetermined)
        let micPerm = MicrophonePermission(session: mockAudio)
        XCTAssert(micPerm.isNotDetermined == true)
        XCTAssert(micPerm.isDenied == false)
        XCTAssert(micPerm.isAuthorized == false)
    }
}
class MockAudioInterface: AVAudioSessionProtocol {

    var dummyStatus: AVAudioSession.RecordPermission = .undetermined

    init(mockStatus: AVAudioSession.RecordPermission) {
        self.dummyStatus = mockStatus
    }

    var recordPermission: AVAudioSession.RecordPermission {
        return dummyStatus
    }

    func requestRecordPermission(_ response: @escaping (Bool) -> Void) {
        response(recordPermission == .granted)
    }
}
