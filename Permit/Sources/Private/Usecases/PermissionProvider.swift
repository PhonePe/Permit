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

class PermissionProvider {
    
    static let shared = PermissionProvider()
    private var permissionInstanceDict = [PermissionType: Permission]()
    
    func getPermissionInstance(type: PermissionType) -> Permission {
        
        guard let permissionIns = permissionInstanceDict[type] else {
            let permission = createPermissionInstance(type: type)
            permissionInstanceDict[type] = permission
            return permission
        }
        return permissionIns
    }
    
    private func createPermissionInstance(type: PermissionType) -> Permission {
        
        switch type {
        case .camera:
            return CameraPermission()
        case .photos:
            return PhotosPermission()
        case .contacts:
            return ContactsPermission()
        case .microphone:
            return MicrophonePermission()
        case let .notifications(options):
            return NotificationsPermission(options: options)
        case .locationAlways:
            return LocationPermission(type: .locationAlways)
        case .locationWhenInUse:
            return LocationPermission(type: .locationWhenInUse)
        case .calendar:
            return CalendarPermission()
        }
    }
    
    private init() {}
}
