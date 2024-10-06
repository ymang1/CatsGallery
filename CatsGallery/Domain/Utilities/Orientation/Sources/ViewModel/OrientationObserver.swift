//
//  OrientationObserver.swift
//  CatsGallery
//
//  Created by Yukti on 06/10/24.
//

import SwiftUI

/// OrientationObserver used for identifying current device orientation
class OrientationObserver: ObservableObject {
    
    @Published var orientation: UIDeviceOrientation = UIDevice.current.orientation

    init() {
        NotificationCenter.default.addObserver(
            forName: UIDevice.orientationDidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.orientation = UIDevice.current.orientation
        }
    }
}
