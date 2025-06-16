//
//  RealTimePriceViewModelTests.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

import XCTest
import RxSwift
import RxCocoa
@testable import TradingPortfolioApp_iOS

class RealTimePriceViewModelTests: XCTestCase {

    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        disposeBag = nil
        super.tearDown()
    }

    func test_formattedMarketValue_initialValue() {
        
        let initialInstrument = Instrument(ticker: "TEST",
                                           name: "Test Instrument",
                                           exchange: "EXCH",
                                           currency: "USD",
                                           lastTradedPrice: 100.0)
        
        let initialPosition = Position(instrument: initialInstrument,
                                       quantity: 5.0,
                                       averagePrice: 90.0,
                                       cost: 450.0,
                                       marketValue: 0.0,
                                       pnl: 0.0,
                                       pnlPercentage: 0.0)

        let viewModel = RealTimePriceViewModel(initialPosition: initialPosition)

        let expectation = XCTestExpectation(description: "Formatted market value should emit initial value")
        
        viewModel.formattedMarketValue
            .take(1)
            .subscribe(onNext: { formattedValue in
                let expectedValue = "$500.00"
                XCTAssertEqual(formattedValue, expectedValue)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 0.5)
    }

    func test_formattedMarketValue_updatesOverTime() {
        
        let initialInstrument = Instrument(ticker: "TEST",
                                           name: "Test Instrument",
                                           exchange: "EXCH",
                                           currency: "USD",
                                           lastTradedPrice: 100.0)
        
        let initialPosition = Position(instrument: initialInstrument,
                                       quantity: 5.0,
                                       averagePrice: 90.0,
                                       cost: 450.0,
                                       marketValue: 0.0,
                                       pnl: 0.0,
                                       pnlPercentage: 0.0)

        let viewModel = RealTimePriceViewModel(initialPosition: initialPosition)

        let initialValueExpectation = XCTestExpectation(description: "Initial value received")
        let updatedValueExpectation = XCTestExpectation(description: "Updated value received")
        var receivedValues: [String] = []

        viewModel.formattedMarketValue
            .subscribe(onNext: { value in
                receivedValues.append(value)
                if receivedValues.count == 1 { //TODO: check behavior subject in flutter
                    initialValueExpectation.fulfill()
                } else if receivedValues.count == 2 {
                    updatedValueExpectation.fulfill()
                }
            })
            .disposed(by: disposeBag)

        wait(for: [initialValueExpectation, updatedValueExpectation], timeout: 2.5)

        XCTAssertEqual(receivedValues.count, 2, "Should have received exactly two values (initial + first update)")
        XCTAssertNotEqual(receivedValues[0], receivedValues[1], "Second value should be different from the first (initial value)")
        XCTAssertTrue(receivedValues[1].starts(with: "$"), "Updated value should be currency formatted")
    }

    func test_formattedMarketValue_currencyFormatting() {
        
        let initialInstrumentEUR = Instrument(ticker: "EURTEST",
                                              name: "Euro Test",
                                              exchange: "EXCH",
                                              currency: "EUR",
                                              lastTradedPrice: 50.0)
        
        let initialPositionEUR = Position(instrument: initialInstrumentEUR,
                                          quantity: 10.0,
                                          averagePrice: 45.0,
                                          cost: 450.0,
                                          marketValue: 0.0,
                                          pnl: 0.0,
                                          pnlPercentage: 0.0)
        
        let viewModelEUR = RealTimePriceViewModel(initialPosition: initialPositionEUR)

        let expectationEUR = XCTestExpectation(description: "Formatted market value should be EUR currency")
        viewModelEUR.formattedMarketValue
            .take(1)
            .subscribe(onNext: { formattedValue in
                XCTAssertTrue(formattedValue.contains("€"), "Formatted value should contain Euro symbol")
                expectationEUR.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [expectationEUR], timeout: 0.5)

        let initialInstrumentGBP = Instrument(ticker: "GBPTEST",
                                              name: "Pound Test",
                                              exchange: "EXCH",
                                              currency: "GBP",
                                              lastTradedPrice: 75.0)
        
        let initialPositionGBP = Position(instrument: initialInstrumentGBP,
                                          quantity: 2.0,
                                          averagePrice: 70.0,
                                          cost: 140.0,
                                          marketValue: 0.0,
                                          pnl: 0.0,
                                          pnlPercentage: 0.0)
        
        let viewModelGBP = RealTimePriceViewModel(initialPosition: initialPositionGBP)

        let expectationGBP = XCTestExpectation(description: "Formatted market value should be GBP currency")
        viewModelGBP.formattedMarketValue
            .take(1)
            .subscribe(onNext: { formattedValue in
                XCTAssertTrue(formattedValue.contains("£"), "Formatted value should contain Pound symbol")
                expectationGBP.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [expectationGBP], timeout: 0.5)
    }
}
