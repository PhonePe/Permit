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

/// A class which generates strings for alerts for dialogs based on type.
class StringFactory {
    
    private init() {
        // empty to avoid outside initialisation
    }
    
    /// A method which generates a generic title for alert config
    /// - Parameter type: A type, for which you want to generate title for.
    /// - Returns: A string, which is a type-specific generic title.
    static func getTitle(type: PermissionType) -> String {
        let typeString = getTypeString(type).capitalized
        return typeString + " " + "Permission denied"
    }
    
    /// A method which generates a generic message for alert config
    /// - Parameter type: A type, for which you want to generate message for.
    /// - Returns: A string, which is a type-specific generic message.
    static func getMsg(type: PermissionType) -> String {
        let typeString = getTypeString(type).lowercased()
        return "App does not have permission to access your \(typeString). Please go to Settings and enable it"
    }
    
    struct ButtonText {
        static let settings = "Settings"
        static let cancel = "Cancel"
    }
    
    /// A method which generates permission prefix strings based on type
    /// - Parameter type: A type, for which you want to rgenerate type-specific string for.
    /// - Returns: A string, which is synonomous with the usecase requested.
    private static func getTypeString(_ type: PermissionType) -> String {
        switch type {
        case .camera:
            return "Camera"
        case .photos:
            return "Photos"
        case .microphone:
            return "Microphone"
        case .contacts:
            return "Contacts"
        case .notifications:
            return "Notifications"
        case .locationWhenInUse, .locationAlways:
            return "Location"
        case .calendar:
            return "Calendar"
        }
    }
}
