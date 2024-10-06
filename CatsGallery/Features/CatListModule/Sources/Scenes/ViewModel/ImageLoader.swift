//
//  ImageLoader.swift
//  CatsGallery
//
//  Created by Yukti on 06/10/24.
//

import UIKit

// ImageLoader class to download images manually for iOS 14 and below
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    
    init(url: URL) {
        self.url = url
        loadImage()
    }
    
    // Load image from API
    func loadImage() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = loadedImage
                }
            }
        }.resume()
    }
}
