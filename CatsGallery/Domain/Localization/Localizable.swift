//
//  Localizable.swift
//  CatsGallery
//
//  Created by Yukti on 05/10/24.
//

import Foundation

protocol Localizable: RawRepresentable {
    var bundle: Bundle { get }
    var tableName: String? { get }

    func localized() -> String
}

extension Localizable where RawValue == String {

    var tableName: String? { nil }

    func localized() -> String {
        NSLocalizedString(self.rawValue, tableName: tableName, bundle: bundle, comment: "")
    }
}
