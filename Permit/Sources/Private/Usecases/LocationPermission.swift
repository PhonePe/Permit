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
import CoreLocation

class LocationPermission: NSObject, CLLocationManagerDelegate, Permission {
    
    private var authStatus: CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            return locationManagerInstance.authorizationStatus
        } else {
            return locationManagerType.authorizationStatus()
        }
    }
    
    var isAuthorized: Bool {
        checkIsAuth()
    }
    
    var isDenied: Bool {
        authStatus == .denied
    }
    
    var isNotDetermined: Bool {
        checkIsNotDetermined()
    }
    
    let type: PermissionType
    private let locationManagerType: CLLocationManager.Type
    private let locationManagerInstance: CLLocationManager
    var onPermissionChange: PermissionChangeCallback = { _ in }
    
    convenience init(type: PermissionType,
                     locationManager: CLLocationManager.Type = CLLocationManager.self) {
        self.init(type: type,
                  locationManager: locationManager.init(),
                  locationManagerType: locationManager)
    }
    
    init(type: PermissionType,
         locationManager: CLLocationManager,
         locationManagerType: CLLocationManager.Type = CLLocationManager.self) {
        self.type = type
        self.locationManagerInstance = locationManager
        self.locationManagerType = locationManagerType
        super.init()
        self.locationManagerInstance.delegate = self
    }
    
    func requestPermission() {
        guard locationManagerType.locationServicesEnabled() else {
            onPermissionChange(.failure(.locationNotAvailable))
            return
        }
        
        if case .locationAlways = type {
            locationManagerInstance.requestAlwaysAuthorization()
        } else if case .locationWhenInUse = type {
            locationManagerInstance.requestWhenInUseAuthorization()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if authStatus == .notDetermined { return }
        switch authStatus {
        case .authorizedAlways:
            onPermissionChange(.success(.locationAlways))
        case .authorizedWhenInUse:
            onPermissionChange(.success(.locationWhenInUse))
        default:
            onPermissionChange(.failure(.denied))
        }
    }
}

private extension LocationPermission {
    func checkIsAuth() -> Bool {
        switch authStatus {
        case .authorizedAlways:
            return type == .locationAlways
        case .authorizedWhenInUse:
            return type == .locationWhenInUse
        default:
            return false
        }
    }
    
    func checkIsNotDetermined() -> Bool {
        if authStatus == .notDetermined || !locationManagerType.locationServicesEnabled() {
            return true
        }
        switch type {
        case .locationWhenInUse:
            return authStatus != .authorizedWhenInUse
        case .locationAlways:
            return authStatus != .authorizedAlways
        default:
            return false
        }
    }
}
