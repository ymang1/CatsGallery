//
//  ApiError.swift
//  CatsGallery
//
//  Created by Yukti on 05/10/24.
//

import Foundation

enum ApiError: BaseError {
    
    case errorGettingCats

    var title: String? {
        switch self {
        case .errorGettingCats:
            return CatGalleryKey.errorTitleGettingCats.localized()
        }
    }

    var message: String? {
        switch self {
        case .errorGettingCats:
            return CatGalleryKey.errorMessageGettingCats.localized()
        }
    }
}
