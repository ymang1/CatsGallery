//
//  ImageLoaderView.swift
//  CatsGallery
//
//  Created by Yukti on 06/10/24.
//

import SwiftUI

// Fallback view for loading images on iOS 14 and below
struct ImageLoaderView: View {
    @StateObject private var loader: ImageLoader
    let url: URL
    
    init(url: URL) {
        self.url = url
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            ProgressView() // Show a loading spinner while fetching the image
        }
    }
}
