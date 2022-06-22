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

class PhotosPermission: Permission {
    
    private var authStatus: PHAuthorizationStatus {
        photoLibrary.authorizationStatus()
    }
    
    var isAuthorized: Bool {
        if #available(iOS 14, *) {
            return authStatus == .authorized || authStatus == .limited
        } else {
            return authStatus == .authorized
        }
    }
    
    var isDenied: Bool {
        authStatus == .denied
    }
    
    var isNotDetermined: Bool {
        authStatus == .notDetermined
    }
    
    let type: PermissionType = .photos
    let photoLibrary: PHPhotoLibrary.Type
    
    var onPermissionChange: PermissionChangeCallback = { _ in }
    
    convenience init() {
        self.init(helper: PHPhotoLibrary.self)
    }
    
    init(helper: PHPhotoLibrary.Type = PHPhotoLibrary.self) {
        self.photoLibrary = helper
    }
    
    func requestPermission() {
        photoLibrary.requestAuthorization { [weak self] status in
            
            guard let self = self else {
                return
            }
            status == .authorized ?
            self.onPermissionChange(.success(self.type)) :
            self.onPermissionChange(.failure(.denied))
        }
    }
}
