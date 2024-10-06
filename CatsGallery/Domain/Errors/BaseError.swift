//
//  BaseError.swift
//  CatsGallery
//
//  Created by Yukti on 05/10/24.
//

import Foundation

protocol BaseError: LocalizedError {
    
    var title: String? { get }

    var message: String? { get }
}
