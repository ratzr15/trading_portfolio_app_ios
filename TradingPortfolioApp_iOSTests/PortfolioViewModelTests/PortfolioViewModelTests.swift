//
//  PortfolioViewModelTests.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

import XCTest
@testable import TradingPortfolioApp_iOS

class PortfolioViewModelTests: XCTestCase {
    
    var viewModel: PortfolioViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = PortfolioViewModel(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func test_initialState_is_loading() {
        XCTAssertEqual(viewModel.sectionsCount, 1)
    }

    func test_loadPortfolio_onPortfolioFetchStart_isCalled() {
        let expectation = XCTestExpectation(description: "onPortfolioFetchStart should be called")
        viewModel.onPortfolioFetchStart = {
            expectation.fulfill()
        }
        viewModel.loadPortfolio()
        wait(for: [expectation], timeout: 0.1)
    }

    func test_loadPortfolio_success_onPortfolioFetchCompleted_isCalled() {
        let expectation = XCTestExpectation(description: "onPortfolioFetchCompleted should be called on success")
        mockNetworkManager.shouldSucceed = true
        mockNetworkManager.mockResponse = PortfolioResponse.dummy

        viewModel.onPortfolioFetchCompleted = {
            expectation.fulfill()
        }

        viewModel.loadPortfolio()
        wait(for: [expectation], timeout: 2.0)
    }

    func test_loadPortfolio_failure_onPortfolioFetchError_isCalled() {
        let expectation = XCTestExpectation(description: "onPortfolioFetchError should be called on failure")
        let testError = NSError(domain: "TestError", code: 123, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])
        mockNetworkManager.shouldSucceed = false
        mockNetworkManager.mockError = testError

        viewModel.onPortfolioFetchError = { errorMessage in
            XCTAssertEqual(errorMessage, testError.localizedDescription)
            expectation.fulfill()
        }

        viewModel.loadPortfolio()
        wait(for: [expectation], timeout: 2.0)
    }

    func test_loadPortfolio_success_dataSource_updatedWithPortfolio() {
        let expectation = XCTestExpectation(description: "DataSource should be updated with portfolio data on success")
        mockNetworkManager.shouldSucceed = true
        mockNetworkManager.mockResponse = PortfolioResponse.dummy

        viewModel.onPortfolioFetchCompleted = { [weak self] in
            guard let self = self else { return }
            XCTAssertEqual(self.viewModel.sectionsCount, 1)
            XCTAssertEqual(self.viewModel.numberOfRows(section: 0), PortfolioResponse.dummy.portfolio.positions.count)
            expectation.fulfill()
        }

        viewModel.loadPortfolio()
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_sectionsCount() {
        XCTAssertEqual(viewModel.sectionsCount, 1)
    }

    func test_loadPortfolio_failure_dataSource_updatedWithError() {
        let expectation = XCTestExpectation(description: "DataSource should be updated with error on failure")
        let testError = NSError(domain: "TestError", code: 123, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])
        mockNetworkManager.shouldSucceed = false
        mockNetworkManager.mockError = testError

        viewModel.onPortfolioFetchError = { [weak self] errorMessage in
            guard let self = self else { return }
            XCTAssertEqual(self.viewModel.sectionsCount, 1)
            XCTAssertEqual(self.viewModel.numberOfRows(section: 0), 1)
            expectation.fulfill()
        }

        viewModel.loadPortfolio()
        wait(for: [expectation], timeout: 2.0)
    }

    func test_loadPortfolio_emptyPortfolio() {
        let expectation = XCTestExpectation(description: "DataSource should be empty when portfolio is empty")
        mockNetworkManager.shouldSucceed = true
        let emptyPortfolioResponse = PortfolioResponse(portfolio: Portfolio(balance: Balance(netValue: 0, pnl: 0, pnlPercentage: 0), positions: []))
        mockNetworkManager.mockResponse = emptyPortfolioResponse

        viewModel.onPortfolioFetchCompleted = { [weak self] in
            guard let self = self else { return }
            XCTAssertEqual(self.viewModel.sectionsCount, 1)
            XCTAssertEqual(self.viewModel.numberOfRows(section: 0), 0)
            expectation.fulfill()
        }

        viewModel.loadPortfolio()
        wait(for: [expectation], timeout: 2.0)
    }
}
