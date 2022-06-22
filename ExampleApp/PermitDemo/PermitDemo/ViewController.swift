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


import UIKit
import Permit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startDemo()
    }
    
    private func startDemo() {
        // change any permission types here
        if Permit.isAuthorized(usecase: .camera) {
            // do stuff related to camera
        } else {
            requestPermission(for: .camera) { result in
                switch result {
                case let .success(type):
                    print("Permission Granted for \(type)!")
                case let .failure(error):
                    print("Permission Denied with \(error)!")
                }
            }
        }
    }
}

extension ViewController {
    func requestPermission(for type: PermissionType,
                           callback: @escaping PermissionChangeCallback) {
        let alertConfig: AlertConfig = DeniedAlertConfig()
        Permit.requestPermission(usecase: type,
                                 showPopupIfNeededOn: self,
                                 settingsDialogConfig: alertConfig,
                                 onPermissionChange: callback)
    }
}

struct DeniedAlertConfig: AlertConfig {
    var title: String
    var message: String
    var cancelButtonText: String
    var settingsButtonText: String
    
    init() {
        self.title = "Demo Denied Alert Title"
        self.message = "Demo Denied Alert Message"
        self.cancelButtonText = "Cancel"
        self.settingsButtonText = "Settings"
    }
}
