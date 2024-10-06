//
//  CatsGalleryTests.swift
//  CatsGalleryTests
//
//  Created by Yukti on 05/10/24.
//

import XCTest
import Combine

@testable import CatsGallery

final class CatsGalleryTests: XCTestCase {
    
    var viewModel: CatGalleryViewModel!
    var catApiMock: CatApiMock!
    var subscriptions: Set<AnyCancellable> = []

    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()

        catApiMock = CatApiMock()
        viewModel = CatGalleryViewModel(catApi: catApiMock)
    }

    @MainActor func testWhenCatsFetchedApiCalled() async throws {
        // When
        await viewModel.getCats(skip: 0, limit: 10)

        // Then
        XCTAssertTrue(catApiMock.getCatsCalled)
    }

    @MainActor func testWhenCatsFetchedLoadingSpinnerShown() async throws {
        let expectation = expectation(description: "Expect isLoading to be true")
        viewModel.$isLoading
            .first(where: { $0 })
            .sink { value in
                XCTAssertTrue(value)
                expectation.fulfill()
            }.store(in: &subscriptions)

        // When
        await viewModel.getCats(skip: 0, limit: 10)

        // Then
        await fulfillment(of: [expectation])
    }

    func testWhenGetCatsErrorThrownAlertShown() async throws {
        // Given
        let error = ApiError.errorGettingCats
        catApiMock.getCatsError = error

        // When
        await viewModel.getCats(skip: 0, limit: 10)

        let alert = await viewModel.$alert
            .first()
            .values
            .first(where: { _ in true }) ?? nil

        // Then
        XCTAssertEqual(alert?.message, error.message)
    }
}
