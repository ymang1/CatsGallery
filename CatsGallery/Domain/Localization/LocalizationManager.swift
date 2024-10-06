//
//  LocalizationManager.swift
//  CatsGallery
//
//  Created by Yukti on 05/10/24.
//

import Foundation

protocol LocalizerProtocol {
    associatedtype Key: RawRepresentable

    func localize(key: Key) -> String
}

final class LocalizationManager<Key: RawRepresentable> where Key.RawValue == String {
    private let stringsHolderBundle: Bundle

    init(stringsHolderBundle: Bundle? = nil) {
        self.stringsHolderBundle = stringsHolderBundle ?? .main
    }
}

extension LocalizationManager: LocalizerProtocol {

    func localize(key: Key) -> String {
        NSLocalizedString(key.rawValue,
                          bundle: stringsHolderBundle,
                          comment: "")
    }
}
