//
//  RealTimePriceViewModel.swift
//  TradingPortfolioApp_iOS
//
//  Created by Rathish on 16/06/2025.
//

import Foundation
import RxSwift

final class RealTimePriceViewModel: RealTimePriceViewModelContractor {

    private let initialPosition: Position
    private let livePriceSubject = BehaviorSubject<Double>(value: 0.0)
    private let disposeBag = DisposeBag()
    
    lazy var formattedMarketValue: Observable<String> = {
           livePriceSubject
               .map { [weak self] livePrice in
                   guard let self = self else { return CommonConstants.empty }
                   let marketValue = self.initialPosition.quantity * livePrice
                   return self.formatCurrency(value: marketValue,
                                              currencyCode: self.initialPosition.instrument.currency)
               }
               .share(replay: 1, scope: .whileConnected)
       }()
    
    init(initialPosition: Position) {
        self.initialPosition = initialPosition
        self.livePriceSubject.onNext(initialPosition.instrument.lastTradedPrice)
        startPriceSimulation()
    }

    private func startPriceSimulation() {
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.generateRandomPrice()
            })
            .disposed(by: disposeBag)
    }

    private func generateRandomPrice() {
        let basePrice = initialPosition.instrument.lastTradedPrice
        let deviation = basePrice * 0.10
        let randomFactor = Double.random(in: -1.0...1.0)
        let newPrice = basePrice + (deviation * randomFactor)
        livePriceSubject.onNext(newPrice)
    }
    
    private func formatCurrency(value: Double, currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        return formatter.string(from: NSNumber(value: value)) ?? "\(currencyCode) \(String(format: "%.2f", value))"
    }
}
