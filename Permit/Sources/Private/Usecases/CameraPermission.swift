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

class CameraPermission: Permission {
    
    private var authStatus: AVAuthorizationStatus {
        device.authorizationStatus(for: .video)
    }
    
    var isAuthorized: Bool {
        authStatus == .authorized
    }
    
    var isDenied: Bool {
        authStatus == .denied
    }
    
    var isNotDetermined: Bool {
        authStatus == .notDetermined
    }
    
    let type: PermissionType = .camera
    private let device: AVCaptureDevice.Type
    
    var onPermissionChange: PermissionChangeCallback = { _ in }
   
    convenience init() {
        // empty init to avoid code smell
        self.init(helper: AVCaptureDevice.self)
    }
    
    init(helper: AVCaptureDevice.Type = AVCaptureDevice.self) {
        self.device = helper
        
    }
    
    func requestPermission() {
        device.requestAccess(for: .video) { [weak self] granted in
            guard let self = self else {
                return
            }
            granted ?
            self.onPermissionChange(.success(self.type)) :
            self.onPermissionChange(.failure(.denied))
        }
    }
}
