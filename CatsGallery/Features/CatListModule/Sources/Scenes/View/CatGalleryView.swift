//
//  CatGalleryView.swift
//  CatsGallery
//
//  Created by Yukti on 05/10/24.
//

import SwiftUI

struct CatGalleryView: View {
    
    @StateObject var viewModel = CatGalleryViewModel()
    @StateObject var orientationObserver = OrientationObserver()
    @State var skip: Int = 0
    let limit: Int = 10
    
    var body: some View {
        return NavigationView {
            VStack {
                // Show loading spinner that covers screen on intial load when there are no cats
                if viewModel.isLoading && viewModel.cats.isEmpty {
                    ProgressView()
                } else {
                    listView()
                }
            }
            .onAppear {
                // Fetch cats when the view appears
                fetchCats()
            }
            .navigationTitle(CatGalleryKey.navTitleCatGallery.localized())
        }
    }
    
    func listView() -> some View {
        Group {
            if orientationObserver.orientation.isLandscape {
                // Horizontal scrolling in landscape
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(viewModel.cats, id: \.id) { cat in
                            CatGalleryItemView(cat: cat)
                                .onAppear {
                                    // When we scroll to the last cat in the list, fetch more cats
                                    if cat.id == viewModel.cats.last?.id {
                                        loadMoreCats()
                                    }
                                }
                        }
                    }
                }
            } else {
                // Vertical scrolling in portrait
                List {
                    ForEach(viewModel.cats, id: \.id) { cat in
                        CatGalleryItemView(cat: cat)
                            .onAppear {
                                // When we scroll to the last cat in the list, fetch more cats
                                if cat.id == viewModel.cats.last?.id {
                                    loadMoreCats()
                                }
                            }
                    }
                }
            }
        }
    }
    
    private func fetchCats() {
        
        viewModel.isLoading = true
        Task {
            await viewModel.getCats(skip: skip, limit: limit)
        }
    }
    
    private func loadMoreCats() {
        
        guard !viewModel.isLoading else { return } // Prevent multiple loads
        
        skip += limit
        fetchCats() // Reuse the fetch function
    }
}

#Preview {
    CatGalleryView()
}
