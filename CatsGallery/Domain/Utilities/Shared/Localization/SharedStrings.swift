//
//  SharedStrings.swift
//  CatsGallery
//
//  Created by Yukti on 05/10/24.
//

import Foundation

enum SharedKey: String {
    
    case error
    
    case ok
}

extension SharedKey: Localizable {
    var bundle: Bundle {
        .module
    }

    var tableName: String? { "Shared" }
}
