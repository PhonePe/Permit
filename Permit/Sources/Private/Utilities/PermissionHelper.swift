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

/// A helper class for having basic utility methods.
class PermissionHelper {
    
    private init() {
        // empty init to avoid outside initialisation
    }
    
    /// A method which shows a settings popup in case if the permission is already denied.
    /// - Parameters:
    ///   - usecase: A type, for which you want to present the alert for.
    ///   - viewController: A `UIViewController` on which the `UIAlertController` will be presented.
    ///   - onPermissionChange: A callback if the permission gets changed after the user navigates to settings or cancels.
    ///   - settingsDialogConfig: A config to configure the `UIAlertController` that will be presented.
    static func showSettingsPopup(usecase: PermissionType,
                                  on viewController: UIViewController,
                                  onPermissionChange: @escaping PermissionChangeCallback,
                                  settingsDialogConfig: AlertConfig?) {
        
        let config = PermissionHelper.getDeniedAlertViewModel(type: usecase, config: settingsDialogConfig)
        let alertController = UIAlertController(title: config.title, message: config.message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: config.cancelButtonText, style: .cancel, handler: { _ in
            onPermissionChange(.failure(.denied))
        })
        let moveToSettingsAction = UIAlertAction(title: config.settingsButtonText, style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
            onPermissionChange(.failure(.movedToSettings))
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(moveToSettingsAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    /// A helper method which generates the alert config for the alert to be presented.
    /// - Parameters:
    ///   - type: A type, for which you want to generate the alert config for.
    ///   - config: Any overriden config passed from the user which needs to be taken in account.
    /// - Returns: An alert config which will be used to configure the alert.
    private static func getDeniedAlertViewModel(type: PermissionType, config: AlertConfig?) -> DeniedAlertVM {
        let title = config?.title ?? StringFactory.getTitle(type: type)
        let msg = config?.message ?? StringFactory.getMsg(type: type)
        let cancelBtnText = config?.cancelButtonText ?? StringFactory.ButtonText.cancel
        let settingBtnText = config?.settingsButtonText ?? StringFactory.ButtonText.settings
        return DeniedAlertVM(title: title, message: msg, cancelButtonText: cancelBtnText, settingsButtonText: settingBtnText)
    }
}
