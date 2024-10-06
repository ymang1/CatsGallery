//
//  CatGalleryStrings.swift
//  CatsGallery
//
//  Created by Yukti on 05/10/24.
//

import Foundation

enum CatGalleryKey: String {
    
    case errorMessageGettingCats
    
    case errorTitleGettingCats
    
    case navTitleCatGallery
}

extension CatGalleryKey: Localizable {
    var bundle: Bundle {
        .module
    }

    var tableName: String? { "CatGallery" }
}
