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
import UIKit

public class Permit {
    
    private init() {}
}

// MARK: - Public Interface
extension Permit {
    /// A method which tells you if the provided permission is authorized.
    /// - Parameter usecase: A type, for which you want to determine status of.
    /// - Returns: A boolean,  `true` if the permission is authorised.
    public static func isAuthorized(usecase: PermissionType) -> Bool {
        return usecase.permission().isAuthorized
    }
    
    /// A method which tells you if the provided permission is denied.
    /// If the status comes out to be not determined or denied you can go ahead and call the `requestPermission` method.
    /// - Parameter usecase: A type, for which you want to determine status of.
    /// - Returns: A boolean,  `true` if the permission is denied.
    public static func isDenied(usecase: PermissionType) -> Bool {
        return usecase.permission().isDenied
    }
    
    /// A method which tells you if the provided permission is not determined.
    /// If the status comes out to be not determined or denied you can go ahead and call the `requestPermission` method.
    /// - Parameter usecase: A type, for which you want to determine status of.
    /// - Returns: A boolean,  `true` if the permission is not determined.
    public static func isNotDetermined(usecase: PermissionType) -> Bool {
        return usecase.permission().isNotDetermined
    }
    
    /// A method to request permission for the given type. This will be called only if the permission status is in `denied` or `not determined` status.
    /// - Parameters:
    ///   - usecase: A type, for which you want to request permission for.
    ///   - onPermissionChange: A callback which fires when user takes a decision on what they have decided with the permission.
    ///   - vc: A UIViewController for which you wish to present on the `UIAlertController` in case the permission is already denied and we need to move to Settings.
    ///   - settingsDialogConfig: A config for the dialog to be presented in case the permission is denied and we need to move to Settings.
    public static func requestPermission(usecase: PermissionType, showPopupIfNeededOn vc: UIViewController, settingsDialogConfig: AlertConfig? = nil, onPermissionChange: @escaping PermissionChangeCallback) {
        
        // if status denied show settings popup
        if isDenied(usecase: usecase) {
            PermissionHelper.showSettingsPopup(usecase: usecase,
                                               on: vc,
                                               onPermissionChange: onPermissionChange,
                                               settingsDialogConfig: settingsDialogConfig)
            return
        }
        
        // if status not determined -> request
        if isNotDetermined(usecase: usecase) {
            var permission = usecase.permission()
            permission.onPermissionChange = onPermissionChange
            permission.requestPermission()
        }
    }
}
