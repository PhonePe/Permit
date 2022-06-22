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


/// Exhaustive set of all types of permissions provided by the framework.
public enum PermissionType: Hashable {
    case camera
    case photos
    case microphone
    case contacts
    case notifications(options: UNAuthorizationOptions)
    case locationWhenInUse
    case locationAlways
    case calendar
    
    
    /// A method which returns an instance of the permission through a helper.
    /// We only make one instance of a permission in one session.
    /// - Returns: A permission class accordingly for the type asked.
    public func permission() -> Permission {
        return PermissionProvider.shared.getPermissionInstance(type: self)
    }
}

extension PermissionType {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .notifications(options):
            hasher.combine(options.rawValue)
        default:
            break
        }
    }
}
