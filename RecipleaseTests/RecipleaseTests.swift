//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Lorene Brocourt on 17/02/2023.
//

import XCTest
import CoreData
@testable import Reciplease

final class RecipleaseTests: XCTestCase {
    var searchViewModel: SearchViewModel!
    // custom urlsession for mock network calls (networkClient)
    var dummyUrlSession: URLSession!

    var networkService: NetworkService!

    var completionHandler: ((Bool) -> Void)?

    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        dummyUrlSession = URLSession(configuration: configuration)

        networkService = NetworkService(urlSession: dummyUrlSession)

        searchViewModel = SearchViewModel(networkService: networkService)
    }

    private func loadData(from resource: String) throws -> Data {
        let bundle = Bundle(for: RecipleaseTests.self)
        let url = bundle.url(forResource: resource, withExtension: "json")!
        return try Data(contentsOf: url)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGivenMockUrlSession_WhenRequestRecipeWithMockedJson_ThenRecipeModelCorrectlyCreated() throws {
        // Set mock data
        let mockData = try loadData(from: "Recipes")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }

        // Return data in mock request handler
        let expectation = XCTestExpectation(description: "response")

        networkService.fetchData(entries: ["pomelo", "mustard"]) { result in
            switch result {
            case .success(let models):
                XCTAssertEqual(models.count, 3)
                XCTAssertEqual(models.first?.title, "Crab Salad with Avocado and Pomelo")
                XCTAssertEqual(models.first?.url, "https://www.menshealth.com/recipes/crab-salad-with-avocado-and-pomelo")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testGivenSearchViewModel_WhenItemList_ThenClearItemList() {
        searchViewModel.ingredientsList.value = ["Pomelo", "Tuna", "Egg"]
        searchViewModel.clearItemList()
        XCTAssertEqual(searchViewModel.ingredientsList.value,
                       [])
    }

    func testGivenSearchViewModel_WhenAddIngredientInList_ThenIngredientAdded() {
        searchViewModel.ingredientsList.value = ["Pomelo"]
        searchViewModel.addIngredient("Tuna")
        XCTAssertEqual(searchViewModel.ingredientsList.value,
                       ["Pomelo", "Tuna"])
    }

    func testGivenSearchViewModelWithIngredientList_WhenRequestForRecipe_ThenRequestSucceed() throws {
        let expectation = XCTestExpectation(description: "response")

        searchViewModel.recipes.bind {
            [weak self] recipes in
            self?.completionHandler?(true)
        }

        let mockData = try loadData(from: "Recipes")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }

        searchViewModel.ingredientsList.value = ["pomelo", "mustard"]
        searchViewModel.request()

        completionHandler = { completed in
            XCTAssertTrue(completed)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20)
    }

    // MARK: - RecipeListViewModel

    func testGivenRecipeListViewModel_WhenInitialized_ThenSuccess() {
        let recipeListViewModel = RecipeListViewModel([])
        XCTAssertNotNil(recipeListViewModel)
    }

    // MARK: - RecipeDetailViewModel

    func testGivenRecipeDetailViewModel_When_ThenSuccess() {
        let recipeModel = RecipeModel(url: "https://dummy.url",
                                      title: "Dummy salad",
                                      ingredients: ["salad, tomato, dummies"])

        let recipeDetailViewModel = RecipeDetailViewModel(recipeModel: recipeModel, true)

        var isFavorite = false
        // Add Favorite
        isFavorite = recipeDetailViewModel.handleFavoriteState()
        // Delete Favorite
        isFavorite = recipeDetailViewModel.handleFavoriteState()

        XCTAssertFalse(isFavorite)
    }

    // MARK: - FavoriteViewModel

    func testGivenFavoriteViewModel_WhenLoadFavorite_ThenSuccess() {
        let recipeModel = RecipeModel(url: "https://dummy.url",
                                      title: "Dummy salad",
                                      ingredients: ["salad, tomato, dummies"])

        let recipeDetailViewModel = RecipeDetailViewModel(recipeModel: recipeModel, true)

        // Add Favorite
        recipeDetailViewModel.handleFavoriteState()

        // Load favorite
        let favoriteViewModel = FavoriteViewModel(true)

        let expectation = XCTestExpectation(description: "response")

        favoriteViewModel.recipeList.bind { list in
            if list.isEmpty == false {
                let recipe = list.first
                XCTAssertEqual(recipe?.title, "Dummy salad")
                XCTAssertEqual(recipe?.url, "https://dummy.url")
                XCTAssertEqual(recipe?.ingredients, ["salad, tomato, dummies"])
                // Delete Favorite
                recipeDetailViewModel.handleFavoriteState()
                expectation.fulfill()
            }
        }
        favoriteViewModel.loadFavorites()
        wait(for: [expectation], timeout: 2)
    }
}
