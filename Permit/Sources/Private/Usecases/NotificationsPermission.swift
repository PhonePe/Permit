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
import UserNotifications

class NotificationsPermission: Permission {
    
    private(set) var isAuthorized: Bool
    
    private(set) var isDenied: Bool
    
    private(set) var isNotDetermined: Bool
    
    let type: PermissionType
    
    private let options: UNAuthorizationOptions
    private let notificationCenter: UNUserNotificationCenterProtocol
    
    var onPermissionChange: PermissionChangeCallback = { _ in }
    
    convenience init(options: UNAuthorizationOptions) {
        self.init(notifCenter: UNUserNotificationCenter.current(), options: options)
    }
    
    init(notifCenter: UNUserNotificationCenterProtocol = UNUserNotificationCenter.current(),
         options: UNAuthorizationOptions) {
        self.isAuthorized = false
        self.isNotDetermined = false
        self.isDenied = false
        self.options = options
        self.type = .notifications(options: options)
        self.notificationCenter = notifCenter
        
        self.notificationCenter.getNotificationSettingsFromSource { settings in
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                self.isAuthorized = true
            case .notDetermined:
                self.isNotDetermined = true
            case .denied:
                self.isDenied = true
            default:
                break
            }
        }
    }
    
    func requestPermission() {
        notificationCenter.requestAuthorization(options: options) { granted, _ in
            granted ?
            self.onPermissionChange(.success(self.type)) :
            self.onPermissionChange(.failure(.denied))
        }
    }
}
