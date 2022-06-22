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

class MicrophonePermission: Permission {
    
    private var authStatus: AVAudioSession.RecordPermission {
        audioInterface.recordPermission
    }
    
    var isAuthorized: Bool {
        authStatus == .granted
    }
    
    var isDenied: Bool {
        authStatus == .denied
    }
    
    var isNotDetermined: Bool {
        authStatus == .undetermined
    }
    
    let type: PermissionType = .microphone
    let audioInterface: AVAudioSessionProtocol
    
    var onPermissionChange: PermissionChangeCallback = { _ in }
    
    convenience init() {
        self.init(session: AVAudioSession.sharedInstance())
    }
    
    init(session: AVAudioSessionProtocol) {
        self.audioInterface = session
    }
    
    func requestPermission() {
        audioInterface.requestRecordPermission { [weak self] granted in
            guard let self = self else {
                return
            }
            granted ?
            self.onPermissionChange(.success(self.type)) :
            self.onPermissionChange(.failure(.denied))
        }
    }
}
