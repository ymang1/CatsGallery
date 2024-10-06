//
//  CatGalleryItemView.swift
//  CatsGallery
//
//  Created by Yukti on 06/10/24.
//

import SwiftUI

struct CatGalleryItemView: View {
    
    var cat: CatModel
    
    var body: some View {
        // Use a GeometryReader to get the size of the item and fetch
        // a cat photo to fill that size
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                let widthPx = Int(geometry.size.width * UIScreen.main.scale)
                let heightPx = Int(geometry.size.height * UIScreen.main.scale)
                
                if #available(iOS 15.0, *) {
                    AsyncImage(url: cat.getImageUrl(width: widthPx, height: heightPx)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: geometry.size.width)
                        } else if phase.error != nil {
                            Color.gray.frame(height: 0) // Placeholder for error
                        } else {
                            ProgressView() // Placeholder while loading
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.clear)
                        }
                    }
                } else {
                    // Fallback on earlier versions
                    ImageLoaderView(url: cat.getImageUrl(width: widthPx, height: heightPx))
                        .frame(height: geometry.size.width)
                }
            }
            .clipped()
            .aspectRatio(1, contentMode: .fit)
            
            Text("**ID:** \(cat.id)")
                .font(.title3)
        }
    }
}
